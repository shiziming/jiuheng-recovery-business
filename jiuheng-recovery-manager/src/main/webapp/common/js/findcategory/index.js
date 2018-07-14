var findCategory = {};

findCategory.pageId = '#findCategoryPage';
findCategory.dgId = findCategory.pageId + ' #dg';
findCategory.toolBar = findCategory.pageId + ' #tb';

/**
 * 页面初始化函数
 */
findCategory.inits = function() {
	
	var cloumns = [ [ {
		field : 'category1',
		title : '一级类目',
		width : 120,
		align : 'center'
	}, {
		field : 'category2',
		title : '二级类目',
		width : 120,
		align : 'center'
	} , {
		field : 'category3',
		title : '三级类目',
		width : 120,
		align : 'center',
	} ] ];
	for(var i=1;i<=50;i++){
		cloumns[0].push({
			field : 'attr'+i,
			title : '属性'+i,
			width : 100,
			align : 'center'	
		});
		cloumns[0].push({
			field : 'attrValue'+i,
			title : '属性值'+i,
			width : 100,
			align : 'center'	
		});
	}
	$(findCategory.dgId).datagrid({
		height : $.o2m.centerHeight-20,
		striped : true,
		toolbar : findCategory.toolBar,
		onBeforeLoad : function(param){
			if(param.hasQuery == undefined){
				return false;
			}
		},
		onLoadSuccess : function(data){
			var options = {};
			options.url = null;
			options.columns = columns;
			$(this).datagrid(options);
		},
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'findcategory/list',
		columns : cloumns,
		loadMsg : "数据加载中..."
	});
	
	$(findCategory.dgId).datagrid('doCellTip',{delay:500});   
	$(findCategory.pageId + " #categroyCode").combotree({
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
$(findCategory.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(findCategory.pageId + " #searchForm"));
	var categoryCode = $(findCategory.pageId + " #categroyCode").combotree('getValue');
	if(categoryCode !=''){
		searchObj.categoryCode = categoryCode;
	}
	searchObj.hasQuery = 1;
	$(findCategory.dgId).datagrid("load", searchObj);
});

//导出按钮
$(findCategory.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(findCategory.pageId + " #searchForm"));
	searchObj.categoryCode = $(findCategory.pageId + " #categroyCode").combotree('getValue');
	window.open("findcategory/exportExcel?"+$.param(searchObj));
});

findCategory.inits();
