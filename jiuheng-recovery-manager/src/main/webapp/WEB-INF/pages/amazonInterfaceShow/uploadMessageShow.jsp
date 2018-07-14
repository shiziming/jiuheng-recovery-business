<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="uploadMessageShow">	
	<div id="but">
		<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="uploadMessageShow.back();">返回</a>
	</div>
	<div id="xmlHtml">
		<iframe src="${amazonInterface.upFilePath}" scrolling="yes" width="100%" height="100%" frameborder="0" id="mainFrame" onload='uploadMessageShow.iFrameReSize("mainFrame");'></iframe>
	</div>
</div>
<script type="text/javascript" src="common/js/amazon/uploadMessageShow.js"></script>
