<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="downMessageShow">	
	<div id="but">
		<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="downMessageShow.back();">返回</a>
	</div>
	<div id="xmlHtml">
		<iframe src="${amazonInterface.downFilePath}" scrolling="yes" width="100%" height="100%" frameborder="0" id="downMainFrame" onload='downMessageShow.iFrameReSize111("downMainFrame");'></iframe>
	</div>
</div>
<script type="text/javascript" src="common/js/amazon/downMessageShow.js"></script>
