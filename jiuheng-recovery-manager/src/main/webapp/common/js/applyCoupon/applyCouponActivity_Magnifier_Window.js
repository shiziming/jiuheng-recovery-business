var applyCouponActivityMagnifier = {};
applyCouponActivityMagnifier_Pageid="#applyCouponActivityMagnifierPage";
applyCouponActivityMagnifier.btnReturn=applyCouponActivityMagnifier_Pageid+' #backbtn';
applyCouponActivityMagnifier.activityId=applyCouponActivityMagnifier_Pageid+" #activityId";
applyCouponActivityMagnifier.activityName=applyCouponActivityMagnifier_Pageid+" #activityName";
/**
 * 页面初始化函数
 */
applyCouponActivityMagnifier.inits = function() {
	$('#applyCouponActivityMagnifier').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:applyCouponActivityMagnifier.btnReturn,
		url : "applyCoupon/queryActivity",
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
applyCouponActivityMagnifier.serchApplyCoupon=function(){
	var activityId=$(applyCouponActivityMagnifier.activityId).val();
	var activityName=$(applyCouponActivityMagnifier.activityName).val();
	$('#applyCouponActivityMagnifier').datagrid({
		url:"applyCoupon/queryActivity",
		queryParams: {
			activityId:activityId,
			activityName:activityName
		}
	});
}

applyCouponActivityMagnifier.returnToListPage=function(){
	 $('#applyCoupoonMagnifier_Activity_window').window('close');
}
$('#applyCouponActivityMagnifier').datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $(applyUpdate.activityId).textbox('setValue', rowData.activityId);
		 $(applyUpdate.activityName).textbox('setValue', rowData.activityName);
		 $(applyUpdate.beginTime).datebox('setValue',rowData.startDate);
		 $(applyUpdate.endTime).datebox('setValue',rowData.endDate);
		 $(applyUpdate.beginTimeId).val(rowData.startDate);
		 $(applyUpdate.endTimeId).val(rowData.endDate);
		 $('#applyCoupoonMagnifier_Activity_window').window('close');
}
})
applyCouponActivityMagnifier.inits();