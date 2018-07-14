var uploadMessageShow = {};

uploadMessageShow.pageId = '#uploadMessageShow';
uploadMessageShow.but=uploadMessageShow.pageId+" #but";
uploadMessageShow.xmlHtml=uploadMessageShow.pageId+" #xmlHtml";

uploadMessageShow.iFrameReSize=function(iframename){
	var pTar = document.getElementById(iframename);
	pTar.height = "600px";
}
uploadMessageShow.back=function(){
	$(amazonUploadInterfaceShow.uploadMessage).hide();
	$(amazonUploadInterfaceShow.pageId).show();
}

