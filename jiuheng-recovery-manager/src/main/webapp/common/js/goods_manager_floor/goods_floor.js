var splc_goods_up = {};

splc_goods_up_pageId = "#goods_up_page11";
splc_goods_up.dgId = splc_goods_up_pageId+ " #dg";
splc_goods_up.tbId = splc_goods_up_pageId+" #tb";
splc_goods_up.djbh = splc_goods_up_pageId+" #djbh";
splc_goods_up.numberattr = splc_goods_up_pageId+" #numberattr";
splc_goods_up.saveupdateFlag = splc_goods_up_pageId+" #saveupdateFlag";
splc_goods_up.spptfldm = splc_goods_up_pageId+" #spptfldm";
splc_goods_up.spptflmc = splc_goods_up_pageId+" #spptflmc";


$(function(){
	
	/*$("#goods_up_page11 #xxzjList").click(function(){
		var reg = /^[0-9]*$/;
		var reg1 = /^-/;
		var obj = document.getElementById("xxzjList");
		obj.onkeyup = function() {
		var lastV =obj.value.substring(obj.value.length-1)
		 	if (!reg.test(lastV) && obj.value.length%5!=0){
				obj.value = obj.value.substring(0,obj.value.length-1);
			}
			
 			if(obj.value.length%5==0){
 			
 			if(reg1.test(lastV)){
 				return ;
 			}
			var lastValue = obj.value.substring(obj.value.length-1);
			var value  =obj.value.substring(0,obj.value.length-1);
			if(lastValue !=""){
				obj.value = value+"-";
			}
			} 
	}
 });*/

	
$(":radio[name='Zbfgfblx']").click(function(){
    var index = $(":radio[name='Zbfgfblx']").index($(this));
    if(index == 1) //选中第2个时，div显示
    {
    	if ($("#goods_up_page11 #xszzdm").val() == '') {
    	 $.messager.alert("操作提示","销售组织代码不允许为空!");
    	$(":radio[name='Zbfgfblx']").removeAttr("checked");
		return ;
    	} else if ($("#goods_up_page11 #xszzdm").val() != 'GMZB') {
    	$.messager.alert("操作提示","只能GMZB才能覆盖分部楼层!");
    	$(":radio[name='Zbfgfblx']").removeAttr("checked");
		return ;
    	}
    $("#goods_up_page11 #goods_xxzjList").show();
    } else {
    	//当被选中的不是第2个时，div隐藏
        $("#goods_up_page11 #goods_xxzjList").hide();
    }
         
     
});
});

/**
 * 页面初始化函数
 */
splc_goods_up.inits = function() {
	 $("#goods_up_page11 #indexGoodsAdd #goods_xxzjList").hide();
	$(splc_goods_up.dgId).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		url:'wareFloor/getLcflDetailJson?djbh='+$(splc_goods_up.djbh).val()+"&spptfldm="+$(splc_goods_up.spptfldm).val(),
		checkOnSelect : false,
		onDblClickRow : function(index,row){
			$(splc_goods_up.dgId).datagrid('beginEdit',index);
		},
		columns : [ [ {
			field : 'cb',
			width : 10,
			checkbox : true
		}, {
			field : 'getSkuInfo',
			title : '获取SKU信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="splc_goods_up.getSkuInfo(this);">查询</a>';
			}
		},  {
			field : 'skuId',
			title : 'SKU编码',
			align:'center',
			width : 100
		}, {
			field : 'skuName',
			title : 'SKU名称',
			align:'center',
			width : 100
		},{
			field : 'skuOrderId',
			title : '排序',
			align:'center',
			width : 100,
			value : ' ',
			editor:{type:'numberbox',options:{required:true,max :4,min:1}}
		}] ],
		toolbar : splc_goods_up.tbId
	});
	if ($('input:radio:checked').val() ==1) {
		$("#goods_up_page11 #goods_xxzjList").show();
	}
};

splc_goods_up.getSkuInfo=function(obj){
	var i =$(obj).parents('tr').attr('datagrid-row-index');
	if ( $("#goods_up_page11 #xszzdm").val() =='') {
	 $.messager.alert("操作提示","销售组织代码不允许为空!");
	return ;
	}
	var xszzdm = $("#goods_up_page11 #xszzdm").val();
	if(i<=5){
		$('#magnifier').window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        method:'post',
        href: "wareFloor/queryFdj?type=2&i="+i+"&xszzdm="+xszzdm+"&xsqddm=81",
        title: "查询SKU"
    });
	
	$('#magnifier').window('open');
	
	
	}else{
		var row = $(indexGoods_add.dgId).datagrid('getRows')[i];
		row.code = 6-i;
		row.id = 6-i;
	}
	
	 $(splc_goods_up.dgId).datagrid('updateRow',{
			index : parseInt(i),
			row : row
		});

}

