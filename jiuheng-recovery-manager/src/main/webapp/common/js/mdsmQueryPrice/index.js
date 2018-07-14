var mdsmQueryGoodsPrice = {};
mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page="#mdsmQueryGoodsPrice_Page";
mdsmQueryGoodsPrice.queryPriceResult=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #queryPriceResult";
mdsmQueryGoodsPrice.saleOrgCode=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #saleOrgCode";
mdsmQueryGoodsPrice.skuId=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #skuId";
mdsmQueryGoodsPrice.beginDate=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #beginDate";
mdsmQueryGoodsPrice.endDate=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #endDate";
mdsmQueryGoodsPrice.priceType=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #priceType";
mdsmQueryGoodsPrice.brand=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #brand";
mdsmQueryGoodsPrice.categroyCode=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #categroyCode";
mdsmQueryGoodsPrice.priceBeginDate=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #priceBeginDate";
mdsmQueryGoodsPrice.priceEndDate=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #priceEndDate";
mdsmQueryGoodsPrice.shopCode=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #shopCode";
mdsmQueryGoodsPrice.brandCode=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #brandCode";
mdsmQueryGoodsPrice.validityPrice=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #validityPrice";
mdsmQueryGoodsPrice.toolbar=mdsmQueryGoodsPrice.mdsmQueryGoodsPrice_Page+" #toolbar";
/**
 * 页面初始化函数
 */
mdsmQueryGoodsPrice.inits = function() {
	$(mdsmQueryGoodsPrice.queryPriceResult).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination : true,
		pageSize : 20,
		fitColumns:true,
		singleSelect:true,
		toolbar:mdsmQueryGoodsPrice.toolbar,
		url : '',
		columns : [ [{
			field : 'seqId',
			title : '售价流水号',
			align:'left',	
			width : 80,
			hidden:true
		},{
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
			field : 'shopCode',
			title : '门店代码',
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
			field : 'status',
			title : '是否失效',
			align:'left',
			width : 60,
			formatter:function(value){ 
				if (value == '-1') {
					return '已失效';
				} else if (value >= '0') {
					return '有效';
				}
			}
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
	if (priceType == 'ZP53') {
		return '长期价格';
	} else if (priceType == 'ZP54') {
		return '期间价格';
	}
}

$(mdsmQueryGoodsPrice.categroyCode).combotree({
	data : [{
		pid : '',
		id : '',
		text : '全部',
		state : "closed"	
	}],
	onBeforeExpand : function(node) {
		if (node.children && node.children.length) {
			return;
		};
		$(this).tree('append', {
			parent : node.target,
			data : $.o2m.getCategroyChildren(node.id)
		});
	}
});

mdsmQueryGoodsPrice.excel=function(){
	var saleOrgCode=$(mdsmQueryGoodsPrice.saleOrgCode).val();
	var skuId=$(mdsmQueryGoodsPrice.skuId).val();
	var brand=$(mdsmQueryGoodsPrice.brand).val();
	var category=$(mdsmQueryGoodsPrice.categroyCode).val();
	var endDate=$(mdsmQueryGoodsPrice.endDate).datetimebox('getValue');
	var beginDate=$(mdsmQueryGoodsPrice.beginDate).datetimebox('getValue');
	var priceEndDate=$(mdsmQueryGoodsPrice.priceEndDate).datetimebox('getValue');
	var priceBeginDate=$(mdsmQueryGoodsPrice.priceBeginDate).datetimebox('getValue');
	var priceType = $(mdsmQueryGoodsPrice.priceType).combobox("getValue");
	var shopCode=$(mdsmQueryGoodsPrice.shopCode).val();
	window.location.href="mdsmQueryPrice/downloadGoodsPrice?saleOrgCode="+saleOrgCode+"&beginDate="+beginDate+"&skuId="+skuId+"&endDate="+endDate+"&priceType="+priceType+"&shopCode="+shopCode;
}
 
mdsmQueryGoodsPrice.query=function(){
	var saleOrgCode=$(mdsmQueryGoodsPrice.saleOrgCode).combobox("getValue");
	var skuId=$(mdsmQueryGoodsPrice.skuId).val();
	var brand=$(mdsmQueryGoodsPrice.brand).val();
	var brandCode=$(mdsmQueryGoodsPrice.brandCode).val();
	var category=$(mdsmQueryGoodsPrice.categroyCode).combotree('getValue');
	var shopCode=$(mdsmQueryGoodsPrice.shopCode).val();
	var endDate=$(mdsmQueryGoodsPrice.endDate).datetimebox('getValue');
	var beginDate=$(mdsmQueryGoodsPrice.beginDate).datetimebox('getValue');
	var priceEndDate=$(mdsmQueryGoodsPrice.priceEndDate).datetimebox('getValue');
	var priceBeginDate=$(mdsmQueryGoodsPrice.priceBeginDate).datetimebox('getValue');
	var priceType = $(mdsmQueryGoodsPrice.priceType).combobox("getValue");
	var validityPrice = $(mdsmQueryGoodsPrice.validityPrice).combobox("getValue");
	if(0<=skuId.indexOf("，")){
		$.messager.alert('提示','请输入英文逗号','info');
		return false;
	}
	/*if(priceType!='ZP53'){
	if(beginDate==null||beginDate==''){
		$.messager.alert('提示','请输入查询失效期开始时间','inof');
		return false;
	}
	if(endDate==null||endDate==''){
		$.messager.alert('提示','请输入查询失效期结束时间','inof');
		return false;
	}
	}*/
	$(mdsmQueryGoodsPrice.queryPriceResult).datagrid({
		queryParams: {
			saleOrgCode:saleOrgCode,
			skuId:skuId,
			endDate:endDate,
			priceType:priceType,
			beginDate:beginDate,
			shopCode:shopCode,
			brand:brand,
			category:category,
			priceEndDate:priceEndDate,
			priceBeginDate:priceBeginDate,
			status:validityPrice,
			brandCode:brandCode
		},
		url:'mdsmQueryPrice/queryList'
		});
}

mdsmQueryGoodsPrice.inits();