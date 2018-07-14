var mdsmOrderview = {};
/**
 * 页面初始化函数
 */
mdsmOrderview.inits = function() {

};
/**
 * 从Panel页面返回到列表页面
 */
mdsmOrderview.Return= function(){
	$(mdsmOrderQuery.viewpanel).panel('close');
	$(mdsmOrderQuery.list_panel).show();
};
mdsmOrderview.view= function(xsfdh,xsddh){
	$(mdsmOrderQuery.list_panel).hide();
	$(mdsmOrderQuery.viewpanel).panel({title:'订单详情查看',href:"mdsmQueryOrder/viewOrderInfo?xsfdh="+xsfdh+"&xsddh="+xsddh});
	/*$(mdsmOrderQuery.viewpanel).panel('open');*/
};
mdsmOrderview.inits();
