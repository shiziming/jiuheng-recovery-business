<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="dastoragePage">
    <input id="func_check" type="hidden" value="${FUNC_CHECK}"/>
	<input id="func_maintain" type="hidden" value="${FUNC_MAINTAIN}"/>
<!-- 带安商品库存设置单查询列表 -->
	<div id="dastorage_list_panel" class="easyui-panel">
		<div id="dastorage_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 80px 0px 80px">
					<tr>
						<td width="10%" align="center">单据编号</td>
						<td width="5%"><input name="billId" type="text"
							placeholder="请输入单据编号" class="easyui-textbox"></td>
						<td width="5%"></td>
						<!-- <td width="10%" align="center">公司代码</td>
						<td width="5%"><input name="companyCode" type="text"
							placeholder="请输入录入人代码" class="easyui-textbox"></td>
						<td width="5%"></td> -->
						<td width="10%" align="center">状态</td>
						<td width="5%"><select id="status" name="status" class="easyui-combobox" style='width: 100%;'>
								<option value="0" selected="selected">已录入</option>
								<option value="1">已审核</option>
						</select></td>
						 <td width="5%"></td>
						<td width="10%"></td>
						<td width="30%"></td> 
					</tr>
					<tr>
						<td width="10%" align="center">录入日期</td>
						<td ><input id="ksrq" style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="createStartTime" type="text" />至
							<input id="jsrq" style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="createEndTime" type="text" /></td>
						<td width="5%"></td>
						<td width="10%" align="center">审核日期</td>
						<td width="5%"><input id="ksrq" style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="checkStartTime" type="text" />至
							<input id="jsrq" style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="checkEndTime" type="text" /></td>
						<td width="5%"></td>
						<td width="10%" align="right"><a href="#" id="dastorage_list_query"
							class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="tb" style="display: none;">
				    <a id="btnUpload" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true" >下载模板</a>
					<a id="btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">批量导入</a>
					<a id="query_storage" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">查询库存</a>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
	</div>

	
	<!-- 带安商品库存设置单明细查看界面 -->
	<div class="easyui-panel" id="view_panel" style="display:block"></div>
	
	<!-- 新增，修改带安商品库存设置单明细 -->
	<div class="easyui-panel" id="up_panel" style="display:block"></div>
	
	<!-- 导入带安商品库存设置单明细 -->
	<div class="easyui-panel" id="import_panel" style="display:block"></div>
	
	<!-- 查询带安库存 -->
	<div class="easyui-panel" id="storage_panel" style="display:block"></div>
</div>


<script type="text/javascript"	src="common/js/dastorage/index.js"></script>
