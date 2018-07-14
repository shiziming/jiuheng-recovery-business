var view = {};
view.pageId = '#view_index';
/**
 * 页面初始化函数
 */
view.inits = function() {
	    var payCompanyId=$(view.pageId +" #payCompanyId").text();
	    var payCompanyName=returnmoney.payCompanyName(payCompanyId);
	    $(view.pageId +" #payCompanyName").html(payCompanyName);
	   
	    var saleCompanyId=$(view.pageId +" #saleCompanyId").text();
	    var saleCompanyName=returnmoney.saleCompanyName(saleCompanyId);
	    $(view.pageId +" #saleCompanyName").html(saleCompanyName);
	   
	    var shopId=$(view.pageId +" #shopId").text();
	    var shopName=returnmoney.shopName(shopId);
	    $(view.pageId +" #shopName").html(shopName);
	   
	    var goodId=$(view.pageId +" #goodId").text();
	    var goodName=returnmoney.goodName(goodId);
	    $(view.pageId +" #goodName").html(goodName);
};
/**
 * 从Panel页面返回到列表页面
 */
view.Return= function(){
	$(returnmoney.viewpanel).panel('close');
	$(returnmoney.list_panel).show();
};
view.inits();
