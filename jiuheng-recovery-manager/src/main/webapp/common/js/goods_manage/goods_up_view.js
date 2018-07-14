var goods_up_view = {};

goods_up_view.pageId="#goods_up_view_page";
goods_up_view.dgId=goods_up_view.pageId+" #dg";
goods_up_view.billId=goods_up_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
goods_up_view.inits = function() {

		$(goods_up_view.dgId).datagrid({
			title : "单据明细",
			url : "goodsManage/getGoodsExamialDetail",
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
				field : 'commission',
				title : '佣金(元)',
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
			}, {
				field : 'channelCode',
				title : '渠道代码',
				align : 'center',
				width : 50
			}] ],
			onBeforeLoad :function(param) {
				param.billId=$(goods_up_view.billId).val();
			}
		});
};
	
goods_up_view.check = function(flag){
	
	var billId = $(goods_up_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"goodsManage/checkUp",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
goods_up_view.del=function(){
	var billId = $(goods_up_view.billId).val();
	$.ajax({ 
        type:"POST", 
        url:"goodsManage/delete",
        data:"billId="+billId,
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','删除成功！',null,function(){
	        		goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','删除失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}
goods_up_view.update=function(){
	var billId = $(goods_up_view.billId).val();
	$(goods_up_view.pageId).hide();
	$(goods_up_list.up_panel).panel({href:"goodsManage/goUp?billId="+billId});
	$(goods_up_list.up_panel).show();
}
goods_up_view.back_list=function(){
	$(goods_up_view.pageId).hide();
	$(goods_up_list.list_panel).show();
	$(goods_up_list.dgId).datagrid('reload');
}

goods_up_view.back=function(){
	$(goods_up_list.view_panel).hide();
	$(goods_up_list.list_panel).show();
}
goods_up_view.inits();

