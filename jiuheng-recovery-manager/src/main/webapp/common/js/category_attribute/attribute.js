var categoryAttr = {};

categoryAttr.pageId = '#attrPage';
categoryAttr.gridId = categoryAttr.pageId + ' #dataGrid';
categoryAttr.toolBar = categoryAttr.pageId + ' #tb';
categoryAttr.searchForm = categoryAttr.pageId + ' #searchForm';
categoryAttr.listId = categoryAttr.pageId + ' #listPanel';
categoryAttr.panelId = categoryAttr.pageId + ' #editPanel';
/**
 * 页面初始化函数
 */
categoryAttr.inits = function() {

	$(categoryAttr.gridId).datagrid(
			{
				title : "属性",
				url : "attribute/loadData",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : true,
				toolbar : categoryAttr.toolBar,
				columns : [ [
						{
							field : 'ck',
							checkbox : true,
						},
						{
							field : 'id',
							title : 'ID',
							width : 50,
							align : 'center'
						},
						{
							field : 'name',
							title : '属性名',
							width : 100,
							align : 'center',
							formatter : function(value, row, index) {
								return '<a id="view_' + index
										+ '" href="javascript:categoryAttr.toShowPage(' + row.id
										+ ');">' + value + '</a>';
							}
						}, {
							field : 'dataType',
							title : '数据类型',
							width : 50,
							align : 'center',
							formatter : function(value, row, index) {
								if (value == 1) {
									return "文本";
								} else if (value == 2) {
									return "数字";
								}
							}
						}, {
							field : 'chooseType',
							title : '选择类型',
							width : 50,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								if (value == 1) {
									return "单选";
								} else if (value == 2) {
									return "多选";
								} else if (value == 0) {
									return "手动输入";
								}
							}
						}, {
							field : 'values',
							title : '属性值',
							width : 80,
							align : 'center',
							formatter : function(value, row, index) {
								return value.join(',');
							}
						} ] ],
				loadMsg : "数据加载中..."
			});
};

// 条件查询
$(categoryAttr.pageId + " #btnSearch").on(
		"click",
		function() {
			$(categoryAttr.gridId).datagrid("load",
					$.o2m.serializeObject($(categoryAttr.searchForm)));
		});
// 添加
$(categoryAttr.pageId + " #btnAdd").on("click", function() {
	$(categoryAttr.listId).hide();
	$(categoryAttr.panelId).panel({title:'新增属性', href:"attribute/toAdd",height : $.o2m.centerHeight - 20});
	$(categoryAttr.panelId).panel('open');
});
categoryAttr.toShowPage = function(attrId){
	$(categoryAttr.listId).hide();
	$(categoryAttr.panelId).panel({title:'属性展示', href:"attribute/toShow?id="+attrId,height : $.o2m.centerHeight - 20});
	$(categoryAttr.panelId).panel('open');
}
// 修改
$(categoryAttr.pageId + " #btnEdit").on("click", function() {
	var row = $(categoryAttr.gridId).datagrid("getSelected");
	if (row) {
		$(categoryAttr.listId).hide();
		$(categoryAttr.panelId).panel({title:'修改属性', href:"attribute/toEdit?id="+row.id,height : $.o2m.centerHeight - 20});
		$(categoryAttr.panelId).panel('open');
	} else {
		$.messager.alert('警告', '请选择一条记录!', 'warning');
	}
});

// 删除
$(categoryAttr.pageId + " #btnDel").on("click", function() {
	var row = $(categoryAttr.gridId).datagrid("getSelected");
	if (row) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "attribute/delete",
					data : "id=" + row.id,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(categoryAttr.gridId).datagrid("reload");
						}
					}
				});
			}
		});
	} else {
		$.messager.alert('警告', '请选择一条记录!', 'warning');
	}
});

/**
 * 从Panel页面返回到列表页面
 */
categoryAttr.returnToListPage = function() {
	$(categoryAttr.panelId).panel('close');
	$(categoryAttr.listId).show();
}

categoryAttr.inits();