splc_goods_up.goods_up_index = 0;
splc_goods_up.addRow = function() {
	if($(splc_goods_up.dgId).datagrid('getRows').length==4){
		$.messager.alert('消息提示','SKU已添加满，不能再继续添加','inof');
		return false;
	}
	$(splc_goods_up.dgId).datagrid('appendRow', {showNum : $(splc_goods_up.dgId).datagrid('getRows').length+1});
}
splc_goods_up.delRow = function() {
	
	var rowNums = $(splc_goods_up.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(splc_goods_up.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(splc_goods_up.dgId).datagrid('clearChecked');
}
splc_goods_up.clearRow=function(){
	var item = $(splc_goods_up.dgId).datagrid('getRows');  
	if (item) {  
	    for (var i = item.length - 1; i >= 0; i--) {  
	        var index = $(splc_goods_up.dgId).datagrid('getRowIndex', item[i]);
	        $(splc_goods_up.dgId).datagrid('cancelEdit', index).datagrid('deleteRow', index);  
	    }
	    splc_goods_up.goods_up_index =0;
	} 
}

splc_goods_up.back=function(){
	$(splc_goods_up_list.up_panel).hide();
	$(splc_goods_up_list.list_panel).show();
};
splc_goods_up.save=function(){
	if ( $("#goods_up_page11 #lcwzlx").val() =='') {
	 $.messager.alert("操作提示","类型不允许为空!");
	return ;
	}
	
	if ( $("#goods_up_page11 #xszzdm").val() =='') {
	 $.messager.alert("操作提示","销售组织代码不允许为空!");
	return ;
	}
	
	if ( $("#goods_up_page11 #spptflmc").val() =='') {
	 $.messager.alert("操作提示","楼层分类不允许为空!");
	return ;
	}
	
	if ( $("#goods_up_page11 #spptfldmOrderId").val() =='') {
	 $.messager.alert("操作提示","楼层分类排序不允许为空!");
	return ;
	}
	
	var val=$('input:radio[name="Zbfgfblx"]:checked').val();
    if(val==null){
         $.messager.alert("操作提示","是否覆盖分部楼层没选中!");
        return ;
    } else if (val ==1) {
//	    if ( $("#goods_up_page #xxzjList").val() =='') {
//		 $.messager.alert("操作提示","是否覆盖分部楼层例外不允许为空!");
//		return ;
//		 var lw = /^\d{4}-*\d{4}$/;
//     	var obj = $("#goods_up_page #xxzjList").val();
//    	if(!lw.test(obj)){
//        $.messager.alert("操作提示","是否覆盖分部楼层例外格式不正确,请参照{1111-1002-1003}格式!!");
//        return;
//    }
//	}
    	if ( $("#goods_up_page11 #xxzjList").val() !='') {
    	var lw = /^(.{4}-)*.{4}$/;
     	var obj = $("#goods_up_page11 #xxzjList").val();
    	if(!lw.test(obj)){
        $.messager.alert("操作提示","是否覆盖分部楼层例外格式不正确,请参照{1111-1002-1003}格式!!");
        return;
    	}
    	}
    }
    var z= /^[0-7]{1}$/;
    var obj = $("#goods_up_page11 #spptfldmOrderId").val() ;
    if(!z.test(obj)){
        $.messager.alert("操作提示","楼层分类排序请输入1位数字最大值不能超过7!!");
        return;
    }
    var leng = /^[0-9a-zA-Z]{4}$/;
    var obj = $("#goods_up_page11 #xszzdm").val();
    if(!leng.test(obj)){
        $.messager.alert("操作提示","销售组织代码只能字母數字4位!!");
        return;
    }
    
    if ( $("#goods_up_page11 #xszzdm").val() !='GMZB') {
    	if ($('input:radio[name="Zbfgfblx"]:checked').val() ==1) {
    	 $.messager.alert("操作提示","销售组织代码"+$("#goods_up_page11 #xszzdm").val()+"不允许覆盖分部!");
		return ;
    	}
	
	}
    
   
	
	$(splc_goods_up.dgId).datagrid('acceptChanges');
	var materials = $(splc_goods_up.dgId).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		//alert(materials[i].skuOrderId);
		if (($.o2m.isEmpty(materials[i].skuId))) {
			$.messager.alert('请核实数据', '第' + (i + 1) + '行数据无SKU编码！', 'warning');
			$(splc_goods_up.dgId).datagrid('beginEdit', i);  
			return;
		}
		
		if (($.o2m.isEmpty(materials[i].skuName))) {
			$.messager.alert('请核实数据', '第' + (i + 1) + '行数据无SKU名称！', 'warning');
			$(splc_goods_up.dgId).datagrid('beginEdit', i);  
			return;
		}
		
		if (($.o2m.isEmpty(materials[i].skuOrderId))) {
			$.messager.alert('请核实数据', '第' + (i + 1) + '行数据无SKU排序！', 'warning');
			$(splc_goods_up.dgId).datagrid('beginEdit', i);  
			return;
		}
		
		 var z= /^[1-4]{1}$/;
    	var obj = materials[i].skuOrderId ;
    if(!z.test(obj)){
        $.messager.alert('请核实数据','第' + (i + 1) + '行数据楼层分类排序请输入1到4的顺序数字!!','warning');
        return;
    }
		
	}
	for (var i = 0; i < materials.length; i++) {
		for (var j = i + 1; j < materials.length; j++) {
			if ((materials[i].skuOrderId == materials[j].skuOrderId)) {
			$.messager.alert('请核实排序', '排序不能一样', 'warning');
			$(splc_goods_up.dgId).datagrid('beginEdit', i);  
			return;
			}
//			alert(materials[i].skuId);
//			alert(materials[j].skuId);
			if ((materials[i].skuId == materials[j].skuId)) {
			$.messager.alert('请核实SKUID', 'SKUID不能一样', 'warning');
			$(splc_goods_up.dgId).datagrid('beginEdit', i);  
			return;
		
			}
		}
	};
	
	
	if(materials.length < 1){
		$.messager.alert('警告', '请添加商品信息！', 'warning');
		return;
	}
	
	if(materials.length < 4){
		$.messager.alert('警告', '必须添加4个SKU！', 'warning');
		return;
	}
	
	
	
	var upGoods={};
	var djbh = $(splc_goods_up.djbh).val();
	if($.o2m.isEmpty(djbh)){
		djbh = 0;
	} else {
		upGoods.djbh=djbh;
	}
	upGoods.saveupdateFlag=$(splc_goods_up.saveupdateFlag).val();
	upGoods.skuList=materials;
	upGoods.lcwzlx=0;//先写死到时候改
	upGoods.xszzdm=$("#goods_up_page11 #xszzdm").val();
	upGoods.spptfldm=$("#goods_up_page11 #spptfldm").val();
	upGoods.spptfldmOrderId=$("#goods_up_page11 #spptfldmOrderId").val();
	//alert($('input:radio:checked').val());
	upGoods.zbfgfblx=$('input:radio:checked').val();
	if ($('input:radio:checked').val() ==1) {
	upGoods.xxzjList=$("#goods_up_page11 #xxzjList").val();
		    if ( $("#goods_up_page11 #xxzjList").val() !='') {
		 		upGoods.zbfgfblx=2;
		    }
	} 
	
//	alert(JSON.stringify(upGoods));
//	return;
	//alert(JSON.stringify(upGoods));
	//return;
	$.ajax({
		type : "POST",
		url : "wareFloor/saveUpGoods/"+djbh,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(upGoods),
		success : function(msg) {
			if($.o2m.handleActionResult(msg)){
				//alert(msg.data);
//				$(splc_goods_up.dgId).datagrid({data : null});
//				$(splc_goods_up_list.up_panel).hide();
//				$(splc_goods_up_list.list_panel).show();
//				$(splc_goods_up_list.dgId).datagrid('reload');
				$(splc_goods_up_list.list_panel).hide();
				$(splc_goods_up_list.up_panel).panel({href:"wareFloor/viewDjbhDetail/"+msg.data});
				$(splc_goods_up_list.up_panel).show();
			}
		}
	});
};


splc_goods_up.handleImportResult = function(data){
	$(splc_goods_up.dgId).datagrid({data:data});
}
splc_goods_up.importStocks=function(){
	parent.$.modalDialog({
		title : '导入上架商品',
		width : 400,
		height :250,
		closable : false,
		href : 'common/import/importData?templateName=ExamineSkus&actionName=skuUpExport&fnName=splc_goods_up.handleImportResult',
		buttons : [ 
		{
			text : '关闭',
			handler : function(data) {
				parent.$.modalDialog.handler.dialog('close');
			}
		}]
	});
};

splc_goods_up.getlcfl=function(obj){
//	if ( $("#goods_up_page11 #xszzdm").val() =='') {
//	 $.messager.alert("操作提示","销售组织代码不允许为空!");
//	return ;
//	}
	
		$('#magnifier').window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        method:'post',
        href: "wareFloor/goLcfl",
        title: "查询楼层分类"
    });
	$('#magnifier').window('open');
	//$('#spptfldm').val();
//	$(splc_goods_up.dgId).datagrid('updateRow',{
//			index : parseInt(i),
//			row : row
//		});
	
	
	

}
	
splc_goods_up.inits();

