var hotModel = {};
hotModelMagnifierWindowPageId="#hotModelMagnifierWindow";
hotModel.serchHotModel = hotModelMagnifierWindowPageId +" #serchHotModel";
hotModel.hotModelDataGrid = "#hotModelDataGrid";
hotModel.goods_search_form = hotModelMagnifierWindowPageId +" #goods_search_form";
hotModel.row =hotModelMagnifierWindowPageId +" #row";

/**
 * 页面初始化函数
 */
hotModel.inits = function() {
	$(hotModel.serchHotModel).click(loadGoodsList);
	$(hotModel.hotModelDataGrid).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		url : "goods/getGoodsList",
		columns : [ [{
			field : 'id',
			title : 'ID',
			align:'left',
			width : 80
		},{
			field : 'categoryPathName',
			title : '分类',
			align:'left',
			width : 80
		},{
			field : 'brandName',
			title : '品牌',
			align:'left',
			width : 80
		},{
			field : 'model',
			title : '型号',
			align:'center',
			width : 100,
		}] ]
	});
}
$(hotModel.hotModelDataGrid).datagrid({
onDblClickRow: function(rowIndex, rowData){
	$(hotModel_add.dgId).datagrid('acceptChanges');
	var i=$(hotModel.row).val();
	var row = $(hotModel_add.dgId).datagrid('getRows')[i];
	var materials = $(hotModel_add.dgId).datagrid('getRows');
	for(var j = materials.length-1;j>= 0;j--){
		if(rowData.id==materials[j].goodsId){
			$.messager.alert('警告','该商品已添加，请选其他商品添加！','info');
			return false;
		}
	}
	row.goodsId = rowData.id;
	row.goodsName = rowData.model;
	$('#magnifier').window('close');
	$(hotModel_add.dgId).datagrid('updateRow',{
		index : parseInt(i),
		row : row
	});
	if(typeof(row.recoveryAveragePrice)=='undefined' || row.recoveryAveragePrice == ''){
		$(hotModel_add.dgId).datagrid('beginEdit',i);
	}
}
})
function loadGoodsList(){
	$(hotModel.hotModelDataGrid).datagrid("load", $(hotModel.goods_search_form).serializeObject());
}
hotModel.inits();