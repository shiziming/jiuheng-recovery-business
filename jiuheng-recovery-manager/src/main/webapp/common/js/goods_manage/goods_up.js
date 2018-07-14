var goods_up = {};

goods_up_pageId = "#goods_up_page";
goods_up.dgId = goods_up_pageId+ " #dg";
goods_up.tbId = goods_up_pageId+" #tb";
goods_up.billId = goods_up_pageId+" #billId";
goods_up.numberattr = goods_up_pageId+" #numberattr";

/**
 * 页面初始化函数
 */
goods_up.inits = function() {
	$(goods_up.dgId).datagrid({
		striped : true,
		rownumbers : true,
		fitColumns : true,
		//checkOnSelect : false,
		onDblClickRow : function(index,row){
			if ($.o2m.isEmpty(row.price) || $.o2m.isEmpty(row.commission)) {
				$(goods_up.dgId).datagrid('beginEdit',index);
			}
		},
		url:'goodsManage/getGoodsExamialDetail?billId='+$(goods_up.billId).val(),
		columns : [ [ {
			field : 'cb',
			width : 10,
			checkbox : true
		}, {
			field : 'billId',
			hidden:true
		}, {
			field : 'skuCode',
			title : 'SKU编码',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		}, {
			field : 'saleOrgCode',
			title : '销售组织编码',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		},{
			field : 'channelCode',
			title : '渠道编码',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		},{
			field : 'installFlag',
			title : '安装标记',
			align : 'center',
			width : 60,
			editor:{type:'checkbox',options:{on:'1',off:'0'}}
		}, {
			field : 'getSkuInfo',
			title : '获取SKU信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="goods_up.getSkuInfo(this);">查询</a>';
			}
		}, {
			field : 'skuName',
			title : 'SKU名称',
			align:'center',
			width : 200
		}, {
			field : 'price',
			title : '售价',
			align:'center',
			width : 100
		}, {
			field : 'commission',
			title : '佣金',
			align:'center',
			width : 100
		},{
			field : 'fromType',
			hidden : true
		}] ],
		onBeforeLoad : function(){
			if($(goods_up.billId).val() == ''){
				return false;
			}
		},
		toolbar : goods_up.tbId
	});
};
goods_up.goods_up_index = 0;
goods_up.addRow = function() {
	$(goods_up.dgId).datagrid('appendRow', {});
	$(goods_up.dgId).datagrid('beginEdit',  $(goods_up.dgId).datagrid('getRows').length-1);
}
goods_up.delRow = function() {
	var rowNums = $(goods_up.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(goods_up.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(goods_up.dgId).datagrid('clearChecked');
}
goods_up.clearRow=function(){
	var item = $(goods_up.dgId).datagrid('getRows'); 
	if (item) {  
	    for (var i = item.length - 1; i >= 0; i--) {  
	        var index = $(goods_up.dgId).datagrid('getRowIndex', item[i]);
	        $(goods_up.dgId).datagrid('cancelEdit', index).datagrid('deleteRow', index);  
	    }
	    goods_up.goods_up_index =0;
	} 
}

goods_up.back=function(){
	$(goods_up_list.up_panel).hide();
	$(goods_up_list.list_panel).show();
};
goods_up.save=function(){
	$(goods_up.dgId).datagrid('acceptChanges');
	var materials = $(goods_up.dgId).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		 if(materials[i].channelCode!=='81'){
			 $.messager.alert('请核渠道代码', '第' + (i + 1) + '行渠道代码只能为81渠道！', 'warning');
			 $(goods_up.dgId).datagrid('beginEdit', i);  
				return;
			}
		 if ($.o2m.isEmpty(materials[i].price) || $.o2m.isEmpty(materials[i].commission)) {
			$.messager.alert('请核实价格佣金', '第' + (i + 1) + '行数据无价格佣金！', 'warning');
			$(goods_up.dgId).datagrid('beginEdit', i);  
			return;
		}
		
	};
	var billId = $(goods_up.billId).val();
	if($.o2m.isEmpty(billId)){
		billId = 0;
	}
	if(materials.length < 1){
		$.messager.alert('警告', '请添加商品信息！', 'warning');
		return;
	}
	var upGoods={};
	upGoods.skus=materials;
	upGoods.funId=1;
	$.ajax({
		type : "POST",
		url : "goodsManage/saveUpGoods/"+billId,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(upGoods),
		success : function(msg) {
			if($.o2m.handleActionResult(msg)){
				$(goods_up.dgId).datagrid({data : null});
				$(goods_up_list.up_panel).hide();
				$(goods_up_list.list_panel).show();
				$(goods_up_list.dgId).datagrid('reload');
			}
		}
	});
};
goods_up.getSkuInfo=function(obj){
	var i = parseInt($(obj).parents('tr').attr('datagrid-row-index'));
	$(goods_up.dgId).datagrid('acceptChanges');
	var row = $(goods_up.dgId).datagrid('getRows')[i];
	if($.o2m.isEmpty(row.skuCode) ||  $.o2m.isEmpty(row.saleOrgCode)){
		$.messager.alert('警告', '必输项需要输入！', 'warning');
		$(goods_up.dgId).datagrid('beginEdit',i);
		return;
	}else if($.o2m.isEmpty(row.price) || $.o2m.isEmpty(row.commission) ){
		var data = {};
		data.saleOrgCode = row.saleOrgCode;
		data.channelCode = row.channelCode;
		data.skuCode = row.skuCode;
		data.funId=1;
		$.ajax({  
			type:"post",
			dataType:"json",
			contentType:"application/json",               
			url:"goodsManage/getSkuInfo",  
			data:JSON.stringify(data),  
			async:false,  
			success:function(result) {
				if($.o2m.handleActionResult(result)){
					row.skuName = result.data.skuName;
					row.price = result.data.price;
					row.commission = result.data.commission;
					$(goods_up.dgId).datagrid('refreshRow',i);
					if($.o2m.isEmpty(row.price) || $.o2m.isEmpty(row.commission)){
						$.messager.alert('警告', '未查到价格佣金', 'warning');
						$(goods_up.dgId).datagrid('beginEdit',i);
					}
				}else{
					$(goods_up.dgId).datagrid('beginEdit',i);
				}
			}
		});  
	}
}

goods_up.handleImportResult = function(data){
	$(goods_up.dgId).datagrid({data:data});
}
goods_up.importStocks=function(){
	parent.$.modalDialog({
		title : '导入上架商品',
		width : 400,
		height :250,
		closable : false,
		href : 'common/import/importData?templateName=ExamineSkus&actionName=skuUpExport&fnName=goods_up.handleImportResult',
		buttons : [ 
		{
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		}]
	});
};
	
goods_up.inits();

