var indexGoods_add = {};

indexGoods_add_pageId = "#indexGoods_Add_Page";
indexGoods_add.dgId = indexGoods_add_pageId+ " #dg";
indexGoods_add.billId = indexGoods_add_pageId+" #billId";
indexGoods_add.tbId = indexGoods_add_pageId+" #tb";
indexGoods_add.salAgencyCodeId=indexGoods_add_pageId+" #salAgencyCodeId";

/**
 * 页面初始化函数
 */
indexGoods_add.inits = function() {
	$(indexGoods_add.dgId).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		checkOnSelect : false,
		onDblClickRow : function(index,row){
			$(indexGoods_add.dgId).datagrid('beginEdit',index);
		},
		columns : [ [ {
			field : 'cb',
			width : 10,
			checkbox : true
		}, {
			field : 'getSpuInfo',
			title : '获取SPU信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="indexGoods_add.getSpuInfo(this);">查询</a>';
			}
		},  {
			field : 'code',
			title : 'SPU编码',
			align:'center',
			width : 100,
		}, {
			field : 'name',
			title : '商品名称',
			align:'center',
			width : 100,
		},{
			field : 'keyWord',
			title : '关键字',
			align:'center',
			width : 100,
		},{
			field : 'showNum',
			title : '图片显示位置',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true,max :6,min:1}}
		}, {
			field : 'id',
			title : '商品SpuId',
			align:'center',
			width : 100,
			hidden:true
		}] ],
		toolbar : indexGoods_add.tbId
	});
};

indexGoods_add.addRow = function() {
	var orderAgencyCode=$('#orderAgencyCode').val();
	var flag=$('#flag').val();
	if("GMZB"==orderAgencyCode){
		if(flag==1){
			if($(indexGoods_add.dgId).datagrid('getRows').length==6){
				$.messager.alert('消息提示','商品已添加满，不能再继续添加','inof');
				return false;
			}
			$(indexGoods_add.dgId).datagrid('appendRow', {showNum : $(indexGoods_add.dgId).datagrid('getRows').length+1});
		}else{
		if($(indexGoods_add.dgId).datagrid('getRows').length==8){
			$.messager.alert('消息提示','商品已添加满，不能再继续添加','inof');
			return false;
		}
		$(indexGoods_add.dgId).datagrid('appendRow', {showNum : $(indexGoods_add.dgId).datagrid('getRows').length+1});
		}
	}else{
		if($(indexGoods_add.dgId).datagrid('getRows').length==6){
			$.messager.alert('消息提示','商品已添加满，不能再继续添加','inof');
			return false;
		}
		$(indexGoods_add.dgId).datagrid('appendRow', {showNum : $(indexGoods_add.dgId).datagrid('getRows').length+1});
	}
	
}

indexGoods_add.getSpuInfo=function(obj){
	var i =$(obj).parents('tr').attr('datagrid-row-index');
	var flag=$('#flag').val();
	if(flag==1){
		var salAgencyCode='GMZB';
	}else{
	var salAgencyCode=$(indexGoods_add.salAgencyCodeId).combobox('getValue');
	}
	if(null==salAgencyCode||""==salAgencyCode){
		$.messager.alert('提示','请先选择销售组织','info');
		return;
	}
	if(i<=5){
	$('#magnifier').window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        method:'post',
        href: "wdIndexGoodsController/openSpuNameMagnifierWindow?i="+i+"&salAgencyCode="+salAgencyCode,
        title: "全部SPU代码"
    });
	$('#magnifier').window('open');
	}else{
		var row = $(indexGoods_add.dgId).datagrid('getRows')[i];
		row.code = 6-i;
		row.id = 6-i;
	}
	 $(indexGoods_add.dgId).datagrid('updateRow',{
			index : parseInt(i),
			row : row
		});
}

indexGoods_add.delRow=function(){
	var rowNums = $(indexGoods_add.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(indexGoods_add.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(indexGoods_add.dgId).datagrid('clearChecked');
}

indexGoods_add.back=function(){
	$(indexGoodsManage.add).panel('close');
	$(indexGoodsManage.indexGoods_list_list_panel).show();
	$(indexGoodsManage.indexGoods_list_dg).datagrid('reload')
	
}

indexGoods_add.save=function(){
	$(indexGoods_add.dgId).datagrid('acceptChanges');
	var materials = $(indexGoods_add.dgId).datagrid('getRows');
	for(var i=0,j=materials.length;i<j;i++){
		delete materials[i].keyWord;
	}
	var flag=$('#flag').val();
	if(flag==1){
		if(materials.length<6){
			$.messager.alert('警告','请添加六件商品后保存！', 'info');
			return false;
		}
	}else{
	if(materials.length<6){
		$.messager.alert('警告','至少添加六件商品后保存！', 'info');
		return false;
	}
	}
	for (var i = 0; i < materials.length; i++) {
		if ($.o2m.isEmpty(materials[i].showNum)) {
			$.messager.alert('请核实图片显示位置', '第' + (i + 1) + '行数据未添加图片显示位置！', 'warning');
			return false;
		}
	};
	if(flag!=1){
	var salAgencyCode=$(indexGoods_add.salAgencyCodeId).combobox('getValue');
	var publishDate=$('#publicDateId').datebox('getValue');
	if($.o2m.isEmpty(salAgencyCode)){
		$.messager.alert('提示','请选择销售组织','info');
		return false;
	}
	if($.o2m.isEmpty(publishDate)){
		$.messager.alert('提示','请选择计划发布时间','info');
		return false;
	}else{
		var date = new Date();
	    var seperator1 = "-";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var newDate = date.getFullYear() + seperator1 + month + seperator1 + strDate
		var arys1= new Array();     
	    var arys2= new Array();
	    arys1=newDate.split('-');
	    arys2=publishDate.split('-');
	    var now=arys1[0]+arys1[1]+arys1[2];
	    var publish=arys2[0]+arys2[1]+arys2[2];
	    if(publish-now<0){
	    	$.messager.alert('提示','计划发布时间不能早于当前日期','info');
	    	return false;
	    }
	}
	}
	var saveIndexGoods={};
	saveIndexGoods.spus=materials;
	$.ajax({
		type : "POST",
		url : "wdIndexGoodsController/addIndexGoods?salAgencyCode="+salAgencyCode+"&publishDate="+publishDate+"&flag="+flag,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(saveIndexGoods),
		success : function(data) {
			if(data.code==0){
				$.messager.alert('提示',data.msg,'success');
				// 关闭添加窗口，回到主页面
				$(indexGoodsManage.add).panel('close');
				$(indexGoodsManage.indexGoods_list_list_panel).show();
				$(indexGoodsManage.indexGoods_list_dg).datagrid('reload')
			}else if(data.code==1){
				$.messager.alert('警告',data.msg,'info');
			}
		}
	});
	
}
indexGoods_add.inits();

