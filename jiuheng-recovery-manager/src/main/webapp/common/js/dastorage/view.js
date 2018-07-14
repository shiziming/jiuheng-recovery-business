var dastorage_view = {};

dastorage_view.pageId="#dastorage_view_page";
dastorage_view.dgId=dastorage_view.pageId+" #dg";
dastorage_view.billId=dastorage_view.pageId+" #billId";
/**
 * 页面初始化函数
 */
dastorage_view.inits = function() {

		$(dastorage_view.dgId).datagrid({
			title : "单据明细",
			url : "dastorage/getDaStorageSetBillDetail",
			striped : true,
			rownumbers : true,
			fitColumns : true,
			checkOnSelect : true,
			singleSelect : true,
			columns : [ [ {
				field : 'billId',
				title : '单据编号',
				align:'center',
				width : 50 
			}, {
				field : 'storagePlaceCode',
				title : '库存地点代码',
				align : 'center',
				width : 50,
			}, {
				field : 'skuId',
				title : '商品内码',
				align : 'center',
				width : 80
			}, {
				field : 'channelCode',
				title : '渠道代码',
				align : 'center',
				width : 30
			},  {
				field : 'serviceType',
				title : '业务机型',
				align : 'center',
				width : 50
			}, {
				field : 'supplierCode',
				title : '供应商代码',
				align : 'center',
				width : 50
			},{
				field : 'oldStorageNum',
				title : '原库存数量',
				align : 'center',
				width : 50
			}, {
				field : 'newStorageNum',
				title : '新库存数量',
				align : 'center',
				width : 50,
			}, {
				field : 'saleNum',
				title : '销售数量',
				align : 'center',
				width : 50
			}, {
				field : 'lockNum',
				title : '锁定数量',
				align : 'center',
				width : 50
			}] ],
			onBeforeLoad :function(param) {
				param.billId=$(dastorage_view.billId).val();
			}
		});
};
//去修改界面
dastorage_view.update=function(){
	var row=$(dastorage_view.dgId).datagrid("getSelected");
	if(row){
	$(dastorage.view_panel).hide();
	$(dastorage.up_panel).panel({href:"dastorage/toEdit?billId="+row.billId+"&storagePlaceCode="+row.storagePlaceCode+"&skuId="+row.skuId+"&channelCode="+row.channelCode+"&serviceType="+row.serviceType+"&supplierCode="+row.supplierCode});
	$(dastorage.up_panel).show();
	}else{
		$.messager.alert('警告', '请选择一条明细!', 'warning');
	}
}
//保存修改数据
dastorage_view.save=function(){
	 var billId = $(dastorage_view.billId).val();
	 var newStorageNum=$("#newStorageNum").val();
	 var storagePlaceCode=$("#storagePlaceCode").val();
	 var channelCode=$("#channelCode").val();
	 var skuId=$("#skuId").val();
	 var serviceType=$("#serviceType").val();
	 var supplierCode=$("#supplierCode").val();
	 var detail={}
	 detail.billId=billId;
	 detail.storagePlaceCode=storagePlaceCode;
	 detail.skuId=skuId;
	 detail.billId=billId;
	 detail.channelCode=channelCode;
	 detail.serviceType=serviceType;
	 detail.supplierCode=supplierCode;
	 detail.newStorageNum=newStorageNum;
	 $.ajax({
			type : "POST",
			url : "dastorage/save",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(detail),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(dastorage.up_panel).hide();
					$(dastorage.view_panel).show();
					$(dastorage_view.dgId).datagrid('reload');
				}
			}
		 }); 
};

//返回查看界面
dastorage_view.back_view=function(){
	$(dastorage.up_panel).hide();
	$(dastorage.view_panel).show();
	$(dastorage_view.dgId).datagrid('reload');
}
//返回列表界面
dastorage_view.back=function(){
	$(dastorage.view_panel).hide();
	$(dastorage.list_panel).show();
	$(dastorage.dgId).datagrid("reload");
	
}

dastorage_view.check = function(){
	    var billId = $(dastorage_view.billId).val();
		$.ajax({ 
	        type:"POST", 
	        url:"dastorage/check?billId="+billId,
	        dataType : "json",
			contentType : "application/json",
	        success:function(result){
	        	if($.o2m.handleActionResult(result)){
	        		$(dastorage.view_panel).hide();
	        		$(dastorage.dgId).datagrid("reload");
					$(dastorage.list_panel).show();
	        	}
	        }
	    }); 
}

dastorage_view.del=function(){
	 var row=$(dastorage_view.dgId).datagrid("getSelected");
    if(row){
    	$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
    		if (r) {
				$.ajax({ 
			        type:"POST", 
			        url:"dastorage/del",
			        data:"billId="+row.billId+"&storagePlaceCode="+row.storagePlaceCode+"&skuId="+row.skuId+"&channelCode="+row.channelCode+"&serviceType="+row.serviceType+"&supplierCode="+row.supplierCode,
			        success:function(result){
				       if($.o2m.handleActionResult(result)){
				    	   $(dastorage_view.dgId).datagrid("reload");
				    }
			        }
			    }); 
    		}
		});
}else{
	$.messager.alert('警告', '请选择一条明细!', 'warning');
}
}
dastorage_view.inits();

