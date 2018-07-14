var amazonOrderview = {};
/**
 * 页面初始化函数
 */
amazonOrderview.inits = function() {

};
/**
 * 从Panel页面返回到列表页面
 */
amazonOrderview.Return= function(){
	$(amazonOrderquery.viewpanel).panel('close');
	$(amazonOrderquery.list_panel).show();
};
amazonOrderview.view= function(xsfdh){
	$(amazonOrderquery.list_panel).hide();
	$(amazonOrderquery.viewpanel).panel({title:'订单详情查看',href:"amazonOrder/viewOrderInfo?xsfdh="+xsfdh});
	$(amazonOrderquery.viewpanel).panel('open');
};
amazonOrderview.inits();
