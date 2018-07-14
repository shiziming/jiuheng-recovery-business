var gmj_goods_down_view = {};
 
gmj_goods_down_view.pageId="#goods_down_view_page2";
gmj_goods_down_view.dgId=gmj_goods_down_view.pageId+" #dg";
gmj_goods_down_view.billId=gmj_goods_down_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
gmj_goods_down_view.inits = function() {

		$(gmj_goods_down_view.dgId).datagrid({
			title : "单据明细",
			url : "gmjGoodsManage/getGoodsExamialDetail",
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
			}] ],
			onBeforeLoad :function(param) {
				param.billId=$(gmj_goods_down_view.billId).val();
			}
		});
};
	
gmj_goods_down_view.check = function(flag){
	var billId = $(gmj_goods_down_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmjGoodsManage/checkDown",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		gmj_goods_down_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmj_goods_down_view.del=function(){
	var billId = $(gmj_goods_down_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmjGoodsManage/delete",
        data:"billId="+billId,
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','删除成功！',null,function(){
	        		gmj_goods_down_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','删除失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmj_goods_down_view.update=function(){
	var billId = $(gmj_goods_down_view.billId).val();
	$(gmj_goods_down_list.view_panel).hide();
	$(gmj_goods_down_list.down_panel).panel({href:"gmjGoodsManage/goDown?billId="+billId});
	$(gmj_goods_down_list.down_panel).show();
}
gmj_goods_down_view.back_list=function(){
	$(gmj_goods_down_list.view_panel).hide();
	$(gmj_goods_down_list.list_panel).show();
	$(gmj_goods_down_list.dgId).datagrid('reload');
}

gmj_goods_down_view.back=function(){
	$(gmj_goods_down_list.view_panel).hide();
	$(gmj_goods_down_list.list_panel).show();
}
gmj_goods_down_view.inits();

