<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="jobPowerPage">
	<!-- 根据职务编码查询权限-->
	<input type="hidden" value="${userId}" id="userId">
	<div>
		<div id="but1" style="display: none;">
				<a href="javascript:void(0);" class="easyui-linkbutton" id="but"
				   data-options="iconCls:'icon-add',plain:true"
				   onclick="addfunction();">添加功能</a>
		</div>
		<div id="dg2"></div>
	</div>

	<!-- 添加功能页面 -->
	<div id="addFunctionView"></div>
</div>
<script type="text/javascript">


	function addfunction(){
		var userId = $('#userId').val();
		$('#addFunctionView').window({
			width: 500,
			height: 300,
			modal: true,
			method:'get',
			href: "power/addFunction?userId="+userId+"&currtime=" + new Date(),
			title: "添加职位功能"
		});


	}

</script>
<script type="text/javascript" src="common/js/power/jobPower.js"></script>