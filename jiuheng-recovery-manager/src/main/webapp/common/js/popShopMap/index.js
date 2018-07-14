var popShopMap = {};

popShopMap.pageId = "#popShopMapPage";
popShopMap.dgId = popShopMap.pageId + " #dg";
popShopMap.toolBar = popShopMap.pageId + " #tb";

/**
 * 页面初始化函数
 */
popShopMap.inits = function() {
	$(popShopMap.dgId).datagrid({
		height : $.o2m.centerHeight - 20,
		striped : true,
		fitColumns : true,
		toolbar : popShopMap.toolBar,
		singleSelect : true,
		selectOnCheck : false,
		checkOnSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'popShopMap/list',
		columns : [ [ {
			field : 'ck',
			title : '',
			checkbox : true
		}, {
			field : 'channelCode',
			title : '渠道代码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'popShopCode',
			title : 'POP平台门店代码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'popStorageCode',
			title : 'POP平台仓库代码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'shopCode',
			title : '门店代码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'updateTime',
			title : '录入时间',
			align : 'center',
			width : 100
		} ] ],
		loadMsg : "数据加载中..."
	});
	$(popShopMap.dgId).datagrid('doCellTip', {
		delay : 500
	});
};

// 查询按钮
$(popShopMap.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(popShopMap.pageId + " #searchForm"));
	searchObj.hasQuery = 1;
	$(popShopMap.dgId).datagrid("load", searchObj);
});

popShopMap.handleImportResult = function(data) {
	$(popShopMap.dgId).datagrid({
		data : data
	});
};
// 导入按钮
$(popShopMap.pageId + ' #btnImport').on('click', function(event) {
	parent.$.modalDialog({
		title : '导入POP平台门店对照',
		width : 400,
		height : 250,
		closable : false,
		href : 'popShopMap/toImport?&fnName=popShopMap.handleImportResult',
		buttons : [ {
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		} ]
	});
});

// 导出按钮
$(popShopMap.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(popShopMap.pageId + " #searchForm"));
	window.open("popShopMap/exportExcel?" + $.param(searchObj));
});

// 下载模板
$(popShopMap.pageId + " #btnUpload").on("click", function() {
	window.location.href = "common/import/downLoadTemplate?templateName=" + encodeURI("POP平台门店对照模板");
});

// 编辑位置
popShopMap.editIndex = undefined;

// 添加一行
popShopMap.append = function() {
	$(popShopMap.dgId).datagrid('rejectChanges');
	$(popShopMap.dgId).datagrid('appendRow', {
		status : '1'
	});
	popShopMap.editIndex = $(popShopMap.dgId).datagrid('getRows').length - 1;
	$(popShopMap.dgId).datagrid('selectRow', popShopMap.editIndex).datagrid('beginEdit', popShopMap.editIndex);
};

// 编辑一行
popShopMap.edit = function() {
	popShopMap.editIndex = $(popShopMap.dgId).datagrid('getRowIndex', $(popShopMap.dgId).datagrid('getSelected'));
	$(popShopMap.dgId).datagrid('rejectChanges');
	if (popShopMap.editIndex >= 0) {
		$(popShopMap.dgId).datagrid('beginEdit', popShopMap.editIndex);
	}
};

// 删除
popShopMap.removeit = function() {
	var rows = $(popShopMap.dgId).datagrid('getChecked');
	if (rows) {
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push(row.channelCode + '-' + row.popShopCode + '-' + row.popStorageCode);
		});
		$.get('popShopMap/delete', {
			'ids' : ids.join(",")
		}, function(data) {
			if ($.o2m.handleActionResult(data)) {
				$(popShopMap.dgId).datagrid('reload');
			}
		});
	}
};

// 保存一行
popShopMap.accept = function() {
	if (popShopMap.editIndex != undefined) {
		$(popShopMap.dgId).datagrid('acceptChanges');
		var row = $(popShopMap.dgId).datagrid('getRows')[popShopMap.editIndex];
		if (row.channelCode == '' || row.popShopCode == '' || row.popStorageCode == '' || row.shopCode == '') {
			$.messager.alert('警告', '请检查是否有空值！', 'warning');
			$(popShopMap.dgId).datagrid('beginEdit', popShopMap.editIndex);
			return;
		} else {
			$.ajax({
				type : "POST",
				url : "popShopMap/createOrUpdate",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(row),
				success : function(msg) {
					if($.o2m.handleActionResult(msg)){
						$(popShopMap.dgId).datagrid('reload');
					}
				}
			});
		}
		popShopMap.editIndex = undefined;
	}
};

popShopMap.inits();
