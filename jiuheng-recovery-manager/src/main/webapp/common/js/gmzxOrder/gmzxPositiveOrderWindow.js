var creatPositiveOrder = {};

creatPositiveOrder.pageId = '#creatPositiveOrder_page';
creatPositiveOrder.dg1Id = creatPositiveOrder.pageId + ' #dg1';
creatPositiveOrder.configDgId = creatPositiveOrder.pageId + ' #configDg';
creatPositiveOrder.configDiv = creatPositiveOrder.pageId + ' #configDiv';
creatPositiveOrder.toolBar = creatPositiveOrder.pageId + ' #tb';
creatPositiveOrder.listId = creatPositiveOrder.pageId + ' #listPanel';
creatPositiveOrder.panelId = creatPositiveOrder.pageId + ' #editPanel';
creatPositiveOrder.addressAreaCode = creatPositiveOrder.pageId + ' #addressAreaCode';
creatPositiveOrder.xsddh = creatPositiveOrder.pageId + ' #xsddh';
creatPositiveOrder.xsfdh = creatPositiveOrder.pageId + ' #xsfdh';
creatPositiveOrder.creatPositiveOrderForm = creatPositiveOrder.pageId+" #creatPositiveOrderForm";
/**
 * 页面初始化函数 
 */
creatPositiveOrder.inits = function() {
	$("#creatPositiveOrder_page .categories-datagrid").datagrid({
		height : $.o2m.centerHeight-20,
		width : 90,
		singleSelect : true,
		onClickRow : creatPositiveOrder.onClickRow,
		onDblClickRow:creatPositiveOrder.onDblClickRow,
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

	$(creatPositiveOrder.dg1Id).datagrid('load',{
		pid: ""
	});
	$("#creatPositiveOrder_page .panel-hide").hide();
};

creatPositiveOrder.onClickRow = function(index, row){
	var paDiv = $(this).parents('.categories-panel');
	var next = $(paDiv).next();
	if (row.level < 4) {
		$(next).show();

		$(next).find('.categories-datagrid').datagrid('load',{
			pid : row.code
		});
		$(next).nextAll().css('display', 'none');
	}else{
		$(creatPositiveOrder.addressAreaCode).numberbox('setValue', row.code);
		$(".panel-hide").css('display', 'none');
	}
};
creatPositiveOrder.back=function(){
	$(gmzxOrderquery.creatPositiveOrderPanel).panel('close');
	$(gmzxOrderquery.list_panel).show();
}
creatPositiveOrder.creat=function(){
	if($(creatPositiveOrder.creatPositiveOrderForm).form('validate')){
	var addressAreaCode=$(creatPositiveOrder.addressAreaCode).numberbox('getValue');
	var xsfdh=$(creatPositiveOrder.xsfdh).val();
	var xsddh=$(creatPositiveOrder.xsddh).val();
	$.ajax({
        type:"POST", 
        url:"gmzxOrder/creatPositiveOrder",
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
creatPositiveOrder.inits();
