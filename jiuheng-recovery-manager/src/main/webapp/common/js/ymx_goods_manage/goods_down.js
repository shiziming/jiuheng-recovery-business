var ymx_goods_down = {};

ymx_goods_down_pageId = "#ymx_goods_down_page";
ymx_goods_down.dgId = ymx_goods_down_pageId+ " #dg";
ymx_goods_down.tbId = ymx_goods_down_pageId+" #tb";
ymx_goods_down.billId = ymx_goods_down_pageId+" #billId";
ymx_goods_down.numberattr = ymx_goods_down_pageId+" #numberattr";

/**
 * 页面初始化函数
 */
ymx_goods_down.inits = function() {
	$(ymx_goods_down.dgId).datagrid({
		striped : true,
		rownumbers : true,
		pagination : false,
		fitColumns : true,
		onDblClickRow : function(index,row){
			if ($.o2m.isEmpty(row.price) || $.o2m.isEmpty(row.commission)) {
				$(ymx_goods_down.dgId).datagrid('beginEdit',index);
			}
		},
		url:'ymx_goodsManage/getGoodsExamialDetail?billId='+$(ymx_goods_down.billId).val(),
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
		},{
			field : 'channelCode',
			title : '渠道编码',
			align : 'center',
			width : 60,
			editor:{type:'textbox',options:{required:true}}
			
		}
		,{
			field : 'saleOrgCode',
			title : '销售组织编码',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		}, {
			field : 'getSkuInfo',
			title : '获取SKU信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="ymx_goods_down.getSkuInfo(this);">查询</a>';
			}
		}, {
			field : 'skuName',
			title : 'SKU名称',
			align:'center',
			width : 200
		},{
			field : 'fromType',
			hidden : true
		}] ],
		onBeforeLoad : function(){
			if($(ymx_goods_down.billId).val() == ''){
				return false;
			}
		},
		toolbar : ymx_goods_down.tbId
	});
};
ymx_goods_down.addRow = function() {
	$(ymx_goods_down.dgId).datagrid('appendRow', {installFlag:0,price:0,commission:0});
	$(ymx_goods_down.dgId).datagrid('beginEdit', $(ymx_goods_down.dgId).datagrid('getRows').length-1);
}

ymx_goods_down.delRow = function() {
	var rowNums = $(ymx_goods_down.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(ymx_goods_down.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(ymx_goods_down.dgId).datagrid('clearChecked');
}
ymx_goods_down.clearRow=function(){
	var item = $(ymx_goods_down.dgId).datagrid('getRows');  
	if (item) {  
	    for (var i = item.length - 1; i >= 0; i--) {  
	        var index = $(ymx_goods_down.dgId).datagrid('getRowIndex', item[i]);
	        $(ymx_goods_down.dgId).datagrid('cancelEdit', index).datagrid('deleteRow', index);  
	    }
	    ymx_goods_down.goods_down_index =0;
	} 
}

ymx_goods_down.back=function(){
	$(ymx_goods_down_list.down_panel).hide();
	$(ymx_goods_down_list.list_panel).show();
};
ymx_goods_down.save=function(){
	$(ymx_goods_down.dgId).datagrid('acceptChanges');
	var materials = $(ymx_goods_down.dgId).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		if(materials[i].channelCode!=='82'){
			$.messager.alert('请核渠道代码','第'+(i+1)+'行渠道代码只能为82渠道!','warning');
			$(ymx_goods_down.dgId).datagrid('beginEdit',i);
			return;
		}
		if ($.o2m.isEmpty(materials[i].skuName)) {
			$.messager.alert('请核实数据', '第' + (i + 1) + '行数据sku名称！', 'warning');
			$(ymx_goods_down.dgId).datagrid('beginEdit', i);  
			return;
		}
	};
	var billId = $(ymx_goods_down.billId).val();
	if($.o2m.isEmpty(billId)){
		billId = 0;
	}
	if(materials.length < 1){
		$.messager.alert('警告', '请添加商品信息！', 'warning');
		return;
	}
	var upGoods={};
	upGoods.skus=materials;
	upGoods.funId=2;
	$.ajax({
		type : "POST",
		url : "ymx_goodsManage/saveUpGoods/"+billId,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(upGoods),
		success : function(msg) {
			if($.o2m.handleActionResult(msg)){
				$(ymx_goods_down.dgId).datagrid({data : null});
				$(ymx_goods_down_list.down_panel).hide();
				$(ymx_goods_down_list.list_panel).show();
				$(ymx_goods_down_list.dgId).datagrid('reload');
			}
		}
	});
};
ymx_goods_down.getSkuInfo=function(obj){
	var i = parseInt($(obj).parents('tr').attr('datagrid-row-index'));
	$(ymx_goods_down.dgId).datagrid('acceptChanges');
	var row = $(ymx_goods_down.dgId).datagrid('getRows')[i];
	if($.o2m.isEmpty(row.skuCode) || $.o2m.isEmpty(row.saleOrgCode)){
		$.messager.alert('警告', '必输项需要输入！', 'warning');
		$(ymx_goods_down.dgId).datagrid('beginEdit',i);
		return;
	}else if($.o2m.isEmpty(row.skuName)){
		var data = {};
		data.saleOrgCode = row.saleOrgCode;
		data.channelCode = 82;
		data.skuCode = row.skuCode;
		data.funId=2;
		$.ajax({  
			type:"post",
			dataType:"json",
			contentType:"application/json",               
			url:"ymx_goodsManage/getSkuInfo",  
			data:JSON.stringify(data),  
			async:false,  
			success:function(result) {
				if($.o2m.handleActionResult(result)){
					row.skuName = result.data.skuName;
					$(ymx_goods_down.dgId).datagrid('refreshRow',i);
					if($.o2m.isEmpty(row.skuName)){
						$.messager.alert('警告', '未查到SKU', 'warning');
						$(ymx_goods_down.dgId).datagrid('beginEdit',i);
					}
				}else{
					$(ymx_goods_down.dgId).datagrid('beginEdit',i);
				}
			}
		});  
	}
}
ymx_goods_down.handleImportResult = function(data){
	for(var i = 0 ; i< data.length;i++){
		data[i].installFlag=0;
		data[i].price=0;
		data[i].commission=0;
	}
	$(ymx_goods_down.dgId).datagrid({data:data});
}
ymx_goods_down.importStocks=function(){
	parent.$.modalDialog({
		title : '导入下架商品',
		width : 400,
		height :250,
		closable : false,
		href : 'common/import/importData?templateName=ExamineSkus&actionName=skuDownExport&fnName=ymx_goods_down.handleImportResult',
		buttons : [ 
		{
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		}]
	});
};
	
ymx_goods_down.inits();

