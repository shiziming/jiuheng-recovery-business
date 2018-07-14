var gmplusOrderview = {};
/**
 * 页面初始化函数
 */
gmplusOrderview.inits = function() {

};
/**
 * 从Panel页面返回到列表页面
 */
gmplusOrderview.Return= function(){
	$(gmplusOrderQuery.viewpanel).panel('close');
	$(gmplusOrderQuery.list_panel).show();
};
gmplusOrderview.view= function(xsfdh,xsddh){
	$(gmplusOrderQuery.list_panel).hide();
	$(gmplusOrderQuery.viewpanel).panel({title:'订单详情查看',href:"gmplusOrder/viewOrderInfo?xsfdh="+xsfdh+"&xsddh="+xsddh});
	/*$(gmplusOrderQuery.viewpanel).panel('open');*/
};
gmplusOrderview.inits();
