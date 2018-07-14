<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="findCategoryPage">
	<div id="listPanel">
			<table id="dg" title="商品分类查询"></table>
			<div id="tb" style="height: auto">
				<div class="search">
					<form id="searchForm">
						<table style="width: auto">
							<tr>
								<td class="label">类目:</td>
								<td class="content">
									<ul id="categroyCode" class="easyui-combotree" style="width: 150px"></ul>
								</td>
								<td class="label">属性:</td>
								<td class="content">
									<input name="attrName" />
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="toolbar">
					<a id="btnSearch"
							class="easyui-linkbutton"
							data-options="iconCls:'icon-search',plain:true">查 询</a>
							<c:if test="${FUNC_EXPORT}">
					<a id="btnExport" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-save',plain:true">导出</a>
					</c:if>
				</div>
			</div>
	</div>
</div>

<script type="text/javascript"	src="common/js/findcategory/index.js"></script>

