var gmzx_goodsUpDown = {};

gmzx_goodsUpDown.pageId = '#sku_up_down';
gmzx_goodsUpDown.dgId = gmzx_goodsUpDown.pageId + ' #dg';
gmzx_goodsUpDown.toolBar = gmzx_goodsUpDown.pageId + ' #tb';

/**
 * 页面初始化函数
 */
gmzx_goodsUpDown.inits = function() {
	$(gmzx_goodsUpDown.dgId).datagrid({
		height : $.o2m.centerHeight-20,
		striped : true,
		fitColumns : true,
		toolbar : gmzx_goodsUpDown.toolBar,
		onBeforeLoad : function(param){
			if(param.clickQuery == undefined){
				return false;
			}
		},
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'gmzxGoodsManage/list',
		data : [],
		columns : [ [ {
			field : 'skuCode',
			title : 'SKU编码',
			width : 30,
			align : 'center'
		}, {
			field : 'skuName',
			title : 'SKU名称',
			width : 100,
			align : 'center'
		} , {
			field : 'secondCategroyCode',
			title : '品类',
			width : 20,
			align : 'center'
		} , {
			field : 'saleOrgCode',
			title : '销售组织',
			width : 20,
			align : 'center'
		}, {
			field : 'channelCode',
			title : '销售渠道',
			width : 20,
			align : 'center'
		}, {
			field : 'price',
			title : '售价',
			width : 20,
			align : 'center'
		}, {
			field : 'installFlag',
			title : '安装标记',
			width : 20,
			align : 'center',
			formatter : function(value,row){
				if(value == '1'){
					return '<span style="color:red">是</span>';
				}
				return '<span>否</span>'
			}
		}, {
			field : 'brand',
			title : '品牌',
			width : 20,
			align : 'center'
		}, {
			field : 'categoryCode',
			title : '类目',
			width : 30,
			align : 'center'
		}, {
			field : 'handleTime',
			title : '上架时间',
			width : 50,
			align : 'center'
		}] ],
		loadMsg : "数据加载中..."
	});
	
	$(gmzx_goodsUpDown.dgId).datagrid('doCellTip',{delay:500});   
	$(gmzx_goodsUpDown.pageId + " #categroyCode").combotree({
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
	
	$(gmzx_goodsUpDown.pageId + " #secondCategroyCode").combotree({
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
				data : $.o2m.getSecondCategroyChildren(node.id)
			});
		}
	});
};
	
	

//查询按钮
$(gmzx_goodsUpDown.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(gmzx_goodsUpDown.pageId + " #searchForm"));
	var categoryCode = $(gmzx_goodsUpDown.pageId + " #categroyCode").combotree('getValue');
	var secondCategroyCode = $(gmzx_goodsUpDown.pageId + " #secondCategroyCode").combotree('getValue');
	if(categoryCode !=''){
		searchObj.categoryCode = categoryCode;
	}
	if(secondCategroyCode !=''){
		searchObj.secondCategroyCode = secondCategroyCode;
	}
	searchObj.clickQuery = 1;
	$(gmzx_goodsUpDown.dgId).datagrid("load", searchObj);
});
//导出按钮
$(gmzx_goodsUpDown.pageId + ' #btnExport').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(gmzx_goodsUpDown.pageId + " #searchForm"));
	searchObj.categoryCode = $(gmzx_goodsUpDown.pageId + " #categroyCode").combotree('getValue');
	window.open("gmzxGoodsManage/exportExcel?"+encodeURI($.param(searchObj)));	
});

gmzx_goodsUpDown.inits();
