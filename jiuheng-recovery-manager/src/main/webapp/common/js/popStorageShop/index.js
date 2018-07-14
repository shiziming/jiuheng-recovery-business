var popStorageShop = {};

popStorageShop.pageId = "#popStorageShopPage";
popStorageShop.dgId = popStorageShop.pageId + " #dg";
popStorageShop.toolBar = popStorageShop.pageId + " #tb";

/**
 * 页面初始化函数
 */
popStorageShop.inits = function() {
	$(popStorageShop.dgId).datagrid({
		height : $.o2m.centerHeight - 20,
		striped : true,
		fitColumns : true,
		toolbar : popStorageShop.toolBar,
		singleSelect : true,
		selectOnCheck : false,
		checkOnSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'popStorageShop/list',
		columns : [ [ {
			field : 'ck',
			title : '',
			checkbox : true
		},{
			field : 'channelCode',
			title : '渠道代码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'storageCode',
			title : '仓库代码',
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
			field : 'is3C',
			title : '仓库3C标记',
			align : 'center',
			width : 100,
			formatter : function(value, row) {
				if (value) {
					return "<span>是</span>";
				} else {
					return "<span style='color:red'>否</span>";
				}
			},
			editor : {
				type : 'checkbox',
				options : {
					on : 1,
					off : 0
				}
			}
		}, {
			field : 'updateTime',
			title : '录入时间',
			align : 'center',
			width : 100
		} ] ],
		loadMsg : "数据加载中..."
	});
	$(popStorageShop.dgId).datagrid('doCellTip', {
		delay : 500
	});
};

// 查询按钮
$(popStorageShop.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(popStorageShop.pageId + " #searchForm"));
	searchObj.hasQuery = 1;
	$(popStorageShop.dgId).datagrid("load", searchObj);
});

popStorageShop.handleImportResult = function(data) {
	$(popStorageShop.dgId).datagrid({
		data : data
	});
};
// 导入按钮
$(popStorageShop.pageId + ' #btnImport').on('click', function(event) {
	parent.$.modalDialog({
		title : '导入POP仓库门店对照',
		width : 400,
		height : 250,
		closable : false,
		href : 'popStorageShop/toImport?&fnName=popStorageShop.handleImportResult',
		buttons : [ {
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		} ]
	});
});

// 导出按钮
$(popStorageShop.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(popStorageShop.pageId + " #searchForm"));
	window.open("popStorageShop/exportExcel?" + $.param(searchObj));
});

// 下载模板
$(popStorageShop.pageId + " #btnUpload").on("click", function() {
	window.location.href = "common/import/downLoadTemplate?templateName=" + encodeURI("POP平台仓库门店模板");
});

// 编辑位置
popStorageShop.editIndex = undefined;

// 添加一行
popStorageShop.append = function() {
	$(popStorageShop.dgId).datagrid('rejectChanges');
	$(popStorageShop.dgId).datagrid('appendRow', {
		status : '1'
	});
	popStorageShop.editIndex = $(popStorageShop.dgId).datagrid('getRows').length - 1;
	$(popStorageShop.dgId).datagrid('selectRow', popStorageShop.editIndex).datagrid('beginEdit', popStorageShop.editIndex);
};

// 编辑一行
popStorageShop.edit = function() {
	popStorageShop.editIndex = $(popStorageShop.dgId).datagrid('getRowIndex', $(popStorageShop.dgId).datagrid('getSelected'));
	$(popStorageShop.dgId).datagrid('rejectChanges');
	if (popStorageShop.editIndex >= 0) {
		$(popStorageShop.dgId).datagrid('beginEdit', popStorageShop.editIndex);
	}
};

// 删除一行
popStorageShop.removeit = function() {
	var rows = $(popStorageShop.dgId).datagrid('getChecked');
	if (rows) {
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push(row.channelCode + '-' + row.storageCode);
		});
		$.get('popStorageShop/delete', {
			'ids' : ids.join(",")
		}, function(data) {
			if ($.o2m.handleActionResult(data)) {
				$(popStorageShop.dgId).datagrid('reload');
			}
		});
	}
};

// 保存一行
popStorageShop.accept = function() {
	if (popStorageShop.editIndex != undefined) {
		$(popStorageShop.dgId).datagrid('acceptChanges');
		var row = $(popStorageShop.dgId).datagrid('getRows')[popStorageShop.editIndex];
		if (row.channelCode == '' || row.storageCode == '' || row.shopCode == '') {
			$.messager.alert('警告', '请检查是否有空值！', 'warning');
			$(popStorageShop.dgId).datagrid('beginEdit', popStorageShop.editIndex);
			return;
		} else {
			$.ajax({
				type : "POST",
				url : "popStorageShop/createOrUpdate",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(row),
				success : function(msg) {
					if($.o2m.handleActionResult(msg)){
						$(popStorageShop.dgId).datagrid('reload');
					}
				}
			});
		}
		popStorageShop.editIndex = undefined;
	}
};

popStorageShop.inits();
