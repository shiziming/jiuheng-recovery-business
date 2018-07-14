var CommissionQueryUtils = {};

//初始化
CommissionQueryUtils.inits = function(){
	
};

CommissionQueryUtils.doQuery = function(){
	var datagridId = "#commissionPage_dg";
	var winId = "#commissionPage_search";

	var saleOrgCode = $('#saleOrgCodeQuery').val();
	var status = $("#statusQueryPage").combobox('getValue');

	$(winId).window('close');
	$(datagridId).datagrid({"queryParams":{'status':status, 'saleOrgCode':saleOrgCode} });

};


CommissionQueryUtils.inits();