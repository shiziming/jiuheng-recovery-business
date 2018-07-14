var downMessageShow = {};
downMessageShow.pageId = '#downMessageShow';
downMessageShow.but=downMessageShow.pageId+" #but";
downMessageShow.xmlHtml=downMessageShow.pageId+" #xmlHtml";

downMessageShow.iFrameReSize111=function(iframename){
	var aa = document.getElementById(iframename);
	aa.height ="600px";
}
downMessageShow.back=function(){
	$(amazonUploadInterfaceShow.downMessage).hide();
	$(amazonUploadInterfaceShow.pageId).show();
}

