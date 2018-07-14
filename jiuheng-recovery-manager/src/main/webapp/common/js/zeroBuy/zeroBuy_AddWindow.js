var zeroBuy_add = {};

zeroBuy_add_pageId = "#zeroBuy_Add_Page";
zeroBuy_add.dgId = zeroBuy_add_pageId+ " #dg";
zeroBuy_add.billId = zeroBuy_add_pageId+" #billId";
zeroBuy_add.tbId = zeroBuy_add_pageId+" #tb";
zeroBuy_add.salAgencyCodeId=zeroBuy_add_pageId+" #salAgencyCodeId";
zeroBuy_add.activityId=zeroBuy_add_pageId+" #activityId";
zeroBuy_add.activityName=zeroBuy_add_pageId+" #activityName";
zeroBuy_add.startDate=zeroBuy_add_pageId+" #startDate";
zeroBuy_add.endDate=zeroBuy_add_pageId+" #endDate";
zeroBuy_add.but=zeroBuy_add_pageId+" #but";
zeroBuy_add.endDateId=zeroBuy_add_pageId+" #endDateId";
zeroBuy_add.startDateId=zeroBuy_add_pageId+" #startDateId";
/**
 * 页面初始化函数
 */
zeroBuy_add.inits = function() {
	$(zeroBuy_add.dgId).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		onDblClickRow : function(index,row){
			if ($.o2m.isEmpty(row.skuCode)||$.o2m.isEmpty(row.skuName)) {
				$(zeroBuy_add.dgId).datagrid('beginEdit',index);
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
				return  '<a href="#" onclick="zeroBuy_add.getSkuInfo(this);">查询</a>';
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
		toolbar : zeroBuy_add.tbId
	});
};

zeroBuy_add.addRow = function() {
	var orderAgencyCode=$('#orderAgencyCode').val();
		$(zeroBuy_add.dgId).datagrid('appendRow', {});
}
zeroBuy_add.queryActivity=function(){
	$("#magnifier").window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        href: "zeroBuy/openActivityMagnifierWindow",
        title: "活动查询"
    });
	$('#magnifier').window('open');
}

zeroBuy_add.delRow=function(){
	var rowNums = $(zeroBuy_add.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(zeroBuy_add.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(zeroBuy_add.dgId).datagrid('clearChecked');
}

zeroBuy_add.back=function(){
	$(zeroBuyManage.add).panel('close');
	$(zeroBuyManage.zeroBuy_list_list_panel).show();
	$(zeroBuyManage.zeroBuy_list_dg).datagrid('reload')
	
}

zeroBuy_add.getSkuInfo=function(obj){
	var i = parseInt($(obj).parents('tr').attr('datagrid-row-index'));
	$(zeroBuy_add.dgId).datagrid('acceptChanges');
	var materials = $(zeroBuy_add.dgId).datagrid('getRows');
	var row = $(zeroBuy_add.dgId).datagrid('getRows')[i];
	var salAgencyCode=$(zeroBuy_add.salAgencyCodeId).val();
	if(null==salAgencyCode||""==salAgencyCode){
		$.messager.alert('提示','请先选择销售组织','info');
		return;
	}
	if($.o2m.isEmpty(row.skuCode)||$.o2m.isEmpty(row.channelCode)){
		$.messager.alert('警告', '必输项需要输入！', 'warning');
		$(zeroBuy_add.dgId).datagrid('beginEdit',i);
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
					$(zeroBuy_add.dgId).datagrid('refreshRow',i);
					if($.o2m.isEmpty(row.skuName)){
						$.messager.alert('警告', '未查到该SKU名称', 'warning');
						$(zeroBuy_add.dgId).datagrid('beginEdit',i);
					}
				}else{
					$(zeroBuy_add.dgId).datagrid('beginEdit',i);
				}
			}
		});  
	}
}
zeroBuy_add.save=function(){
	$(zeroBuy_add.dgId).datagrid('acceptChanges');
	var materials = $(zeroBuy_add.dgId).datagrid('getRows');
	var salAgencyCode=$(zeroBuy_add.salAgencyCodeId).val();
	var activityId=$(zeroBuy_add.activityId).textbox('getText');
	var startDate=$(zeroBuy_add.startDate).datebox('getValue');
	var endDate=$(zeroBuy_add.endDate).datebox('getValue');
	var startDateId=$(zeroBuy_add.startDateId).val();
	var endDateId=$(zeroBuy_add.endDateId).val();
	$(zeroBuy_add.but).attr({"disabled":"disabled"});
	if($.o2m.isEmpty(salAgencyCode)){
		$.messager.alert('提示','请选择销售组织','info');
		return false;
	}
	if($.o2m.isEmpty(activityId)){
		$.messager.alert('提示','请选择活动','info');
		return false;
	}
	var arys1= new Array();     
    var arys2= new Array();
	var arys3= new Array();     
    var arys4= new Array();
    arys1=startDate.split('-');
    arys2=startDateId.split('-');
    arys3=endDate.split('-');
    arys4=endDateId.split('-');
    var newTime=arys1[0]+arys1[1]+arys1[2];
    var oldTime=arys2[0]+arys2[1]+arys2[2];
    var newTime1=arys3[0]+arys3[1]+arys3[2];
    var oldTime1=arys4[0]+arys4[1]+arys4[2];
    if(newTime-newTime1>0){
    	$.messager.alert('提示','活动开始时间不能大于活动结束时间','info');
    	return false;
    }
    if(newTime-oldTime1>0){
    	$.messager.alert('提示','活动开始时间不能大于预计活动结束时间','info');
    	return false;
    }
    if(newTime1-newTime<0){
    	$.messager.alert('提示','活动结束时间不能小于活动开始时间','info');
    	return false;
    }
    if(newTime1-oldTime<0){
    	$.messager.alert('提示','活动结束时间不能小于预计活动开始时间','info');
    	return false;
    }
    if(oldTime-newTime>0){
    	$.messager.alert('提示','活动开始时间不能小于活动预计开始时间','info');
    	return false;
    }
    if(oldTime1-newTime1<0){
    	$.messager.alert('提示','活动结束时间不能大于活动预计结束时间','info');
    	return false;
    }
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
		url : "zeroBuy/addzeroBuys?salAgencyCode="+salAgencyCode+"&activityId="+activityId+"&endDate="+endDate+"&startDate="+startDate,
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
zeroBuy_add.inits();

