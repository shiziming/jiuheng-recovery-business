<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="user_list_page">
<!-- 用户查询列表-->
		<div id="user_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: 150px; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm" action="<%=request.getContextPath() %>/power/queryUserList" method="post">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 80px 0px 80px">
					<tr>
						<td width="10%" align="center">用户账号</td>
						<td width="5%"><input name="userAccount" type="text"
							placeholder="请输用户账号" class="span2" id="userAccountid"></td>
						<td width="5%"></td>
						<td width="10%" align="center">用户名称</td>
						<td width="5%"><input name="userName" type="text"
							placeholder="请输入用户名称" class="span2" id="userNameid"></td>
						<td width="5%"></td>
						<td width="10%" align="center">角色编码</td>
						<td width="5%"><input name="roleCode"
							type="text" placeholder="请输入角色编码" class="span2" id="roleCodeid"></td>
						<td width="5%"></td>
						<td width="10%"></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
					<tr>
						
						<td width="10%" align="center">用户状态</td>
						<td width="5%"><select id="statusid" name="status" class="easyui-combobox" style='width: 100%;'>
								<option value="">--请选择--</option>
								<option value="1">新增</option>
								<option value="2">异动</option>
								<option value="3">注销</option>
								<option value="4">解锁</option>
								<option value="5">锁定</option>
						</select></td>
						<td width="5%"></td>
						<td width="10%" align="center"></td>
						<td width="5%"></td>
						<td width="5%"></td>
						<td width="10%" align="right"><a href="#" id="query"
							class="easyui-linkbutton" iconCls="icon-search" onclick="queryByCondition()">查询</a></td>
						<td width="5%"></td>
						<td width="5%"></td>
						<td width="10%" align="left"></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false">
			<table id="user_list_dg"></table>
		</div>

	
	

</div>


<script type="text/javascript"	src="common/js/power/queryUser.js"></script>
