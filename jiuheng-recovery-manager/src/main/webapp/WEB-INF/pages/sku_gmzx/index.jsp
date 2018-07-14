<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="skuGmzxPage">
	<div id="listPanel" class="easyui-panel">
		<div class="easyui-panel" title="查询条件" style="height: 70px ">
			<form id="searchForm">
				<table style="width: auto; padding: 5px">
					<tr>
						<td class="label" width="80px" align="center">SKU编码:</td>
						<td class="content" width="80px" align="center"><input
							class="easyui-numberbox" name="skuId" /></td>
						<td class="label" width="80px" align="center">SKU名称:</td>
						<td class="content" width="80px" align="center"><input
							class="easyui-textbox" name="skuName" /></td>
						<td class="label" width="80px" align="center">分类编码:</td>
						<td class="content" width="80px" align="center"><input
							class="easyui-textbox" name="categoryCode" /></td>
						<td class="label" width="80px" align="center">分类名称:</td>
						<td class="content" width="80px" align="center"><input
							class="easyui-textbox" name="categoryName" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="tb" >
			<a id="btnSearch" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-search',plain:true">查 询</a> <a
				id="btnDynamicSearch" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-search',plain:true">动态查询</a>
			<c:if test="${FUNC_MAINTAIN}">
				<a id="btnPicAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">上传图片</a>
			</c:if>
			<c:if test="${FUNC_EXPORT}">
				<a id="btnExport" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-save',plain:true">导出</a>
				<a id="btnDynamicExport" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-save',plain:true">动态导出</a>
			</c:if>
		</div>
		<div id="dgs" data-options="border:false">
			<table id="dg"></table>
		</div>
	</div>
	<div id="editPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
</div>

<script type="text/javascript" src="common/js/sku_gmzx/index.js"></script>
