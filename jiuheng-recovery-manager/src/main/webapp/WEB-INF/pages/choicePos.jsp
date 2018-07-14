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
</head>
	<body>
	<div id="win" class="easyui-window" title="登陆O2M系统" data-options="modal:true,draggable : false,closable : false,
		iconCls:'icon-save'" style="width:500px;height:200px;padding:10px;">
		<form id="form" action="loginByAccountAndPos" method="post">
			<p align="center" style="margin-top: 50px">
			<input type="hidden" value="${account }" name ="account">
					请选择岗位:
				<select id="positionId" class="easyui-combobox" name="positionId" style="width:200px;" 
					data-options="editable:false" >
					 <c:forEach var="position" items="${positions}">
						<option value="${position.GWDM}">${position.GWMC}</option>
				    </c:forEach>
				</select>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="subLoginForm()">确定</a> 
			</p>
		</form>
	</div>
		<script>
			$('#win').window('open');  
			function subLoginForm(){
				$('#form').submit();
			}
		</script>
	</body>
</html>