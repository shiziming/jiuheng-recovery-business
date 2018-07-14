var spuWithSku = {};

spuWithSku.pageId = '#spuWithSkuPage';
spuWithSku.dgId = spuWithSku.pageId + ' #dg';
spuWithSku.toolBar = spuWithSku.pageId + ' #tb';

/**
 * 页面初始化函数
 */
spuWithSku.inits = function() {
	$(spuWithSku.dgId).datagrid({
		height : $.o2m.centerHeight-20,
		striped : true,
		fitColumns : true,
		toolbar : spuWithSku.toolBar,
		onBeforeLoad : function(param){
			if(param.hasQuery == undefined){
				return false;
			}
		},
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'spuWithSku/list',
		columns : [ [ {
			field : 'spuCode',
			title : 'SPU编码',
			width : 30,
			align : 'center'
		}, {
			field : 'spuName',
			title : 'SPU名称',
			width : 60,
			align : 'center'
		} , {
			field : 'categoryCode',
			title : '末级类目',
			width : 40,
			align : 'center',
			formatter : function(value,row) {
				return value + "-" + row.categoryName;
			}
		}, {
			field : 'brandName',
			title : '品牌',
			width : 20,
			align : 'center'
		}, {
			field : 'roleName',
			title : '岗位名称',
			width : 20,
			align : 'center'
		}, {
			field : 'handler',
			title : '维护人',
			width : 20,
			align : 'center'
		}, {
			field : 'handleTime',
			title : '维护时间',
			width : 50,
			align : 'center'
		}, {
			field : 'spuStatus',
			title : 'SPU发布状态',
			width : 20,
			align : 'center'
		}, {
			field : 'skuCode',
			title : 'SKU码',
			width : 30,
			align : 'center'
		}, {
			field : 'skuName',
			title : 'SKU名称',
			width : 80,
			align : 'center'
		}, {
			field : 'skuStatus',
			title : 'SKU发布状态',
			width : 20,
			align : 'center'
		}] ],
		loadMsg : "数据加载中..."
	});
	
	$(spuWithSku.dgId).datagrid('doCellTip',{delay:500});   
	$(spuWithSku.pageId + " #categroyCode").combotree({
		data : [{
			pid : '',
			id : '',
			text : '全部',
			state : "closed"	
		}],
		onBeforeExpand : function(node) {
			if (node.children && node.children.length) {
				return;
			};
			$(this).tree('append', {
				parent : node.target,
				data : $.o2m.getCategroyChildren(node.id)
			});
		}
	});
};

//查询按钮
$(spuWithSku.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(spuWithSku.pageId + " #searchForm"));
	var categoryCode = $(spuWithSku.pageId + " #categroyCode").combotree('getValue');
	if(categoryCode !=''){
		searchObj.categoryCode = categoryCode;
	}
	searchObj.hasQuery = 1;
	$(spuWithSku.dgId).datagrid("load", searchObj);
});
//导出按钮
$(spuWithSku.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(spuWithSku.pageId + " #searchForm"));
	searchObj.categoryCode = $(spuWithSku.pageId + " #categroyCode").combotree('getValue');
	window.open("spuWithSku/exportExcel?"+ encodeURI($.param(searchObj)));
});

spuWithSku.inits();
