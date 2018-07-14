var popCityOrg = {};

popCityOrg.pageId = "#popCityOrgPage";
popCityOrg.dgId = popCityOrg.pageId + " #dg";
popCityOrg.toolBar = popCityOrg.pageId + " #tb";

/**
 * 页面初始化函数
 */
popCityOrg.inits = function() {
	$(popCityOrg.dgId).datagrid({
		height : $.o2m.centerHeight - 20,
		striped : true,
		fitColumns : true,
		toolbar : popCityOrg.toolBar,
		singleSelect : true,
		selectOnCheck : false,
		checkOnSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'popCityOrg/list',
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
			field : 'saleOrgCode',
			title : '销售组织编码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'popCityCode',
			title : '在线城市代码',
			align : 'center',
			width : 100,
			editor : 'textbox'
		}, {
			field : 'popCityName',
			title : '在线城市名称',
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
	$(popCityOrg.dgId).datagrid('doCellTip', {
		delay : 500
	});
};

// 查询按钮
$(popCityOrg.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(popCityOrg.pageId + " #searchForm"));
	searchObj.hasQuery = 1;
	$(popCityOrg.dgId).datagrid("load", searchObj);
});

popCityOrg.handleImportResult = function(data) {
	$(popCityOrg.dgId).datagrid({
		data : data
	});
};
// 导入按钮
$(popCityOrg.pageId + ' #btnImport').on('click', function(event) {
	parent.$.modalDialog({
		title : '导入POP平台城市销售组织',
		width : 400,
		height : 250,
		closable : false,
		href : 'popCityOrg/toImport?&fnName=popCityOrg.handleImportResult',
		buttons : [ {
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		} ]
	});
});

// 导出按钮
$(popCityOrg.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(popCityOrg.pageId + " #searchForm"));
	window.open("popCityOrg/exportExcel?" + $.param(searchObj));
});

// 下载模板
$(popCityOrg.pageId + " #btnUpload").on("click", function() {
	window.location.href = "common/import/downLoadTemplate?templateName=" + encodeURI("POP平台城市销售组织模板");
});

// 编辑位置
popCityOrg.editIndex = undefined;

// 添加一行
popCityOrg.append = function() {
	$(popCityOrg.dgId).datagrid('rejectChanges');
	$(popCityOrg.dgId).datagrid('appendRow', {
		status : '1'
	});
	popCityOrg.editIndex = $(popCityOrg.dgId).datagrid('getRows').length - 1;
	$(popCityOrg.dgId).datagrid('selectRow', popCityOrg.editIndex).datagrid('beginEdit', popCityOrg.editIndex);
};

// 编辑一行
popCityOrg.edit = function() {
	popCityOrg.editIndex = $(popCityOrg.dgId).datagrid('getRowIndex', $(popCityOrg.dgId).datagrid('getSelected'));
	$(popCityOrg.dgId).datagrid('rejectChanges');
	if (popCityOrg.editIndex >= 0) {
		$(popCityOrg.dgId).datagrid('beginEdit', popCityOrg.editIndex);
	}
};

// 删除
popCityOrg.removeit = function() {
	var rows = $(popCityOrg.dgId).datagrid('getChecked');
	if (rows) {
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push(row.channelCode + '-' +row.popShopCode + '-' + row.popCityCode);
		});
		$.get('popCityOrg/delete', {
			ids : ids.join(",")
		}, function(data) {
			if ($.o2m.handleActionResult(data)) {
				$(popCityOrg.dgId).datagrid('reload');
			}
		});
	}
};

// 保存一行
popCityOrg.accept = function() {
	if (popCityOrg.editIndex != undefined) {
		$(popCityOrg.dgId).datagrid('acceptChanges');
		var row = $(popCityOrg.dgId).datagrid('getRows')[popCityOrg.editIndex];
		if (row.channelCode == '' || row.popCityCode == '' || row.saleOrgCode == '') {
			$.messager.alert('警告', '请检查是否有空值！', 'warning');
			$(popCityOrg.dgId).datagrid('beginEdit', popCityOrg.editIndex);
			return;
		} else {
			$.ajax({
				type : "POST",
				url : "popCityOrg/createOrUpdate",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(row),
				success : function(msg) {
					if ($.o2m.handleActionResult(msg)) {
						$(popCityOrg.dgId).datagrid('reload');
					}
				}
			});
		}
		popCityOrg.editIndex = undefined;
	}
};

popCityOrg.inits();
