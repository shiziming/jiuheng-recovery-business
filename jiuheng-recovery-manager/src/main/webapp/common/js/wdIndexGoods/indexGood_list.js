var indexGoodsManage = {};
indexGoodsManage.indexGoods_list_page="#indexGoods_list_page";
indexGoodsManage.indexGoods_list_list_panel="#indexGoods_list_list_panel";
indexGoodsManage.searchAndAuditing="#searchAndAuditing";
indexGoodsManage.update=indexGoodsManage.indexGoods_list_page+" #update";
indexGoodsManage.add=indexGoodsManage.indexGoods_list_page+" #add";
indexGoodsManage.indexGoods_list_dg=indexGoodsManage.indexGoods_list_page+" #indexGoods_list_dg";
indexGoodsManage.VIEW=indexGoodsManage.indexGoods_list_page+" #VIEW";
indexGoodsManage.MAINTAIN=indexGoodsManage.indexGoods_list_page+" #MAINTAIN";
indexGoodsManage.CHECK=indexGoodsManage.indexGoods_list_page+" #CHECK";
/**
 * 页面初始化函数
 */
indexGoodsManage.inits = function() {
	/*var VIEW=$(indexGoodsManage.VIEW).val();
	var MAINTAIN=$(indexGoodsManage.MAINTAIN).val();
	var CHECK=$(indexGoodsManage.CHECK).val();*/
	$(indexGoodsManage.indexGoods_list_dg).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination : true,
		pageSize : 20,
		fitColumns:true,
		singleSelect:true,
		url : 'wdIndexGoodsController/queryList',
		columns : [ [{
			field : 'orderNum',
			title : '单据编号',
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
			field : 'publicDate',
			title : '计划发布日期',
			align:'left',
			width : 80
		},{
			field : 'creatUserName',
			title : '制单人名称',
			align:'left',
			width : 80
		},{
			field : 'creatDate',
			title : '制单时间',
			align:'left',
			width : 145
		},{
			field : 'auditingPeopleName2',
			title : '审核人',
			align:'left',
			width : 60
		},{
			field : 'auditingDate2',
			title : '审核时间',
			align :'center',
			width : 145
		},{
			field : 'auditingPeopleName',
			title : '图片审核人',
			align:'left',
			width : 80
		},{
			field : 'auditingDate',
			title : '图片审核时间',
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
				if(row.status=='未审核'||row.status=='已审核'){
					/*if(VIEW&&MAINTAIN&&CHECK){*/
						return '<a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">查看</a>'+
						 ' <a href="#" onclick="indexGoodsManage.editGoods(\'' + row.orderNum + '\');">修改</a>'+
							' <a href="#" onclick="indexGoodsManage.del(\'' + row.orderNum + '\');">删除</a>  <a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">审核</a>';
					/*}
					if(VIEW&&CHECK){
						return '<a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">查看</a>'+
						' <a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">审核</a>';
					}
					if(VIEW&&MAINTAIN){
						return '<a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">查看</a>'+
						 ' <a href="#" onclick="indexGoodsManage.editGoods(\'' + row.orderNum + '\');">修改</a>'+
							' <a href="#" onclick="indexGoodsManage.del(\'' + row.orderNum + '\');">删除</a>';
						}
					if(VIEW){
						return '<a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">查看</a>'
					}*/
				}else if(row.status=='图片已审核'){
					/*if(VIEW){*/return '<a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\')">查看</a>';/*}*/
				}
			}
		}] ]
	});
}

indexGoodsManage.view = function(orderNum){
	$(indexGoodsManage.indexGoods_list_list_panel).hide();
	$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+orderNum});
	$(indexGoodsManage.searchAndAuditing).show();
};
indexGoodsManage.del=function(orderNum){
	var isok=confirm("确认删除此数据么？");
	if(isok){
	$.ajax({
        type:"POST", 
        url:"wdIndexGoodsController/deleteOrder",
        data:"orderNum="+orderNum,
        success:function(data){
        	if(data.code==0){
        		$('#indexGoods_list_dg').datagrid({url : 'wdIndexGoodsController/queryList'});
	        	parent.$.messager.alert('提示','删除成功！','info');
        	}else if(data.code==1){
        		parent.$.messager.alert('警告','删除失败！','worm');
        	}
        }
    }); 
	}
}


