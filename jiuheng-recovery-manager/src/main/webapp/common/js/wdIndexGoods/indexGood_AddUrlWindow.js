var indexGoodAddUrl = {};
indexGoodAddUrl.pageId="#indexGoods_AddUrl_Page";
indexGoodAddUrl.orderNum=indexGoodAddUrl.pageId+" #orderNum";
indexGoodAddUrl.url=indexGoodAddUrl.pageId+" #url";
indexGoodAddUrl.goodsSPUID=indexGoodAddUrl.pageId+" #goodsSPUID";

/**
 * 返回列表页面
 */
indexGoodAddUrl.returnToListPage=function(){
	var orderNum=$(indexGoodAddUrl.orderNum).val();
	$(indexGoods_detailed.add_panel).panel('close');
	$(indexGoods_detailed.indexGoods_list_detailed_form).show();
	$(indexGoods_detailed.dgId).datagrid({url : "wdIndexGoodsController/getIndexGoodsDetail?orderNum="+orderNum})
}
indexGoodAddUrl.submit=function(){
	var url=$(indexGoodAddUrl.url).val();
	if(url.lastIndexOf("http://")<0 && url.lastIndexOf("https://")<0){
		$.messager.alert("警告","链接前请添加'http://'或'https://'","info");
		return false;
	}
	if(url.lastIndexOf("http://")==0||url.lastIndexOf("https://")==0){
	}else{
		$.messager.alert("警告","链接格式不正确","info");
		return false;
	}
	var orderNum=$(indexGoodAddUrl.orderNum).val();
	var goodsSPUID=$(indexGoodAddUrl.goodsSPUID).val();
	$.ajax({
		url:"wdIndexGoodsController/addUrl",
		data:{url:url,orderNum:orderNum,goodsSPUID:goodsSPUID},
		success:function(data){
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
		
	})
}
