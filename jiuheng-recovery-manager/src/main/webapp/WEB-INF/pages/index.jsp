<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp"%>
<%@ include file="inc/resource.inc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>久恒回收管理系统</title>
<meta content="text/html; charset=utf-8" http-equiv=Content-Type>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="${ctx}/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/js/jquery.ztree.all-3.5.min.js"></script>
<style type="text/css">
	a:hover {
	 	font-weight: bold
	}
	.ztree {padding:0px 5px 0px 0px;}
	.ztree li a.level0 {width:100%;height: 20px; text-align: center; display:block; background-color: #eff5ff; border:1px silver solid;}
	.ztree li a.level0.cur {background-color: #eff5ff;}
	.ztree li a.level0 span {display: block; color: #0e2d5f; padding-top:3px; font-size:12px; font-weight: bold;word-spacing: 2px;}
	.ztree li a.level0 span.button {	float:right; margin-left: 10px; visibility: visible;display:none;}
	.ztree li span.button.switch.level0 {display:none;}
	
    #top{width: 100%;height: 80px;background: url(images/banner.png) no-repeat center center;}
   	#_top{margin: 0 50px;}
   	#logo{height: 75px;width: 78px;float: left;margin: 2px 0;background: url(images/user/background.jpg) no-repeat center center;}
   	#exit{height: 32px;width: 32px;float: right;margin-top: 40px;background: url(images/exit.png) no-repeat center center;cursor: pointer;}
</style>
</head>
<body class="easyui-layout">
	<div id="top" data-options="region:'north',border:false">
		<div id="_top">
			<div id="logo"></div>
			<div id="exit" onclick="$.o2m.logout();"></div>
		</div>
	</div>
	<div id="center" data-options="region:'center'">
		<div id="tabs" class="easyui-tabs" fit="true" border="false"
			plain="true">
			<div title="首页" style="font-size: 20px; padding: 10px">
				<div class="easyui-panel" data-options="border:false"
					style="font-size: 25px;"> ${ sessionScope.user.userName}，欢迎进入久恒回收管理平台! </div>
			</div>
		</div>
	</div>

	<div id="west" data-options="region:'west',split:true,title:'操作菜单'">
		<div class="zTreeDemoBackground left">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
	</div>
    <!-- 放大镜窗口  -->
    <div id="magnifier_window"></div>
	<div id="footer" data-options="region:'south',split:false">Copyright
		© 2015 国美O2M系统</div>
	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="close">关闭</div>
		<div id="closeall">全部关闭</div>
		<div id="closeother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="closeright">当前页右侧全部关闭</div>
		<div id="closeleft">当前页左侧全部关闭</div>
	</div>
  	<script type="text/javascript" src="common/js/index.js"></script>
  	<script type="text/javascript" src="common/js/dateFormat.js"></script>
</body>

</html>