/**
 * 返回到列表页面
 */
indexGoodsManage.returnToListPage = function() {
	$(indexGoodsManage.add).panel('close');
	$(indexGoodsManage.indexGoods_list_list_panel).show();
	$(indexGoodsManage.indexGoods_list_dg).datagrid('reload')
}


function query(){
	var orderNum=$('#orderNumId').val();
	var salAgencyCode=$('#salAgencyCodeId').val();
	var creatUserName=$('#creatUserNameId').val();
	var goodsSPUID=$('#goodsSPUIDId').val();
	var status = $('#statusId').combobox("getValue");
	var createStartTime=$('#createStartTimeId').datetimebox('getValue');
	var createEndTime=$('#createEndTimeId').datetimebox('getValue');
	var checkStartTime=$('#checkStartTimeId').datetimebox('getValue');
	var checkEndTime=$('#checkEndTimeId').datetimebox('getValue');
	$(indexGoodsManage.indexGoods_list_dg).datagrid({
		queryParams: {
			orderNum:orderNum,
			salAgencyCode:salAgencyCode,
			creatUserName:creatUserName,
			status:status,
			goodsSPUID:goodsSPUID,
			createStartTime:createStartTime,
			createEndTime:createEndTime,
			checkStartTime:checkStartTime,
			checkEndTime:checkEndTime
		},
		url:'wdIndexGoodsController/queryList'
		});
}

indexGoodsManage.addGoods=function(){
		$(indexGoodsManage.indexGoods_list_list_panel).hide();
		$(indexGoodsManage.add).panel({title:'新增首页商品', href:"wdIndexGoodsController/openAddWindow"});
		$(indexGoodsManage.add).panel('open');
}

indexGoodsManage.addHavenGoods=function(){
	var selectedRow = $(indexGoodsManage.indexGoods_list_dg).datagrid('getSelections');
	// 没选择数据时，显示告警，返回
	if (selectedRow.length != 1) {
		$.messager.show({
			title: '警告',
			msg: '请选择一条记录新增',
			showType: 'slide',
			timeout: 2000,
			style:{
				right:'',
				top:document.body.scrollTop+document.documentElement.scrollTop,
				bottom:''
			}
		});		
		return false;
	}
	var data = $(indexGoodsManage.indexGoods_list_dg).datagrid("getChecked")[0];
	if(data.status=='未审核'||data.status=='已审核'){
		$.messager.alert("提示","该数据图片未审核，不能添加","info");
		return false;
	}
		$(indexGoodsManage.indexGoods_list_list_panel).hide();
		$(indexGoodsManage.add).panel({title:'已有单据新增', href:"wdIndexGoodsController/openAddWindow?orderNum="+data.orderNum});
		$(indexGoodsManage.add).panel('open');
}

/**
 * 从上传图片页面回到主页面
 */
indexGoodsManage.returnToListIndex=function(){
	$('#uploadImage').panel('close');
	$(indexGoodsManage.indexGoods_list_list_panel).show();
}

indexGoodsManage.editGoods=function(orderNum){
	$(indexGoodsManage.indexGoods_list_list_panel).hide();
	$(indexGoodsManage.update).panel({title:"修改首页单据",href:"wdIndexGoodsController/toUpdateIndexGoodsWomdow?orderNum="+orderNum});
	$(indexGoodsManage.update).panel('open');
}

indexGoodsManage.maintainBranchHotGoods=function(){
	$(indexGoodsManage.indexGoods_list_list_panel).hide();
	$(indexGoodsManage.add).panel({title:'维护分部爆款', href:"wdIndexGoodsController/openAddWindow?flag="+1});
	$(indexGoodsManage.add).panel('open');
}

indexGoodsManage.inits();