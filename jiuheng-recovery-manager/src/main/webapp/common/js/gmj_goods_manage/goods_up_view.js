var gmj_goods_up_view = {};
 
gmj_goods_up_view.pageId="#goods_up_view_page1";
gmj_goods_up_view.dgId=gmj_goods_up_view.pageId+" #dg";
gmj_goods_up_view.billId=gmj_goods_up_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
gmj_goods_up_view.inits = function() {

		$(gmj_goods_up_view.dgId).datagrid({
			title : "单据明细",
			url : "gmjGoodsManage/getGoodsExamialDetail",
			striped : true,
			rownumbers : true,
			fitColumns : true,
			columns : [ [ {
				field : 'billId',
				title : '单据编号',
				align:'center',
				width : 50 
			}, {
				field : 'skuCode',
				title : '商品编码',
				align : 'center',
				width : 40,
				formatter : function(value,row){
					return parseInt(value);
				}
			}, {
				field : 'skuName',
				title : '商品名称',
				align : 'center',
				width : 120
			}, {
				field : 'price',
				title : '价格(元)',
				align : 'center',
				width : 30
			}, {
				field : 'installFlag',
				title : '安装标记',
				align : 'center',
				width : 20,
				formatter : function(value,row){
					if(value == '1'){
						return '是';
					}
					return '否';
				}
			}, {
				field : 'saleOrgCode',
				title : '销售组织',
				align : 'center',
				width : 50
			}] ],
			onBeforeLoad :function(param) {
				param.billId=$(gmj_goods_up_view.billId).val();
			}
		});
};
	
gmj_goods_up_view.check = function(flag){
	
	var billId = $(gmj_goods_up_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmjGoodsManage/checkUp",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		gmj_goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmj_goods_up_view.del=function(){
	var billId = $(gmj_goods_up_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmjGoodsManage/delete",
        data:"billId="+billId,
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','删除成功！',null,function(){
	        		gmj_goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','删除失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmj_goods_up_view.update=function(){
	var billId = $(gmj_goods_up_view.billId).val();
	$(gmj_goods_up_view.pageId).hide();
	$(gmj_goods_up_list.up_panel).panel({href:"gmjGoodsManage/goUp?billId="+billId});
	$(gmj_goods_up_list.up_panel).show();
}
gmj_goods_up_view.back_list=function(){
	$(gmj_goods_up_view.pageId).hide();
	$(gmj_goods_up_list.list_panel).show();
	$(gmj_goods_up_list.dgId).datagrid('reload');
}

gmj_goods_up_view.back=function(){
	$(gmj_goods_up_list.view_panel).hide();
	$(gmj_goods_up_list.list_panel).show();
}

/*add by chengchao begin*/
//gmj_goods_up_view.currentPriceSearch=function(){
//	var row = $(gmj_goods_up_view.dgId).datagrid('getData').rows[0];
//	alert(row.skuCode);
//	alert(row.funId);
//	alert(row.channelCode);
//	alert(row.saleOrgCode);
//	$.o2m.openMagnifierWindow('查询SKU时时价格', 'icon-search', 500, 500, 'goodsManage/getSkuInfo?skuCode='+row.skuCode+'&funId='+row.funId+'&channelCode='+row.channelCode+'&saleOrgCode='+row.saleOrgCode);
//}
/*add by chengchao end*/
gmj_goods_up_view.inits();

