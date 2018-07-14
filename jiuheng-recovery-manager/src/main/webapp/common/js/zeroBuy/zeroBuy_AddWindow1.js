var zeroBuy_addss = {};
zeroBuy_add_pageId1 = "#zeroBuy_Add_Page1";
zeroBuy_addss.dgId1 = zeroBuy_add_pageId1+ " #dg1";
zeroBuy_addss.billId1 = zeroBuy_add_pageId1+" #billId1";
zeroBuy_addss.tbId1 = zeroBuy_add_pageId1+" #tb1";
zeroBuy_addss.salAgencyCodeId1=zeroBuy_add_pageId1+" #salAgencyCode1";
zeroBuy_addss.orderNum1=zeroBuy_add_pageId1+" #orderNum1";
zeroBuy_addss.but=zeroBuy_add_pageId1+" #but";
/**
 * 页面初始化函数
 */
zeroBuy_addss.inits = function() {
	$(zeroBuy_addss.dgId1).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		onDblClickRow : function(index,row){
			if ($.o2m.isEmpty(row.skuCode) ||$.o2m.isEmpty(row.skuName) ) {
				$(zeroBuy_addss.dgId1).datagrid('beginEdit',index);
			}
		},
		columns : [ [ {
			field : 'cb',
			width : 10,
			checkbox : true
		}, {
			field : 'skuCode',
			title : 'SKU编码',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true}}
		}, {
			field : 'channelCode',
			title : '渠道编码',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true}}
		},{
			field : 'getsInfo',
			title : '获取sku信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="zeroBuy_addss.getSkuInfo(this);">查询</a>';
			}
		}, {
			field : 'skuName',
			title : 'SKU名称',
			align:'center',
			width : 100,
		}, {
			field : 'limitNum',
			title : '限制数量',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true}}
		}, {
			field : 'distributionFee',
			title : '配送运费',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		}] ],
		toolbar : zeroBuy_addss.tbId1
	});
};

zeroBuy_addss.addRow = function() {
	var orderAgencyCode=$('#orderAgencyCode1').val();
		$(zeroBuy_addss.dgId1).datagrid('appendRow', {});
	
}

zeroBuy_addss.delRow=function(){
	var rowNums = $(zeroBuy_addss.dgId1).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(zeroBuy_addss.dgId1).datagrid('deleteRow',rowNums[i]-1);
	}
	$(zeroBuy_addss.dgId1).datagrid('clearChecked');
}

zeroBuy_addss.back=function(){
	$(zeroBuy_detailed.add_panel).panel('close');
	$(zeroBuy_detailed.zeroBuy_list_detailed_form).show();
	$(zeroBuy_detailed.dgId).datagrid('reload')
}

zeroBuy_addss.getSkuInfo=function(obj){
	var i = parseInt($(obj).parents('tr').attr('datagrid-row-index'));
	$(zeroBuy_addss.dgId1).datagrid('acceptChanges');
	var materials = $(zeroBuy_addss.dgId1).datagrid('getRows');
	var row = $(zeroBuy_addss.dgId1).datagrid('getRows')[i];
	var salAgencyCode=$(zeroBuy_addss.salAgencyCodeId1).val();
	if(null==salAgencyCode||""==salAgencyCode){
		$.messager.alert('提示','请先选择销售组织','info');
		return;
	}
	if($.o2m.isEmpty(row.skuCode)||$.o2m.isEmpty(row.channelCode)){
		$.messager.alert('警告', '必输项需要输入！', 'warning');
		$(zeroBuy_addss.dgId1).datagrid('beginEdit',i);
		return;
	}else if($.o2m.isEmpty(row.skuName) ){
		var data = {};
		data.skuCode = row.skuCode;
		data.channelCode = row.channelCode;
		data.saleOrgCode = salAgencyCode;
		for(var j=0;j<materials.length-1;j++){
			if(i!=j){
			if(row.skuCode==materials[j].skuCode){
				$.messager.alert('警告','该商品已添加，请选其他商品添加！','info');
				return false;
				}
			}
		}
		$.ajax({  
			type:"post",
			dataType:"json",
			contentType:"application/json",               
			url:"zeroBuy/getUpSkuInfo",  
			data:JSON.stringify(data),  
			async:false,  
			success:function(result) {
				if($.o2m.handleActionResult(result)){
					row.skuName = result.data.skuName;
					$(zeroBuy_addss.dgId1).datagrid('refreshRow',i);
					if($.o2m.isEmpty(row.skuName)){
						$.messager.alert('警告', '未查到该SKU名称', 'warning');
						$(zeroBuy_addss.dgId1).datagrid('beginEdit',i);
					}
				}else{
					$(zeroBuy_addss.dgId1).datagrid('beginEdit',i);
				}
			}
		});  
	}
}
zeroBuy_addss.saveNew=function(){
	$(zeroBuy_addss.dgId1).datagrid('acceptChanges');
	var materials = $(zeroBuy_addss.dgId1).datagrid('getRows');
	$(zeroBuy_addss.but).attr({"disabled":"disabled"});
	var salAgencyCode=$(zeroBuy_addss.salAgencyCodeId1).val();
	var orderNum=$(zeroBuy_addss.orderNum1).val();
	for(var j=0;j<materials.length;j++){
		if($.o2m.isEmpty(materials[j].skuName)){
			$.messager.alert('提示','请将商品信息填写完整','info');
			return false;
		}
	}
	var savezeroBuy={};
	savezeroBuy.skus=materials;
	$.ajax({
		type : "POST",
		url : "zeroBuy/addzeroBuyss?salAgencyCode="+salAgencyCode+"&orderNum="+orderNum,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(savezeroBuy),
		success : function(data) {
			if(data.code==0){
				$.messager.alert('提示',data.msg,'success');
			}else if(data.code==1){
				$.messager.alert('警告',data.msg,'info');
			}
		}
	});

}
zeroBuy_addss.inits();

