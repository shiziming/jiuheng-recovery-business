<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style type="text/css">
</style>

<div id="itemCategoryPage">
	<div id="listPanel" class="easyui-panel" style="width: 100%">
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table style="width: auto">
						<tr>
							<td class="label">品类代码:</td>
							<td class="content"><input name="code" /></td>
							<td class="label">品类名称:</td>
							<td class="content"><input name="name" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
				<a id="btnSearch" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">查 询</a> <a
					id="btnAdd" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">安装</a><a id="btnDel"
					class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">不安装</a>
			</div>
		</div>
		<table id="dg" title="商品类目安装标记"></table>
	</div>
</div>
<script type="text/javascript"
	src="common/js/item_category/item_category.js"></script>