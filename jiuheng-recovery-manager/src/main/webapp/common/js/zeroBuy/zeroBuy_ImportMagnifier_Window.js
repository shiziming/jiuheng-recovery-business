var zeroBuyImportMagnifier = {};
importMagnifierWindowPageId="#importMagnifierWindow";
zeroBuyImportMagnifier.btnReturn=importMagnifierWindowPageId+' #backbtn';
zeroBuyImportMagnifier.activityId=importMagnifierWindowPageId+" #activityId";
zeroBuyImportMagnifier.activityName=importMagnifierWindowPageId+" #activityName";
zeroBuyImportMagnifier.activity=importMagnifierWindowPageId+" #activity";
/**
 * 页面初始化函数
 */
zeroBuyImportMagnifier.inits = function() {
	var salAgencyCode=$(zeroBuyImportMagnifier.salAgencyCode).val();
	$(zeroBuyImportMagnifier.activity).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:zeroBuyImportMagnifier.btnReturn,
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
	var activityId=$(zeroBuyImportMagnifier.activityId).val();
	var activityName=$(zeroBuyImportMagnifier.activityName).val();
	$(zeroBuyImportMagnifier.activity).datagrid({
		url:'zeroBuy/queryActivity',
		queryParams: {
			activityId:activityId,
			activityName:activityName
		}
	});
}

zeroBuyImportMagnifier.returnToListPage=function(){
	 $('#importMagnifier').window('close');
}

$(zeroBuyImportMagnifier.activity).datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $('#importMagnifier').window('close');
		 $(zeroBuy_Import.promotionCode).textbox('setValue', rowData.activityId);
		 $(zeroBuy_Import.activityName).textbox('setValue', rowData.activityName);
		 $(zeroBuy_Import.beginDate).datebox("setValue", rowData.startDate);
		 $(zeroBuy_Import.endDate).datebox("setValue", rowData.endDate);
		 $(zeroBuy_Import.beginDateId).val(rowData.startDate);
		 $(zeroBuy_Import.endDateId).val(rowData.endDate);
}
})

zeroBuyImportMagnifier.inits();