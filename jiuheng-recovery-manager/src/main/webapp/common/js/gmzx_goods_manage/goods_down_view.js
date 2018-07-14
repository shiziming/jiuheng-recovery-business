var gmzx_goods_down_view = {};

gmzx_goods_down_view.pageId="#gmzx_goods_down_view_page";
gmzx_goods_down_view.dgId=gmzx_goods_down_view.pageId+" #dg";
gmzx_goods_down_view.billId=gmzx_goods_down_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
gmzx_goods_down_view.inits = function() {

		$(gmzx_goods_down_view.dgId).datagrid({
			title : "单据明细",
			url : "gmzxGoodsManager/getGoodsExamialDetail",
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
				param.billId=$(gmzx_goods_down_view.billId).val();
			}
		});
};
	
gmzx_goods_down_view.check = function(flag){
	var billId = $(gmzx_goods_down_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmzxGoodsManager/checkDown",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		gmzx_goods_down_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmzx_goods_down_view.del=function(){
	var billId = $(gmzx_goods_down_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmzxGoodsManager/delete",
        data:"billId="+billId,
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','删除成功！',null,function(){
	        		gmzx_goods_down_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','删除失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmzx_goods_down_view.update=function(){
	var billId = $(gmzx_goods_down_view.billId).val();
	$(gmzx_goods_down_list.view_panel).hide();
	$(gmzx_goods_down_list.down_panel).panel({href:"gmzxGoodsManager/goDown?billId="+billId});
	$(gmzx_goods_down_list.down_panel).show();
}
gmzx_goods_down_view.back_list=function(){
	$(gmzx_goods_down_list.view_panel).hide();
	$(gmzx_goods_down_list.list_panel).show();
	$(gmzx_goods_down_list.dgId).datagrid('reload');
}

gmzx_goods_down_view.back=function(){
	$(gmzx_goods_down_list.view_panel).hide();
	$(gmzx_goods_down_list.list_panel).show();
}
gmzx_goods_down_view.inits();

