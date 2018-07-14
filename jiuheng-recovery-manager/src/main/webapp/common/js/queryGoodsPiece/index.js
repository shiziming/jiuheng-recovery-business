var queryGoodsPrice = {};
queryGoodsPrice.queryGoodsPrice_Page="#queryGoodsPrice_Page";
queryGoodsPrice.queryPriceResult=queryGoodsPrice.queryGoodsPrice_Page+" #queryPriceResult";
queryGoodsPrice.saleOrgCode=queryGoodsPrice.queryGoodsPrice_Page+" #saleOrgCode";
queryGoodsPrice.skuId=queryGoodsPrice.queryGoodsPrice_Page+" #skuId";
queryGoodsPrice.beginDate=queryGoodsPrice.queryGoodsPrice_Page+" #beginDate";
queryGoodsPrice.endDate=queryGoodsPrice.queryGoodsPrice_Page+" #endDate";
queryGoodsPrice.priceType=queryGoodsPrice.queryGoodsPrice_Page+" #priceType";
queryGoodsPrice.toolbar=queryGoodsPrice.queryGoodsPrice_Page+" #toolbar";
/**
 * 页面初始化函数
 */
queryGoodsPrice.inits = function() {
	$(queryGoodsPrice.queryPriceResult).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination : true,
		pageSize : 20,
		fitColumns:true,
		singleSelect:true,
		toolbar:queryGoodsPrice.toolbar,
		url : '',
		columns : [ [{
			field : 'skuId',
			title : 'SKU编码',
			align:'left',
			width : 80
		},{
			field : 'skuName',
			title : 'SKU名称',
			align:'left',
			width : 80
		},{
			field : 'category',
			title : '品类',
			align:'left',
			width : 80
		},{
			field : 'saleOrgCode',
			title : '销售组织',
			align:'left',
			width : 80
		},{
			field : 'priceType',
			title : '价格类型',
			align:'left',
			width : 80,
			formatter:function(value, row, index){ 
            	return priceTypeVal(row.priceType);
			}
		},{
			field : 'price',
			title : '销售价格',
			align:'left',
			width : 60
		},{
			field : 'seqId',
			title : '条件记录号',
			align:'left',
			width : 60
		},{
			field : 'beginDate',
			title : '价格生效日期',
			align:'left',
			width : 60
		},{
			field : 'endDate',
			title : '价格失效日期',
			align:'left',
			width : 60
		}] ]
	});
}
function priceTypeVal(priceType){
	if (priceType == 'ZP43') {
		return '期间价';
	} else if (priceType == 'ZP44') {
		return '长期价';
	} else if (priceType == 'ZP45') {
		return '爆款价格集采';
	} else if (priceType == 'ZP46') {
		return '爆款价格地采';
	} 
}

queryGoodsPrice.excel=function(){
	var saleOrgCode=$(queryGoodsPrice.saleOrgCode).val();
	var skuId=$(queryGoodsPrice.skuId).val();
	var endDate=$(queryGoodsPrice.endDate).datetimebox('getValue');
	var beginDate=$(queryGoodsPrice.beginDate).datetimebox('getValue');
	var priceType = $(queryGoodsPrice.priceType).combobox("getValue");
	window.location.href="queryGoodsPiece/downloadGoodsPrice?saleOrgCode="+saleOrgCode+"&beginDate="+beginDate+"&skuId="+skuId+"&endDate="+endDate+"&priceType="+priceType;
}
 
queryGoodsPrice.query=function(){
	var saleOrgCode=$(queryGoodsPrice.saleOrgCode).val();
	var skuId=$(queryGoodsPrice.skuId).val();
	var endDate=$(queryGoodsPrice.endDate).datetimebox('getValue');
	var beginDate=$(queryGoodsPrice.beginDate).datetimebox('getValue');
	var priceType = $(queryGoodsPrice.priceType).combobox("getValue");
	if(beginDate==null||beginDate==''){
		$.messager.alert('提示','请输入查询失效期开始时间','inof');
		return false;
	}
	if(endDate==null||endDate==''){
		$.messager.alert('提示','请输入查询失效期结束时间','inof');
		return false;
	}
	$(queryGoodsPrice.queryPriceResult).datagrid({
		queryParams: {
			saleOrgCode:saleOrgCode,
			skuId:skuId,
			endDate:endDate,
			priceType:priceType,
			beginDate:beginDate
		},
		url:'queryGoodsPiece/queryList'
		});
}

queryGoodsPrice.inits();