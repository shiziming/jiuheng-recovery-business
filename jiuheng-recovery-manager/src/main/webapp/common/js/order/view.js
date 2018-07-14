var orderview = {};
orderview.pageId = '#order_index #view_index';
/**
 * 页面初始化函数
 */
orderview.inits = function() {
//	    var payCompanyId=$(view.pageId +" #payCompanyId").text();
//	    var payCompanyName=returnmoney.payCompanyName(payCompanyId);
//	    $(view.pageId +" #payCompanyName").html(payCompanyName);
//	   
//	    var saleCompanyId=$(view.pageId +" #saleCompanyId").text();
//	    var saleCompanyName=returnmoney.saleCompanyName(saleCompanyId);
//	    $(view.pageId +" #saleCompanyName").html(saleCompanyName);
//	   
//	    var shopId=$(view.pageId +" #shopId").text();
//	    var shopName=returnmoney.shopName(shopId);
//	    $(view.pageId +" #shopName").html(shopName);
//	   
//	    var goodId=$(orderview.pageId +" #goodId").text();
//	    var goodName=returnmoney.goodName(goodId);
//	    $(orderview.pageId +" #goodName").html(goodName);
};
/**
 * 从Panel页面返回到列表页面
 */
orderview.Return= function(){
	$(orderquery.viewpanel).panel('close');
	$(orderquery.list_panel).show();
};
orderview.view = function(xsfdh){
//	$(orderquery.list_panel).hide();
	$(orderquery.viewpanel).panel({title:'订单详情查看',href:"order/viewOrderInfo?xsfdh="+xsfdh});
	$(orderquery.viewpanel).panel('open');
};
orderview.inits();
