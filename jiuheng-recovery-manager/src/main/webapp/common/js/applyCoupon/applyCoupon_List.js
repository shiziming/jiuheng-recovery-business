var applyCouponManage = {};
applyCouponManage.applyCoupon_list_page="#applyCoupon_list_page";
applyCouponManage.applyCoupon_list_list_panel="#applyCoupon_list_list_panel";
applyCouponManage.searchAndAuditing="#searchs";
applyCouponManage.update=applyCouponManage.applyCoupon_list_page+" #update";
applyCouponManage.add=applyCouponManage.applyCoupon_list_page+" #add";
applyCouponManage.applyCoupon_list_dg=applyCouponManage.applyCoupon_list_page+" #applyCoupon_list_dg";
applyCouponManage.VIEW=applyCouponManage.applyCoupon_list_page+" #VIEW";
applyCouponManage.MAINTAIN=applyCouponManage.applyCoupon_list_page+" #MAINTAIN";
/**
 * 页面初始化函数
 */
applyCouponManage.inits = function() {
	var VIEW=$(applyCouponManage.VIEW).val();
	var MAINTAIN=$(applyCouponManage.MAINTAIN).val();
	$(applyCouponManage.applyCoupon_list_dg).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination : true,
		pageSize : 20,
		fitColumns:true,
		singleSelect:true,
		url : 'applyCoupon/queryList',
		columns : [ [{
			field : 'orderNum',
			title : '单据编号',
			align:'left',
			width : 80
		},{
			field : 'promotionCode',
			title : '促销活动号',
			align:'left',
			width : 80
		},{
			field : 'orderAgencyCode',
			title : '单据机构代码',
			align:'left',
			width : 80
		},{
			field : 'sceneType',
			title : '活动场景类型',
			align:'left',
			width : 80
		},{
			field : 'channelCode',
			title : '渠道代码',
			align:'left',
			width : 80
		},{
			field : 'beginTime',
			title : '开始时间',
			align:'left',
			width : 80
		},{
			field : 'endTime',
			title : '结束时间',
			align:'left',
			width : 80
		},{
			field : 'monthDayList',
			title : '每月日集合',
			align:'left',
			width : 80
		},{
			field : 'weekDayList',
			title : '每周日集合',
			align:'left',
			width : 80
		},{
			field : 'dayTimeList',
			title : '每天时段集合',
			align:'left',
			width : 80
		},{
			field : 'creatUserName',
			title : '制单人名称',
			align:'left',
			width : 80
		},{
			field : 'creatTime',
			title : '制单时间',
			align:'left',
			width : 145
		},{
			field : 'auditingPeopleName',
			title : '审核人',
			align:'left',
			width : 60
		},{
			field : 'auditingTime',
			title : '审核时间',
			align :'center',
			width : 145
		},{
			field : 'status',
			title : '状态',
			align :'center',
			width : 80
		},{
			field : 'action',
			title : '操作',
			width : 120,
			align:'left',
			formatter : function(value, row, index) {
				if(row.status=='已录入'){
					if(VIEW&&MAINTAIN){
						return '<a href="#" onclick="applyCouponManage.view(\'' + row.orderNum + '\');">查看</a>'+
						 ' <a href="#" onclick="applyCouponManage.edit(\'' + row.orderNum + '\',\''+ row.promotionCode + '\');">修改</a>'+
							' <a href="#" onclick="applyCouponManage.del(\'' + row.orderNum + '\');">删除</a>';
					}
					if(VIEW){
						return '<a href="#" onclick="applyCouponManage.view(\'' + row.orderNum + '\');">查看</a>';
					}
				}
				if(row.status=='已审核'){	
					return '<a href="#" onclick="applyCouponManage.view(\'' + row.orderNum + '\');">查看</a>';
				}
			}
		}] ]
	});
}
/**
 * 打开查看页面
 */
applyCouponManage.view = function(orderNum){
	$(applyCouponManage.applyCoupon_list_list_panel).hide();
	$(applyCouponManage.searchAndAuditing).panel({href:"applyCoupon/toSearcherDetailedWindow?orderNum="+orderNum});
	$(applyCouponManage.searchAndAuditing).show();
};
/**
 * 删除
 */
applyCouponManage.del=function(orderNum){
	var isok=confirm("确认删除此数据么？");
	if(isok){
	$.ajax({
        type:"POST", 
        url:"applyCoupon/deleteOrder",
        data:"orderNum="+orderNum,
        success:function(data){
        	if(data.code==0){
        		$(applyCouponManage.applyCoupon_list_dg).datagrid({url : 'applyCoupon/queryList'});
	        	$.messager.alert('提示',data.msg,'info');
        	}else if(data.code==1){
        		$.messager.alert('警告',data.msg,'worm');
        	}
        }
    }); 
	}
}

/**
 * 返回到列表页面
 */
applyCouponManage.returnToListPage = function() {
	$(applyCouponManage.add).panel('close');
	$(applyCouponManage.applyCoupon_list_list_panel).show();
	$(applyCouponManage.applyCoupon_list_dg).datagrid('reload')
}

/**
 * 查询
 */
applyCouponManage.query = function(){
	var orderNum=$('#orderNumId').val();
	var creatUserName=$('#creatUserNameId').val();
	var promotionCode=$('#promotionCodeId').val();
	var status = $('#statusId').combobox("getValue");
	var sceneType = $('#sceneTypeId').combobox("getValue");
	var createStartTime=$('#createStartTimeId').datetimebox('getValue');
	var createEndTime=$('#createEndTimeId').datetimebox('getValue');
	var checkStartTime=$('#checkStartTimeId').datetimebox('getValue');
	var checkEndTime=$('#checkEndTimeId').datetimebox('getValue');
	$(applyCouponManage.applyCoupon_list_dg).datagrid({
		queryParams: {
			orderNum:orderNum,
			creatUserName:creatUserName,
			promotionCode:promotionCode,
			status:status,
			createStartTime:createStartTime,
			createEndTime:createEndTime,
			checkStartTime:checkStartTime,
			checkEndTime:checkEndTime,
			sceneType:sceneType
		},
		url:'applyCoupon/queryList'
		});
}
/**
 * 新增申请
 */
applyCouponManage.applyCoupon=function(){
		$(applyCouponManage.applyCoupon_list_list_panel).hide();
		$(applyCouponManage.add).panel({title:'新增申请单', href:"applyCoupon/openAddWindow"});
		$(applyCouponManage.add).panel('open');
}


/**
 * 修改促销活动
 */
applyCouponManage.edit=function(orderNum,promotionCode){
	$(applyCouponManage.applyCoupon_list_list_panel).hide();
	$(applyCouponManage.update).panel({title:"修改申请单",href:"applyCoupon/openUpdateApplyCouponWindow?orderNum="+orderNum+"&promotionCode="+promotionCode});
	$(applyCouponManage.update).panel('open');
}



applyCouponManage.inits();