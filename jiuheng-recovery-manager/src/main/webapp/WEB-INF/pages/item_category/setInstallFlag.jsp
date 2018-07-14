<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style type="text/css">
</style>

<div id="setInstallFlagPage">
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
				id="btnInstall" class="easyui-linkbutton"
				data-options="iconCls:'icon-save',plain:true">安装</a>
		</div>

	</div>
	<table id="dg" title="商品类目"></table>
</div>

<script type="text/javascript">
	var installFlag = {};
	installFlag.pageId = '#setInstallFlagPage';
	installFlag.dgId = installFlag.pageId + ' #dg';
	installFlag.toolBar = installFlag.pageId + ' #tb';

	installFlag.inits = function() {
		$(installFlag.dgId).datagrid({
			singleSelect : false,
			selectOnCheck : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			fitColumns : true,
			pagination : true,
			pageSize : 20,
			toolbar : installFlag.toolBar,
			url : 'itemCategories/list?flag='+0,
			columns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				field : 'code',
				title : '编码',
				width : 30
			}, {
				field : 'name',
				title : '名称',
				width : 30
			}, {
				field : 'installFlag',
				title : '安装标记',
				width : 30,
				formatter : function(value, row) {
					if (value) {
						return "<span>是</span>";
					} else {
						return "<span  style='color:red'>否</span>";
					}
				}
			} ] ],
			loadMsg : "数据加载中...",
			onLoadSuccess : function(data) {
				$(this).datagrid('doCellTip', {
					'max-width' : '300px',
					'delay' : 500
				});

			}
		});
	};
	// 查询按钮
	$(installFlag.pageId + ' #btnSearch').on('click', function(event) {
		var searchObj = $.o2m.serializeObject($(installFlag.pageId + " #searchForm"));
		searchObj.hasQuery = 1;
		$(installFlag.dgId).datagrid("load", searchObj);
	});
	// 设置安装
	$(installFlag.pageId + ' #btnInstall').on('click', function(event) {
		installFlag.checked(true);
	});
	installFlag.inits();
	installFlag.checked = function(flag) {
		var checkedItems = $(installFlag.dgId).datagrid('getChecked');
		var codes = [];
		$.each(checkedItems, function(index, item) {
			codes.push(item.code);
		});
		if (codes.length > 0) {
			$.get('itemCategories/setInstallFlag', {
				codes : codes.join(","),
				flag : flag
			}, function(data) {
				if ($.o2m.handleActionResult(data)) {
					$(installFlag.dgId).datagrid('reload');
				}
			});
		} else {
			$.messager.alert('提示', '请选择类目！', 'info');
		}
	};
</script>
