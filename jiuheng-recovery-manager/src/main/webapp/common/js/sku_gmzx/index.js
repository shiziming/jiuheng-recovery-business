var skuGmzx = {};

skuGmzx.pageId = '#skuGmzxPage';
skuGmzx.dgId = skuGmzx.pageId + ' #dg';
skuGmzx.toolBar = skuGmzx.pageId + ' #tb';
skuGmzx.listId = skuGmzx.pageId + ' #listPanel';
skuGmzx.panelId = skuGmzx.pageId + ' #editPanel';

/**
 * 页面初始化函数
 */

skuGmzx.inits = function() {

	$(skuGmzx.dgId).datagrid({
				height : $.o2m.centerHeight - 20,
				striped : true,
				toolbar : skuGmzx.toolBar,
				// nowrap : false,
				url : null,
				onBeforeLoad : function(param) {
					if (param.hasQuery == undefined) {
						return false;
					}
				},
				singleSelect : true,
				rownumbers : true,
				pagination : true,
				pageSize : 20,
				loadMsg : "数据加载中..."
			});
	$(skuGmzx.dgId).datagrid('doCellTip', {
				delay : 500
			});

};

// 查询按钮
$(skuGmzx.pageId + ' #btnSearch').on('click', function(event) {
			var searchObj = $.o2m.serializeObject($(skuGmzx.pageId
					+ " #searchForm"));
			searchObj.hasQuery = 1;
			// $(skuGmzx.dgId).datagrid("load", searchObj);

			var columns = [[{
						field : 'skuId',
						title : 'SKU编码',
						width : 30,
						align : 'center'
					}, {
						field : 'skuName',
						title : 'SKU名称',
						width : 50,
						align : 'center'
					}, {
						field : 'categoryCode',
						title : '分类编码',
						width : 50,
						align : 'center'
					}, {
						field : 'categoryName',
						title : '分类名称',
						width : 50,
						align : 'center'
					}, {
						field : 'fileName',
						title : '图片名称',
						width : 50,
						align : 'center'
					}, {
						field : 'url',
						title : '图片地址',
						width : 200,
						align : 'center'
					}]];

			$(skuGmzx.dgId).datagrid({
						fitColumns : true,
						url : null,
						columns : columns
					});

			var opts = $(skuGmzx.dgId).datagrid('options');
			opts.url = 'skuGmzx/list';

			$(skuGmzx.dgId).datagrid("load", searchObj);

		});
// 动态查询按钮
$(skuGmzx.pageId + ' #btnDynamicSearch').on('click', function(event) {
			var searchObj = $.o2m.serializeObject($(skuGmzx.pageId
					+ " #searchForm"));
			searchObj.hasQuery = 1;
			// $(skuGmzx.dgId).datagrid("load", searchObj);

			var columns = [[{
						field : 'skuId',
						title : 'SKU编码',
						width : 80,
						align : 'center'
					}, {
						field : 'skuName',
						title : 'SKU名称',
						width : 150,
						align : 'center'
					}, {
						field : 'categoryCode',
						title : '分类编码',
						width : 80,
						align : 'center'
					}, {
						field : 'categoryName',
						title : '分类名称',
						width : 120,
						align : 'center'
					}, {
						field : 'fileName',
						title : '图片名称',
						width : 80,
						align : 'center'
					}]];

			for (var i = 1; i <= 40; i++) {
				columns[0].push({
							field : 'url' + i,
							title : '地址链接' + i,
							width : 400,
							align : 'center'
						});
			}

			$(skuGmzx.dgId).datagrid({
						fitColumns : false,
						url : null,
						columns : columns
					});

			var opts = $(skuGmzx.dgId).datagrid('options');
			opts.url = 'skuGmzx/listDynamic';

			$(skuGmzx.dgId).datagrid("load", searchObj);

		});

// 上传图片
$(skuGmzx.pageId + ' #btnPicAdd').on('click', function(event) {
			$(skuGmzx.listId).hide();
			$(skuGmzx.panelId).panel({
						title : '上传图片',
						href : "skuGmzx/upload"
					});
			$(skuGmzx.panelId).panel('open');
		});

// 导出按钮
$(skuGmzx.pageId + ' #btnExport').on('click', function(event) {
			var searchObj = $.o2m.serializeObject($(skuGmzx.pageId
					+ " #searchForm"));
			window.open("skuGmzx/exportExcel?" + $.param(searchObj));
		});

// 动态导出
$(skuGmzx.pageId + ' #btnDynamicExport').on('click', function(event) {
			var searchObj = $.o2m.serializeObject($(skuGmzx.pageId
					+ " #searchForm"));
			window.open("skuGmzx/exportDynamicExcel?" + $.param(searchObj));
		});

// 从Panel页面返回到列表页面
skuGmzx.returnToListPage = function() {
	$(skuGmzx.panelId).panel('close');
	$(skuGmzx.listId).show();
};

skuGmzx.inits();
