var amazonCreatPositiveOrder = {};

amazonCreatPositiveOrder.pageId = '#amazonCreatPositiveOrder_page';
amazonCreatPositiveOrder.dg1Id = amazonCreatPositiveOrder.pageId + ' #dg1';
amazonCreatPositiveOrder.configDgId = amazonCreatPositiveOrder.pageId + ' #configDg';
amazonCreatPositiveOrder.configDiv = amazonCreatPositiveOrder.pageId + ' #configDiv';
amazonCreatPositiveOrder.toolBar = amazonCreatPositiveOrder.pageId + ' #tb';
amazonCreatPositiveOrder.listId = amazonCreatPositiveOrder.pageId + ' #listPanel';
amazonCreatPositiveOrder.panelId = amazonCreatPositiveOrder.pageId + ' #editPanel';
amazonCreatPositiveOrder.addressAreaCode = amazonCreatPositiveOrder.pageId + ' #addressAreaCode';
amazonCreatPositiveOrder.xsddh = amazonCreatPositiveOrder.pageId + ' #xsddh';
amazonCreatPositiveOrder.xsfdh = amazonCreatPositiveOrder.pageId + ' #xsfdh';
amazonCreatPositiveOrder.creatPositiveOrderForm = amazonCreatPositiveOrder.pageId+" #creatPositiveOrderForm";
/**
 * 页面初始化函数
 */
amazonCreatPositiveOrder.inits = function() {
	$("#amazonCreatPositiveOrder_page .categories-datagrid").datagrid({
		height : $.o2m.centerHeight-20,
		width : 90,
		singleSelect : true,
		onClickRow : amazonCreatPositiveOrder.onClickRow,
		onDblClickRow:amazonCreatPositiveOrder.onDblClickRow,
		onBeforeLoad : function(param){
			if(param.pid == undefined){
				return false;
			}
		},
		striped : true,
		fitColumns : true,
		url : 'addressArea/children',
		columns : [ [ {
			field : 'code',
			title : '编码',
			width : 40,
			hidden:true
		}, {
			field : 'name',
			width : 60
		}] ],
		onLoadSuccess : function() {
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500}); 
		},
		loadMsg : "数据加载中..."
	});

	$(amazonCreatPositiveOrder.dg1Id).datagrid('load',{
		pid: ""
	});
	$("#amazonCreatPositiveOrder_page .amazonPanel-hide").hide();
};

amazonCreatPositiveOrder.onClickRow = function(index, row){
	var paDiv = $(this).parents('.amazonCategories-panel');
	var next = $(paDiv).next();
	if (row.level < 4) {
		$(next).show();

		$(next).find('.categories-datagrid').datagrid('load',{
			pid : row.code
		});
		$(next).nextAll().css('display', 'none');
	}else{
		$(amazonCreatPositiveOrder.addressAreaCode).numberbox('setValue', row.code);
		$(".amazonPanel-hide").css('display', 'none');
	}
};
amazonCreatPositiveOrder.back=function(){
	$(amazonOrderquery.creatPositiveOrderPanel).panel('close');
	$(amazonOrderquery.list_panel).show();
}
amazonCreatPositiveOrder.creat=function(){
	if($(amazonCreatPositiveOrder.creatPositiveOrderForm).form('validate')){
	var addressAreaCode=$(amazonCreatPositiveOrder.addressAreaCode).numberbox('getValue');
	var xsfdh=$(amazonCreatPositiveOrder.xsfdh).val();
	var xsddh=$(amazonCreatPositiveOrder.xsddh).val();
	$.ajax({
        type:"POST", 
        url:"amazonOrder/creatPositiveOrder",
        data:{"addressAreaCode":addressAreaCode,"xsfdh":xsfdh,"xsddh":xsddh},
        success:function(data){
        	if(data.code==0){
	        	parent.$.messager.alert('提示',data.msg,'info');
        	}else if(data.code==1){
        		parent.$.messager.alert('警告',data.msg,'worm');
        	}
        }
    });
	}
}
amazonCreatPositiveOrder.inits();
