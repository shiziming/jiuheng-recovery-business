var indexGoodSpuName1 = {};
indexGoodSpuNameMagnifierWindowPageId1="#indexGoodSpuNameMagnifierWindow1";
indexGoodSpuName1.btnReturn='#backbtn';
indexGoodSpuName1.orderNumId=indexGoodSpuNameMagnifierWindowPageId1+" #orderNumId";
/**
 * 页面初始化函数
 */
indexGoodSpuName1.inits = function() {
	var orderNum=$(indexGoodSpuName1.orderNumId).val();
	$('#spuName1').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:indexGoodSpuName1.btnReturn,
		url : "wdIndexGoodsController/queryspuNameList1",
		queryParams: {
			orderNum:orderNum
		},
		columns : [ [{
			field : 'id',
			title : '商品SPUID',
			align:'left',
			hidden:true,
			width : 80
		},{
			field : 'code',
			title : '商品SPU编码',
			align:'left',
			width : 80
		},{
			field : 'name',
			title : '商品名称',
			align:'left',
			width : 80
		},{
			field : 'keyWord',
			title : '搜索关键词',
			align:'left',
			width : 80
		},{
			field : 'model',
			title : '商品类型',
			align:'left',
			hidden:true,
			width : 80
		}] ]
	});
}
function serchSpuName1(){
	var spuName=$('#spuNameId').val();
	var spuCode=$('#spuCodeId').val();
	$('#spuName1').datagrid({
		url:'wdIndexGoodsController/queryspuNameList',
		queryParams: {
			name:spuName,
			code:spuCode
		}
	});
}

indexGoodSpuName1.returnToListPage=function(){
		 $('#magnifier_SpuName_window').window('close');
}
$('#spuName1').datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $('#magnifier_SpuName_window').window('close');
		    $(indexGoodAddDetail.spuIdID).searchbox('setValue', rowData.id);
			$(indexGoodAddDetail.spuCodeID).textbox('setValue', rowData.code);
			$(indexGoodAddDetail.spuNameID).textbox('setValue', rowData.name);
			$(indexGoodAddDetail.keyword).textbox('setValue', rowData.keyWord);
			$(indexGoodAddDetail.spuModelId).textbox('setValue',rowData.model);
	}
})

indexGoodSpuName1.inits();