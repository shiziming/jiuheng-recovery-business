var spuValues = {};

spuValues.pageId = '#spuValuesPage';
spuValues.dgId = spuValues.pageId + ' #dg';
spuValues.toolBar = spuValues.pageId + ' #tb';


/**
 * 页面初始化函数
 */
spuValues.inits = function() {
	
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
	}, {
		field : 'spuCode',
		title : 'SPU编码',
		width : 120,
		align : 'center'
	}, {
		field : 'spuName',
		title : 'SPU名称',
		width : 400,
		align : 'center'
	},{
		field : 'recommendWord',
		title : '商品推荐语',
		width : 300,
		align : 'center'
	},{
		field : 'skuAttr1',
		title : '销售属性1',
		width : 80,
		align : 'center'
	} , {
		field : 'skuValue1',
		title : '销售属性值1',
		width : 100,
		align : 'center',
	}, {
		field : 'skuAttr2',
		title : '销售属性2',
		width : 80,
		align : 'center'
	}, {
		field : 'skuValue2',
		title : '销售属性值2',
		width : 100,
		align : 'center'
	}] ];
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
	$(spuValues.dgId).datagrid({
		height : $.o2m.centerHeight-20,
		striped : true,
		toolbar : spuValues.toolBar,
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
		url : 'spuvalues/list',
		columns : cloumns,
		loadMsg : "数据加载中..."
	});
	
	$(spuValues.dgId).datagrid('doCellTip',{delay:500});   
	$(spuValues.pageId + " #categroyCode").combotree({
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
$(spuValues.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(spuValues.pageId + " #searchForm"));
	var categoryCode = $(spuValues.pageId + " #categroyCode").combotree('getValue');
	if(categoryCode !=''){
		searchObj.categoryCode = categoryCode;
	}
	searchObj.hasQuery = 1;
	$(spuValues.dgId).datagrid("load", searchObj);
});

//导出按钮
$(spuValues.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(spuValues.pageId + " #searchForm"));
	searchObj.categoryCode = $(spuValues.pageId + " #categroyCode").combotree('getValue');
	window.open("spuvalues/exportExcel?"+$.param(searchObj));
});

spuValues.inits();
