var zeroBuyNewMagnifierManage = {};
zeroBuyNewMagnifierManage_Pageid="#newActivityMagnifierWindow";
zeroBuyNewMagnifierManage.btnReturn=zeroBuyNewMagnifierManage_Pageid+' #backbtn';
zeroBuyNewMagnifierManage.activityId=zeroBuyNewMagnifierManage_Pageid+" #activityId";
zeroBuyNewMagnifierManage.activityName=zeroBuyNewMagnifierManage_Pageid+" #activityName";
zeroBuyNewMagnifierManage.activity=zeroBuyNewMagnifierManage_Pageid+" #activity";
/**
 * 页面初始化函数
 */
zeroBuyNewMagnifierManage.inits = function() {
	var salAgencyCode=$(zeroBuyNewMagnifierManage.salAgencyCode).val();
	$(zeroBuyNewMagnifierManage.activity).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:zeroBuyNewMagnifierManage.btnReturn,
		url : "zeroBuy/queryActivity",
		queryParams: {
			salAgencyCode:salAgencyCode
		},
		columns : [ [{
			field : 'activityId',
			title : '活动号',
			align:'left',
			width : 80
		},{
			field : 'activityName',
			title : '活动名称',
			align:'left',
			width : 80
		},{
			field : 'startDate',
			title : '开始时间',
			align:'left',
			width : 80
		},{
			field : 'endDate',
			title : '结束时间',
			align:'left',
			width : 80
		}] ]
	});
}
function serchSkuName(){
	var activityId=$(zeroBuyNewMagnifierManage.activityId).val();
	var activityName=$(zeroBuyNewMagnifierManage.activityName).val();
	$(zeroBuyNewMagnifierManage.activity).datagrid({
		url:'zeroBuy/queryActivity',
		queryParams: {
			activityId:activityId,
			activityName:activityName
		}
	});
}

zeroBuyNewMagnifierManage.returnToListPage=function(){
	 $('#magnifier_Activity_window').window('close');
}

$(zeroBuyNewMagnifierManage.activity).datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $('#magnifier_Activity_window').window('close');
		 $(zeroBuyUpdateDetail.activityId).textbox('setText', rowData.activityId);
		 $(zeroBuyUpdateDetail.activityName).textbox('setText', rowData.activityName);
		 $(zeroBuyUpdateDetail.startDate).datebox("setValue", rowData.startDate);
		 $(zeroBuyUpdateDetail.endDate).datebox("setValue", rowData.endDate);
		 $(zeroBuyUpdateDetail.beginDateId).val(rowData.startDate);
		 $(zeroBuyUpdateDetail.endDateId).val(rowData.endDate);
}
})

zeroBuyNewMagnifierManage.inits();