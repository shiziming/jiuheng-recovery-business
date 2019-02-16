var hotModel_add = {};

hotModel_add_pageId = "#hotModel_Add_Page";
hotModel_add.dgId = hotModel_add_pageId+ " #dg";
hotModel_add.billId = hotModel_add_pageId+" #billId";
hotModel_add.tbId = hotModel_add_pageId+" #tb";
/**
 * 页面初始化函数
 */
hotModel_add.inits = function() {
	$(hotModel_add.dgId).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		checkOnSelect : false,
		url:'index/getHotModelList',
		onDblClickRow : function(index,row){
			$(hotModel_add.dgId).datagrid('beginEdit',index);
		},
		columns : [ [ {
			field : 'ck',
			width : 10,
			checkbox : true
		}, {
			field : 'getSpuInfo',
			title : '获取商品信息',
			align:'center',
			width : 100,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="hotModel_add.getSpuInfo(this);">查询</a>';
			}
		}, {
			field : 'goodsId',
			title : '商品id',
			align:'center',
			width : 100,
		}, {
			field : 'goodsName',
			title : '商品名称',
			align:'center',
			width : 100,
		}, {
			title:"图片地址",
			field:"imageUrl",
			width:100,
			align:"center",
			formatter:function(val, row, idx){
				if(val){
					return '<img src="'+val+'" width="90px" height="90px" >'+
							'<a class="easyui-linkbutton" onmouseover="hotModel_add.uploadIndexPic(this,'+idx+')" onmouseenter="hotModel_add.uploadIndexPic(this,'+idx+')" iconCls="icon-edit" href="javascript:;">编辑</a>  '+
							'<a class="easyui-linkbutton" onclick="hotModel_add.deleteIndexPic('+idx+')" href="javascript:;">删除</a>';
				}else{
					return '<a class="easyui-linkbutton fileupload" onmouseover="hotModel_add.uploadIndexPic(this,'+idx+')" onmouseenter="hotModel_add.uploadIndexPic(this,'+idx+')" iconCls="icon-add" href="javascript:;">+添加图片</a>';
				}
			}
		}, {
			field : 'recoveryAveragePrice',
			title : '平均价格',
			align:'center',
			width : 100,
			editor:{type:'numberbox'}
		}] ],
		toolbar : hotModel_add.tbId
	});
};

hotModel_add.uploadIndexPic = function(obj,index){
	$(obj).ajaxUpload({
		fileType: "pic",
		action: "imgFileUpload",
		onComplete: function (file, response) {
			if (response != null) {
				$(hotModel_add.dgId).datagrid('updateRow',{
					index: index,
					row:{imageUrl:response.url}
				});
				$(hotModel_add.dgId).datagrid("endEdit",index);
				$(hotModel_add.dgId).datagrid("beginEdit", index);
			} else {
				$.messager.alert("图片上传", "图片上传出错，请重新上传！", "info");
			}
		}
	});

	$(obj).unbind("onmouseenter");
	$(obj).unbind("onmouseover");
}

hotModel_add.deleteIndexPic = function(index){
	if(index != undefined){
		$(hotModel_add.dgId).datagrid("updateRow",{
			index :index,
			row:{imageUrl:""}
		});
		$(hotModel_add.dgId).datagrid("endEdit",index);
	}
}

hotModel_add.addRow = function() {
			if($(hotModel_add.dgId).datagrid('getRows').length==6){
				$.messager.alert('消息提示','商品已添加满，不能再继续添加','info');
				return false;
			}
			$(hotModel_add.dgId).datagrid('appendRow', {sort : $(hotModel_add.dgId).datagrid('getRows').length+1});
}

hotModel_add.delRow=function(){
	var rowNums = $(hotModel_add.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(hotModel_add.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(hotModel_add.dgId).datagrid('clearChecked');
}

hotModel_add.save=function(){
	$(hotModel_add.dgId).datagrid('acceptChanges');
	var materials = $(hotModel_add.dgId).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		if ($.o2m.isEmpty(materials[i].goodsId)) {
			$.messager.alert('请核实商品', '第' + (i + 1) + '行商品数据未添加！', 'warning');
			return false;
		}
		if ($.o2m.isEmpty(materials[i].imageUrl)) {
			$.messager.alert('请核实图片地址', '第' + (i + 1) + '行数据未添加图片地址！', 'warning');
			return false;
		}
		if ($.o2m.isEmpty(materials[i].recoveryAveragePrice)) {
			$.messager.alert('请核实价格', '第' + (i + 1) + '行数据价格未添加！', 'warning');
			return false;
		}
	};
	var hotModels=materials;
	$.ajax({
		type : "POST",
		url : "index/saveHotModels",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(hotModels),
		success : function(data) {
			if(data.result==true){
				$.messager.alert('提示','保存成功','success');
			}else{
				$.messager.alert('警告','保存成功','info');
			}
		}
	});
	
}

hotModel_add.getSpuInfo=function(obj) {
	var row =$(obj).parents('tr').attr('datagrid-row-index');
	$('#magnifier').window({
		width: 700,
		height: 450,
		modal: true,
		inline:true,
		method:'post',
		href: "index/hotModelManager?row="+row,
		title: "全部商品"
	});
	$('#magnifier').window('open');
}
hotModel_add.inits();


