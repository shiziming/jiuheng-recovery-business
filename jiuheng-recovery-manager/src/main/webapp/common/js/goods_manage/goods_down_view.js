var goods_down_view = {};

goods_down_view.pageId="#goods_down_view_page";
goods_down_view.dgId=goods_down_view.pageId+" #dg";
goods_down_view.billId=goods_down_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
goods_down_view.inits = function() {

		$(goods_down_view.dgId).datagrid({
			title : "单据明细",
			url : "goodsManage/getGoodsExamialDetail",
			striped : true,
			collapsible : true,
			autoRowHeight : false,
			rownumbers : true,
			fitColumns : true,
			columns : [ [ {
				field : 'billId',
				title : '单据编号',
				align:'center',
				width : 100
			}, {
				field : 'skuCode',
				title : '商品编码',
				align : 'center',
				width : 100
			}, {
				field : 'skuName',
				title : '商品名称',
				align : 'center',
				width : 100
			}, {
				field : 'saleOrgCode',
				title : '销售组织代码',
				align : 'center',
				width : 100
			}, {
				field : 'channelCode',
				title : '渠道代码',
				align : 'center',
				width : 100
			}] ],
			onBeforeLoad :function(param) {
				param.billId=$(goods_down_view.billId).val();
			}
		});
};
	
goods_down_view.check = function(flag){
	var billId = $(goods_down_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"goodsManage/checkDown",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		goods_down_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
goods_down_view.del=function(){
	var billId = $(goods_down_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"goodsManage/delete",
        data:"billId="+billId,
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','删除成功！',null,function(){
	        		goods_down_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','删除失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
goods_down_view.update=function(){
	var billId = $(goods_down_view.billId).val();
	$(goods_down_list.view_panel).hide();
	$(goods_down_list.down_panel).panel({href:"goodsManage/goDown?billId="+billId});
	$(goods_down_list.down_panel).show();
}
goods_down_view.back_list=function(){
	$(goods_down_list.view_panel).hide();
	$(goods_down_list.list_panel).show();
	$(goods_down_list.dgId).datagrid('reload');
}

goods_down_view.back=function(){
	$(goods_down_list.view_panel).hide();
	$(goods_down_list.list_panel).show();
}
goods_down_view.inits();

