var storage = {};

storage.pageId="#QuerydastoragePage";
storage.list_panel = storage.pageId + " #storage_list_panel";
storage.dgId=storage.list_panel + " #dg";
storage.query = storage.list_panel + " #storage_list_query";
storage.searchForm = storage.list_panel + " #searchForm";

/**
 * 页面初始化函数
 */
storage.inits = function() {
	$(storage.dgId).datagrid({
		rownumbers : true,
		height : document.documentElement.clientHeight,
		pagination : true,
		pageSize : 20,
		fitColumns : true,
		checkOnSelect : true,
		singleSelect : true,
		columns : [ [{
			field : 'shopId',
			title : '门店代码',
			align:'center',
			width : 180
		},{
			field : 'skuId',
			title : '商品内码',
			align:'center',
			width : 180
		},{
			field : 'storagePlaceCode',
			title : '库存地代码',
			align:'center',
			width : 180
		},{
			field : 'serviceType',
			title : '业务机型',
			align:'center',
			width : 180
		},{
			field : 'supplierCode',
			title : '供货商代码',
			align:'center',
			width : 180
		},{
			field : 'storageNum',
			title : '库存数量',
			align:'center',
			width : 180
		}
		]],
		onLoadSuccess:function(data){
			if (data.total == 0) {
	            //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
	            $(this).datagrid('appendRow', { shopId: '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'shopId', colspan: 6 });
	            //隐藏分页导航条，这个需要熟悉datagrid的html结构，直接用jquery操作DOM对象，easyui datagrid没有提供相关方法隐藏导航条
	            $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
			}
			//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
			else{
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				$(dastorage.searchForm+' table').show();
				$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		
	});
	
};
    //条件查询
	$(storage.query).on("click", function() {
		if(!$(storage_panel).find('form').form('enableValidation').form('validate')){
			 return false;
			}
		var o = $.o2m.serializeObject($(storage.searchForm));
		$(storage.dgId).datagrid({url:'dastorage/listStorage', queryParams:o});
	});
	storage.back=function(){
		$(dastorage.storage_panel).hide();
		$(dastorage.dgId).datagrid("reload");
		$(dastorage.list_panel).show();
	}
storage.inits();
