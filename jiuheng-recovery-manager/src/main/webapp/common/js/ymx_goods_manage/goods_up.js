var ymx_goods_up = {};
 
ymx_goods_up_pageId = "#ymx_goods_up_page";
ymx_goods_up.dgId = ymx_goods_up_pageId+ " #dg";
ymx_goods_up.tbId = ymx_goods_up_pageId+" #tb";
ymx_goods_up.billId = ymx_goods_up_pageId+" #billId";
ymx_goods_up.numberattr = ymx_goods_up_pageId+" #numberattr";

/**
 * 页面初始化函数
 */
ymx_goods_up.inits = function() {
	$(ymx_goods_up.dgId).datagrid({
		striped : true,
		rownumbers : true,
		fitColumns : true,
		//checkOnSelect : false,
		onDblClickRow : function(index,row){
			if (($.o2m.isEmpty(row.termPrice) && $.o2m.isEmpty(row.longPrice)) || $.o2m.isEmpty(row.commission)) {
				$(ymx_goods_up.dgId).datagrid('beginEdit',index);
			}
		},
		url:'ymx_goodsManage/getGoodsExamialDetail?billId='+$(ymx_goods_up.billId).val(),
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
			field : 'installFlag',
			title : '安装标记',
			align : 'center',
			width : 60,
			editor:{type:'checkbox',options:{on:'1',off:'0'}}
		},{
			field : 'channelCode',
			title : '渠道编码',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
			
		}, {
			field : 'getSkuInfo',
			title : '获取SKU信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="ymx_goods_up.getSkuInfo(this);">查询</a>';
			}
		}, {
			field : 'skuName',
			title : 'SKU名称',
			align:'center',
			width : 200
		},  {
			field : 'termPrice',
			title : '期间价格',
			align:'center',
			width : 100
		}
		,
		{
			field : 'longPrice',
			title : '长期售价',
			align:'center',
			width : 100
		}
		,{
			field : 'fromType',
			hidden : true
		}] ],
		onBeforeLoad : function(){
			if($(ymx_goods_up.billId).val() == ''){
				return false;
			}
		},
		toolbar : ymx_goods_up.tbId
	});
};
ymx_goods_up.goods_up_index = 0;
ymx_goods_up.addRow = function() {
	$(ymx_goods_up.dgId).datagrid('appendRow', {});
	$(ymx_goods_up.dgId).datagrid('beginEdit',  $(ymx_goods_up.dgId).datagrid('getRows').length-1);
}
ymx_goods_up.delRow = function() {
	var rowNums = $(ymx_goods_up.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(ymx_goods_up.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(ymx_goods_up.dgId).datagrid('clearChecked');
}
ymx_goods_up.clearRow=function(){
	var item = $(ymx_goods_up.dgId).datagrid('getRows');  
	if (item) {  
	    for (var i = item.length - 1; i >= 0; i--) {  
	        var index = $(ymx_goods_up.dgId).datagrid('getRowIndex', item[i]);
	        $(ymx_goods_up.dgId).datagrid('cancelEdit', index).datagrid('deleteRow', index);  
	    }
	    ymx_goods_up.goods_up_index =0;
	} 
}

ymx_goods_up.back=function(){
	$(ymx_goods_up_list.up_panel).hide();
	$(ymx_goods_up_list.list_panel).show();
};
ymx_goods_up.save=function(){
	$(ymx_goods_up.dgId).datagrid('acceptChanges');
	var materials = $(ymx_goods_up.dgId).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		if ((!$.o2m.isEmpty(materials[i].channelCode) && materials[i].channelCode!=82)) {
			 $.messager.alert('请核渠道代码', '第' + (i + 1) + '行渠道代码只能为82渠道！', 'warning');
			 $(goods_up.dgId).datagrid('beginEdit', i);  
				return;
		}
		
		if (($.o2m.isEmpty(materials[i].termPrice) && $.o2m.isEmpty(materials[i].longPrice))) {
			$.messager.alert('请核实价格', '第' + (i + 1) + '行数据无期间价格和长期价格！', 'warning');
			$(ymx_goods_up.dgId).datagrid('beginEdit', i);  
			return;
		}
	};
	var billId = $(ymx_goods_up.billId).val();
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
		url : "ymx_goodsManage/saveUpGoods/"+billId,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(upGoods),
		success : function(msg) {
			if($.o2m.handleActionResult(msg)){
				$(ymx_goods_up.dgId).datagrid({data : null});
				$(ymx_goods_up_list.up_panel).hide();
				$(ymx_goods_up_list.list_panel).show();
				$(ymx_goods_up_list.dgId).datagrid('reload');
			}
		}
	});
};
ymx_goods_up.getSkuInfo=function(obj){
	var i = parseInt($(obj).parents('tr').attr('datagrid-row-index'));
	$(ymx_goods_up.dgId).datagrid('acceptChanges');
	var row = $(ymx_goods_up.dgId).datagrid('getRows')[i];
	
	if($.o2m.isEmpty(row.skuCode)  || $.o2m.isEmpty(row.saleOrgCode)){
		$.messager.alert('警告', '必输项需要输入！', 'warning');
		$(ymx_goods_up.dgId).datagrid('beginEdit',i);
		return;
	}else if(($.o2m.isEmpty(row.termPrice) && $.o2m.isEmpty(row.longPrice))  ){
		var data = {};
		data.saleOrgCode = row.saleOrgCode;
		data.channelCode = 82;
		data.skuCode = row.skuCode;
		data.funId=1;
		$.ajax({  
			type:"post",
			dataType:"json",
			contentType:"application/json",               
			url:"ymx_goodsManage/getSkuInfo",  
			data:JSON.stringify(data),  
			async:false,  
			success:function(result) {
				if($.o2m.handleActionResult(result)){
					row.skuName = result.data.skuName;//skuName
					row.termPrice = result.data.termPrice;//期间价格
					
					row.longPrice = result.data.longPrice;//长期售价
				
					//alert(row.termPrice + '-' + row.longPrice);
					
					$(ymx_goods_up.dgId).datagrid('refreshRow',i);
					if(($.o2m.isEmpty(row.termPrice) && $.o2m.isEmpty(row.longPrice)) ){
						$.messager.alert('警告', '未查到价格', 'warning');
						$(ymx_goods_up.dgId).datagrid('beginEdit',i);
					}
				}else{
					$(ymx_goods_up.dgId).datagrid('beginEdit',i);
				}
			}
		});  
	}
}

ymx_goods_up.handleImportResult = function(data){
	$(ymx_goods_up.dgId).datagrid({data:data});
}
ymx_goods_up.importStocks=function(){
	parent.$.modalDialog({
		title : '导入上架商品',
		width : 400,
		height :250,
		closable : false,
		href : 'common/import/importData?templateName=ExamineSkus&actionName=skuUpExport&fnName=ymx_goods_up.handleImportResult',
		buttons : [ 
		{
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		}]
	});
};
	
ymx_goods_up.inits();

