var splc_indexGoodSpuName = {};
indexGoodSpuNameMagnifierWindowPageId="#indexGoodSpuNameMagnifierWindow11";
splc_indexGoodSpuName.btnReturn='#backbtn';
splc_indexGoodSpuName.salAgencyCodeId=indexGoodSpuNameMagnifierWindowPageId+" #salAgencyCodeId";
splc_indexGoodSpuName.i=indexGoodSpuNameMagnifierWindowPageId+" #i";
/**
 * 页面初始化函数
 */
splc_indexGoodSpuName.inits = function() {
	var salAgencyCode=$(splc_indexGoodSpuName.salAgencyCodeId).val();
	$('#spuName').datagrid({
		striped : true,
		rownumbers : true,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:splc_indexGoodSpuName.btnReturn,
		url : "wareFloor/skuFind?xszzdm="+$('#indexGoodSpuNameMagnifierWindow11 #xszzdm').val()+"&xsqddm="+$('#indexGoodSpuNameMagnifierWindow11 #xsqddm').val(),
		queryParams: {
			salAgencyCode:salAgencyCode
		},
		columns : [ [{
			field : 'SKUDM',
			title : 'SKUID',
			align:'left',
			width : 80
		},{
			field : 'SPMC',
			title : 'SKU名称',
			align:'left',
			width : 80
		}] ]
	});
}
function serchSpuName(){
	var salAgencyCode=$(splc_indexGoodSpuName.salAgencyCodeId).val();
	var spuName=$('#spuNameId').val();
	var spuCode=$('#spuCodeId').val();
	var xszzdm=$('#indexGoodSpuNameMagnifierWindow11 #xszzdm').val();
	var xsqddm=$('#indexGoodSpuNameMagnifierWindow11 #xsqddm').val();
//	alert(xszzdm);
//	alert(xsqddm);
	$('#spuName').datagrid({
		url:'wareFloor/skuFind',
		queryParams: {
			name:spuName,
			skuCode:spuCode,
			xszzdm:xszzdm,
			xsqddm:xsqddm
		}
	});
}

splc_indexGoodSpuName.returnToListPage=function(){
	var i=$(splc_indexGoodSpuName.i).val();
	if(null!=i&&""!=i){
	 $('#magnifier').window('close');
	}else{
		 $('#magnifier_SpuName_window').window('close');
	}
}
$('#spuName').datagrid({
onDblClickRow: function(rowIndex, rowData){
	var i=$(splc_indexGoodSpuName.i).val();
	if(null!=i&&""!=i){
	$(splc_goods_up.dgId).datagrid('acceptChanges');
		var row = $(splc_goods_up.dgId).datagrid('getRows')[i];
		var materials = $(splc_goods_up.dgId).datagrid('getRows');
//		for(var j = materials.length-1;j>= 0;j--){
//			if(rowData.code==materials[j].code){
//				$.messager.alert('警告','该商品已添加，请选其他商品添加！','info');
//				return false;
//			}
//		}
	}
	
	//alert("skuCode="+rowData.skuCode+"name="+rowData.name);
	row.code = rowData.SKUDM;
	row.skuName = rowData.SPMC;
	row.skuId = rowData.SKUID;
    $('#magnifier').window('close');
    $(splc_goods_up.dgId).datagrid('updateRow',{
		index : parseInt(i),
		row : row
	});
    if(row.showNum == undefiend || row.showNum == ''){
    	$(splc_goods_up.dgId).datagrid('beginEdit',i);
    }
	
}
})

splc_indexGoodSpuName.inits();