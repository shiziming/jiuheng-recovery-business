<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="popShopMapPage">
	<div id="listPanel"> 
		<table id="dg" title="POP平台门店对照查询"></table>
		<div id="tb" style="height: auto">
			<div class="search" style="padding: 5px 10px">
				<form id="searchForm">
					<table style="width: auto;">
						<tr>
							<td align="center" width="115px">POP平台门店代码:</td>
							<td class="content"><input name="popShopCode" /></td>
							<td align="center" width="115px">POP平台仓库代码:</td>
							<td class="content"><input name="popStorageCode" /></td>
						</tr>
						<tr>
							<td class="label">渠道代码:</td>
							<td class="content"><input name="channelCode" /></td>
							<td class="label">门店代码:</td>
							<td class="content"><input name="shopCode" /></td>
							<td class="label">录入日期:</td>
							<td class="content" colspan="3"><input
								class="easyui-datebox" name="startTime" /> 至 <input
								class="easyui-datebox" name="endTime" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
				<a id="btnSearch" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">查 询</a> <a
					id="btnUpload" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">下载模板</a>
				<c:if test="${FUNC_IMPORT}">
					<a id="btnImport" href="javascript:void(0)"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">批量导入</a>
				</c:if>
				<c:if test="${FUNC_EXPORT}">
					<a id="btnExport" href="javascript:void(0)"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true">批量导出</a>
				</c:if>

				<c:if test="${FUNC_MAINTAIN}">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true"
						onclick="popShopMap.append()">添加</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-edit',plain:true"
						onclick="popShopMap.edit()">编辑</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true"
						onclick="popShopMap.accept()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true"
						onclick="popShopMap.removeit()">删除</a>
				</c:if>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="common/js/popShopMap/index.js"></script>
