<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="QuerydastoragePage">
<!-- 带安商品库存设置单查询列表 -->
	<div id="storage_list_panel" class="easyui-panel">
		<div id="storage_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 80px 0px 80px">
					<tr>
						<td width="100px" align="center">分销渠道</td>
						<td width="100px">
						    <input  class="easyui-textbox" name="saleChannel" type="text" required="required">
						</td>
						<td width="100px" align="center">商品内码</td>
						<td width="100px"><input  class="easyui-textbox" name="skuId" type="text" required="required"></td>
						<td width="100px" align="center">门店代码</td>
						<td width="100px"><input  class="easyui-textbox" name="shopId" type="text"></td>
					    <td width="10%" align="right"><a href="#" id="storage_list_query"
							class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
						<td width="10%" align="right"><a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
							onclick="storage.back();">返回</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
	</div>
</div>

<script type="text/javascript"	src="common/js/dastorage/storage.js"></script>
