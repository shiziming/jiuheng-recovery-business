var applyCouponMagnifierManage = {};
applyCouponMagnifierManage_Pageid="#activityMagnifierPage";
applyCouponMagnifierManage.btnReturn=applyCouponMagnifierManage_Pageid+' #backbtn';
applyCouponMagnifierManage.activityId=applyCouponMagnifierManage_Pageid+" #activityId";
applyCouponMagnifierManage.activityName=applyCouponMagnifierManage_Pageid+" #activityName";
/**
 * 页面初始化函数
 */
applyCouponMagnifierManage.inits = function() {
	$('#applyCouponActivity').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:applyCouponMagnifierManage.btnReturn,
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
function serchSkuName(){
	var activityId=$(applyCouponMagnifierManage.activityId).val();
	var activityName=$(applyCouponMagnifierManage.activityName).val();
	$('#applyCouponActivity').datagrid({
		url:"applyCoupon/queryActivity",
		queryParams: {
			activityId:activityId,
			activityName:activityName
		}
	});
}

applyCouponMagnifierManage.returnToListPage=function(){
	 $('#addApplyCouponMagnifier').window('close');
}

$('#applyCouponActivity').datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $(applyCoupon_add.activityId).textbox('setValue', rowData.activityId);
		 $(applyCoupon_add.activityName).textbox('setValue', rowData.activityName);
		 $(applyCoupon_add.startDate).datebox('setValue',rowData.startDate);
		 $(applyCoupon_add.endDate).datebox('setValue',rowData.endDate);
		 $(applyCoupon_add.endDateId).val(rowData.endDate);
		 $(applyCoupon_add.startDateId).val(rowData.startDate);
		 $('#addApplyCouponMagnifier').window('close');
}
})

applyCouponMagnifierManage.inits();