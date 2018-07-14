var gmzx_goods_up_view = {};

gmzx_goods_up_view.pageId="#gmzx_goods_up_view_page";
gmzx_goods_up_view.dgId=gmzx_goods_up_view.pageId+" #dg";
gmzx_goods_up_view.billId=gmzx_goods_up_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
gmzx_goods_up_view.inits = function() {

		$(gmzx_goods_up_view.dgId).datagrid({
			title : "单据明细",
			url : "gmzxGoodsManager/getGoodsExamialDetail",
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
			},  {
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
			}, {
				field : 'channelCode',
				title : '渠道代码',
				align : 'center',
				width : 50
			}] ],
			onBeforeLoad :function(param) {
				param.billId=$(gmzx_goods_up_view.billId).val();
			}
		});
};
	
gmzx_goods_up_view.check = function(flag){
	
	var billId = $(gmzx_goods_up_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmzxGoodsManager/checkUp",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		gmzx_goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmzx_goods_up_view.del=function(){
	var billId = $(gmzx_goods_up_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"gmzxGoodsManager/delete",
        data:"billId="+billId,
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','删除成功！',null,function(){
	        		gmzx_goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','删除失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
gmzx_goods_up_view.update=function(){
	var billId = $(gmzx_goods_up_view.billId).val();
	$(gmzx_goods_up_view.pageId).hide();
	$(gmzx_goods_up_list.up_panel).panel({href:"gmzxGoodsManager/goUp?billId="+billId});
	$(gmzx_goods_up_list.up_panel).show();
}
gmzx_goods_up_view.back_list=function(){
	$(gmzx_goods_up_view.pageId).hide();
	$(gmzx_goods_up_list.list_panel).show();
	$(gmzx_goods_up_list.dgId).datagrid('reload');
}

gmzx_goods_up_view.back=function(){
	$(gmzx_goods_up_list.view_panel).hide();
	$(gmzx_goods_up_list.list_panel).show();
}
gmzx_goods_up_view.inits();

