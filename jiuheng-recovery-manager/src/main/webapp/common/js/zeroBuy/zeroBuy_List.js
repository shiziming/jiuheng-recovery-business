var zeroBuyManage = {};
zeroBuyManage.zeroBuy_list_page="#zeroBuy_list_page";
zeroBuyManage.zeroBuy_list_list_panel="#zeroBuy_list_list_panel";
zeroBuyManage.searchAndAuditing="#searchAndAuditing";
zeroBuyManage.update=zeroBuyManage.zeroBuy_list_page+" #update";
zeroBuyManage.add=zeroBuyManage.zeroBuy_list_page+" #add";
zeroBuyManage.zeroBuy_list_dg=zeroBuyManage.zeroBuy_list_page+" #zeroBuy_list_dg";
zeroBuyManage.VIEW=zeroBuyManage.zeroBuy_list_page+" #VIEW";
zeroBuyManage.MAINTAIN=zeroBuyManage.zeroBuy_list_page+" #MAINTAIN";
/**
 * 页面初始化函数
 */
zeroBuyManage.inits = function() {
	var VIEW=$(zeroBuyManage.VIEW).val();
	var MAINTAIN=$(zeroBuyManage.MAINTAIN).val();
	$(zeroBuyManage.zeroBuy_list_dg).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination : true,
		pageSize : 20,
		fitColumns:true,
		singleSelect:true,
		url : 'zeroBuy/queryList',
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
			field : 'salAgencyCode',
			title : '销售组织代码',
			align:'left',
			width : 80
		},{
			field : 'channelCode',
			title : '渠道代码',
			align:'left',
			width : 80
		},{
			field : 'beginDate',
			title : '开始日期',
			align:'left',
			width : 80
		},{
			field : 'endDate',
			title : '结束日期',
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
			field : 'endPeopleName',
			title : '终止人',
			align:'left',
			width : 80
		},{
			field : 'endTime',
			title : '终止时间',
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
						return '<a href="#" onclick="zeroBuyManage.view(\'' + row.orderNum + '\');">查看</a>'+
						 ' <a href="#" onclick="zeroBuyManage.editGoods(\'' + row.orderNum + '\',\''+ row.promotionCode + '\');">修改</a>'+
							' <a href="#" onclick="zeroBuyManage.del(\'' + row.orderNum + '\');">删除</a>';
					}
					if(VIEW){
						return '<a href="#" onclick="zeroBuyManage.view(\'' + row.orderNum + '\');">查看</a>';
					}
				}
				if(row.status=='已审核'||row.status=='已终止'||row.status=='审核不通过'){	
					return '<a href="#" onclick="zeroBuyManage.view(\'' + row.orderNum + '\');">查看</a>';
					
				}
			}
		}] ]
	});
}

zeroBuyManage.view = function(orderNum){
	$(zeroBuyManage.zeroBuy_list_list_panel).hide();
	$(zeroBuyManage.searchAndAuditing).panel({href:"zeroBuy/toSearcherDetailedWomdow?orderNum="+orderNum});
	$(zeroBuyManage.searchAndAuditing).show();
};
zeroBuyManage.del=function(orderNum){
	var isok=confirm("确认删除此数据么？");
	if(isok){
	$.ajax({
        type:"POST", 
        url:"zeroBuy/deleteOrder",
        data:"orderNum="+orderNum,
        success:function(data){
        	if(data.code==0){
        		$(zeroBuyManage.zeroBuy_list_dg).datagrid({url : 'zeroBuy/queryList'});
	        	$.messager.alert('提示',data.msg,'info');
        	}else if(data.code==1){
        		$.messager.alert('警告',data.msg,'worm');
        	}
        }
    }); 
	}
}
/**
 * 下载导入模板
 */
zeroBuyManage.downTemplate=function(){
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("促销零元购导入模板");
}

/**
 * 导入
 */

zeroBuyManage.Import=function(){
	$(zeroBuyManage.zeroBuy_list_list_panel).hide();
	$(zeroBuyManage.add).panel({title:'导入零元购活动及商品', href:"zeroBuy/openImportWindow"});
	$(zeroBuyManage.add).panel('open');
}

zeroBuyManage.aa=function(){
	window.location.href="code/aa";
};
/**
 * 返回到列表页面
 */
zeroBuyManage.returnToListPage = function() {
	$(zeroBuyManage.add).panel('close');
	$(zeroBuyManage.zeroBuy_list_list_panel).show();
	$(zeroBuyManage.zeroBuy_list_dg).datagrid('reload')
}


zeroBuyManage.query = function(){
	var orderNum=$('#orderNumId').val();
	var salAgencyCode=$('#salAgencyCodeId').val();
	var creatUserName=$('#creatUserNameId').val();
	var promotionCode=$('#promotionCodeId').val();
	var status = $('#statusId').combobox("getValue");
	var endStartTime=$('#endStartTime').datetimebox('getValue');
	var endEndTime=$('#endEndTime').datetimebox('getValue');
	var createStartTime=$('#createStartTimeId').datetimebox('getValue');
	var createEndTime=$('#createEndTimeId').datetimebox('getValue');
	var checkStartTime=$('#checkStartTimeId').datetimebox('getValue');
	var checkEndTime=$('#checkEndTimeId').datetimebox('getValue');
	$(zeroBuyManage.zeroBuy_list_dg).datagrid({
		queryParams: {
			orderNum:orderNum,
			salAgencyCode:salAgencyCode,
			creatUserName:creatUserName,
			promotionCode:promotionCode,
			status:status,
			createStartTime:createStartTime,
			createEndTime:createEndTime,
			checkStartTime:checkStartTime,
			checkEndTime:checkEndTime,
			endEndTime:endEndTime,
			endStartTime:endStartTime
		},
		url:'zeroBuy/queryList'
		});
}
/**
 * 新增促销活动
 */
zeroBuyManage.addActivity=function(){
		$(zeroBuyManage.zeroBuy_list_list_panel).hide();
		$(zeroBuyManage.add).panel({title:'新增促销活动', href:"zeroBuy/openAddWindow"});
		$(zeroBuyManage.add).panel('open');
}


/**
 * 修改促销活动
 */
zeroBuyManage.editGoods=function(orderNum,promotionCode){
	$(zeroBuyManage.zeroBuy_list_list_panel).hide();
	$(zeroBuyManage.update).panel({title:"修改促销活动",href:"zeroBuy/toUpdatezeroBuyWomdow?orderNum="+orderNum+"&promotionCode="+promotionCode});
	$(zeroBuyManage.update).panel('open');
}



zeroBuyManage.inits();