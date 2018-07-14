var gmzxOrderview = {};
/**
 * 页面初始化函数
 */
gmzxOrderview.inits = function() {

};
/**
 * 从Panel页面返回到列表页面
 */
gmzxOrderview.Return= function(){
	$(gmzxOrderquery.viewpanel).panel('close');
	$(gmzxOrderquery.list_panel).show();
};
gmzxOrderview.view= function(xsfdh){
	$(gmzxOrderquery.list_panel).hide();
	$(gmzxOrderquery.viewpanel).panel({title:'订单详情查看',href:"gmzxOrder/viewOrderInfo?xsfdh="+xsfdh});
	$(gmzxOrderquery.viewpanel).panel('open');
};
gmzxOrderview.inits();
