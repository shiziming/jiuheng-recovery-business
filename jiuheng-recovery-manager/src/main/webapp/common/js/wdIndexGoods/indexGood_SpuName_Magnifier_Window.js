var indexGoodSpuName = {};
indexGoodSpuNameMagnifierWindowPageId="#indexGoodSpuNameMagnifierWindow";
indexGoodSpuName.btnReturn='#backbtn';
indexGoodSpuName.salAgencyCodeId=indexGoodSpuNameMagnifierWindowPageId+" #salAgencyCodeId";
indexGoodSpuName.i=indexGoodSpuNameMagnifierWindowPageId+" #i";
/**
 * 页面初始化函数
 */
indexGoodSpuName.inits = function() {
	var salAgencyCode=$(indexGoodSpuName.salAgencyCodeId).val();
	$('#spuName').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:indexGoodSpuName.btnReturn,
		url : "wdIndexGoodsController/queryspuNameList",
		queryParams: {
			salAgencyCode:salAgencyCode
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
			title : '关键字',
			align:'center',
			width : 100,
		},{
			field : 'model',
			title : '商品类型',
			align:'left',
			hidden:true,
			width : 80
		}] ]
	});
}
function serchSpuName(){
	var salAgencyCode=$(indexGoodSpuName.salAgencyCodeId).val();
	var spuName=$('#spuNameId').val();
	var spuCode=$('#spuCodeId').val();
	var keyWord=$('#keyWord').val();
	$('#spuName').datagrid({
		url:'wdIndexGoodsController/queryspuNameList',
		queryParams: {
			name:spuName,
			code:spuCode,
			salAgencyCode:salAgencyCode,
			keyWord:keyWord
		}
	});
}

indexGoodSpuName.returnToListPage=function(){
	var i=$(indexGoodSpuName.i).val();
	if(null!=i&&""!=i){
	 $('#magnifier').window('close');
	}else{
		 $('#magnifier_SpuName_window').window('close');
	}
}
$('#spuName').datagrid({
onDblClickRow: function(rowIndex, rowData){
	var i=$(indexGoodSpuName.i).val();
	if(null!=i&&""!=i){
		$(indexGoods_add.dgId).datagrid('acceptChanges');
		var salAgencyCode=$(indexGoodSpuName.salAgencyCodeId).val();
		var row = $(indexGoods_add.dgId).datagrid('getRows')[i];
		var materials = $(indexGoods_add.dgId).datagrid('getRows');
		for(var j = materials.length-1;j>= 0;j--){
			if(rowData.code==materials[j].code||rowData.keyWord == materials[j].keyWord){
				$.messager.alert('警告','该商品已添加或该品牌已存在，请选其他商品添加！','info');
				return false;
			}
		}
		row.code = rowData.code;
		row.name = rowData.name;
		row.id = rowData.id;
		row.keyWord = rowData.keyWord;
	    $('#magnifier').window('close');
	    $(indexGoods_add.dgId).datagrid('updateRow',{
			index : parseInt(i),
			row : row
		});
	    if(row.showNum == 'undefiend' || row.showNum == ''){
	    	$(indexGoods_add.dgId).datagrid('beginEdit',i);
	    }
	}else{
		 $('#magnifier_SpuName_window').window('close');
		    $(indexGoodAddDetail.spuIdID).searchbox('setValue', rowData.id);
			$(indexGoodAddDetail.spuCodeID).textbox('setValue', rowData.code);
			$(indexGoodAddDetail.spuNameID).textbox('setValue', rowData.name);
			$(indexGoodAddDetail.keyWord).textbox('setValue', rowData.keyWord);
			$(indexGoodAddDetail.spuModelId).textbox('setValue',rowData.model);
	}
}
})

indexGoodSpuName.inits();