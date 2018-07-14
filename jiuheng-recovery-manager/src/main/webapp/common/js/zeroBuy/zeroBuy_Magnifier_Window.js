var zeroBuyMagnifierManage = {};
zeroBuyMagnifierManage_Pageid="#activityMagnifierWindow";
zeroBuyMagnifierManage.btnReturn=zeroBuyMagnifierManage_Pageid+' #backbtn';
zeroBuyMagnifierManage.activityId=zeroBuyMagnifierManage_Pageid+" #activityId";
zeroBuyMagnifierManage.activityName=zeroBuyMagnifierManage_Pageid+" #activityName";
/**
 * 页面初始化函数
 */
zeroBuyMagnifierManage.inits = function() {
	var salAgencyCode=$(zeroBuyMagnifierManage.salAgencyCode).val();
	$('#activity').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:zeroBuyMagnifierManage.btnReturn,
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
	var activityId=$(zeroBuyMagnifierManage.activityId).val();
	var activityName=$(zeroBuyMagnifierManage.activityName).val();
	$('#activity').datagrid({
		url:'zeroBuy/queryActivity',
		queryParams: {
			activityId:activityId,
			activityName:activityName
		}
	});
}

zeroBuyMagnifierManage.returnToListPage=function(){
	 $('#magnifier').window('close');
}

$('#activity').datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $('#magnifier').window('close');
		 $(zeroBuy_add.activityId).textbox('setText', rowData.activityId);
		 $(zeroBuy_add.activityName).textbox('setText', rowData.activityName);
		 $(zeroBuy_add.endDate).datebox('setValue',rowData.endDate);
		 $(zeroBuy_add.startDate).datebox('setValue',rowData.startDate);
		 $(zeroBuy_add.endDateId).val(rowData.endDate);
		 $(zeroBuy_add.startDateId).val(rowData.startDate);
}
})

zeroBuyMagnifierManage.inits();