var itemCategories = {};
itemCategories.pageId = '#itemCategoryPage';
itemCategories.dgId = itemCategories.pageId + ' #dg';
itemCategories.toolBar = itemCategories.pageId + ' #tb';
itemCategories.listId = itemCategories.pageId + ' #listPanel';
itemCategories.panelId = itemCategories.pageId + ' #editPanel';

/**
 * 页面初始化函数
 */
itemCategories.inits = function() {

	$(itemCategories.dgId).datagrid({
		height : $.o2m.centerHeight - 20,
		width : '100%',
		singleSelect : false,
		selectOnCheck : true,
		checkOnSelect : true,
		striped : true,
		rownumbers : true,
		fitColumns : true,
		pagination : true,
		pageSize : 20,
		toolbar : itemCategories.toolBar,
		url : 'itemCategories/list?flag='+1,
		columns : [ [ {
			field : 'ck',
			checkbox : true
		}, {
			field : 'code',
			title : '编码',
			width : 50
		}, {
			field : 'name',
			title : '名称',
			width : 50
		}, {
			field : 'installFlag',
			title : '安装标记',
			width : 50,
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

			/*
			 * if (data) { $.each(data.rows, function(index, item) { if
			 * (item.checked) { $(this).datagrid('checkRow', index); } }); }
			 */
		}
	});

};

// 查询按钮
$(itemCategories.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(itemCategories.pageId + " #searchForm"));
	searchObj.hasQuery = 1;
	$(itemCategories.dgId).datagrid("load", searchObj);
});
// 设置安装
$(itemCategories.pageId + ' #btnAdd').on('click', function(event) {

	$.o2m.openMagnifierWindow('添加需安装类目', 'icon-save', '600px', '400px', 'itemCategories/toSetInstallFlag');

	$('#magnifier_window').window({
		onClose : function() {
			$(itemCategories.dgId).datagrid('reload');
		}
	});

});
// 设置不安装
$(itemCategories.pageId + ' #btnDel').on('click', function(event) {
	itemCategories.checked(false);
});

itemCategories.checked = function(flag) {
	var checkedItems = $(itemCategories.dgId).datagrid('getChecked');
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
				$(itemCategories.dgId).datagrid('reload');
			}
		});
	} else {
		$.messager.alert('提示', '请选择类目！', 'info');
	}
};

itemCategories.inits();
