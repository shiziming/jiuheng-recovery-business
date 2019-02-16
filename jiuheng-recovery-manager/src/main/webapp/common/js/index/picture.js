var picture_add = {};

picture_add_pageId = "#picture_Add_Page";
picture_add.dgId = picture_add_pageId+ " #dg";
picture_add.billId = picture_add_pageId+" #billId";
picture_add.tbId = picture_add_pageId+" #tb";
/**
 * 页面初始化函数
 */
picture_add.inits = function() {
	$(picture_add.dgId).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		checkOnSelect : false,
		url:'index/bannerList',
		onDblClickRow : function(index,row){
			$(picture_add.dgId).datagrid('beginEdit',index);
		},
		columns : [ [ {
			field : 'ck',
			width : 10,
			checkbox : true
		}, {
			title:"图片地址",
			field:"imageUrl",
			width:100,
			align:"center",
			formatter:function(val, row, idx){
				if(val){
					return '<img src="'+val+'" width="90px" height="90px" >'+
							'<a class="easyui-linkbutton" onmouseover="picture_add.uploadIndexPic(this,'+idx+')" onmouseenter="picture_add.uploadIndexPic(this,'+idx+')" iconCls="icon-edit" href="javascript:;">编辑</a>  '+
							'<a class="easyui-linkbutton" onclick="picture_add.deleteIndexPic('+idx+')" href="javascript:;">删除</a>';
				}else{
					return '<a class="easyui-linkbutton fileupload" onmouseover="picture_add.uploadIndexPic(this,'+idx+')" onmouseenter="picture_add.uploadIndexPic(this,'+idx+')" iconCls="icon-add" href="javascript:;">+添加图片</a>';
				}
			}
		}, {
			field : 'linkUrl',
			title : '图片链接',
			align:'center',
			width : 100,
			editor:{type:'textbox'}
		}, {
			field : 'sort',
			title : '排序',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true,max :6,min:1}}
		}] ],
		toolbar : picture_add.tbId
	});
};

picture_add.uploadIndexPic = function(obj,index){
	$(obj).ajaxUpload({
		fileType: "pic",
		action: "imgFileUpload",
		onComplete: function (file, response) {
			if (response != null) {
				$(picture_add.dgId).datagrid('updateRow',{
					index: index,
					row:{imageUrl:response.url}
				});
				$(picture_add.dgId).datagrid("endEdit",index);
				$(picture_add.dgId).datagrid("beginEdit", index);
			} else {
				$.messager.alert("图片上传", "图片上传出错，请重新上传！", "info");
			}
		}
	});

	$(obj).unbind("onmouseenter");
	$(obj).unbind("onmouseover");
}

picture_add.deleteIndexPic = function(index){
	if(index != undefined){
		$(picture_add.dgId).datagrid("updateRow",{
			index :index,
			row:{imageUrl:""}
		});
		$(picture_add.dgId).datagrid("endEdit",index);
	}
}

picture_add.addRow = function() {
			if($(picture_add.dgId).datagrid('getRows').length==6){
				$.messager.alert('消息提示','商品已添加满，不能再继续添加','info');
				return false;
			}
			$(picture_add.dgId).datagrid('appendRow', {sort : $(picture_add.dgId).datagrid('getRows').length+1});
}

picture_add.delRow=function(){
	var rowNums = $(picture_add.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(picture_add.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(picture_add.dgId).datagrid('clearChecked');
}

picture_add.save=function(){
	$(picture_add.dgId).datagrid('acceptChanges');
	var materials = $(picture_add.dgId).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		if ($.o2m.isEmpty(materials[i].imageUrl)) {
			$.messager.alert('请核实图片地址', '第' + (i + 1) + '行数据未添加图片地址！', 'warning');
			return false;
		}
		if ($.o2m.isEmpty(materials[i].sort)) {
			$.messager.alert('请核实图片显示位置', '第' + (i + 1) + '行数据未添加图片排序！', 'warning');
			return false;
		}
	};
	for (var i = 0; i < materials.length; i++) {
		var k=0;
		for (var j = 0; j < materials.length; j++) {
			if(materials[j].sort == materials[i].sort){
				k++;
			}
			if(2==k){
				$.messager.alert('请核实图片显示位置','图片顺序重复，请修改后保存！', 'warning');
				return false;
			}
		}
	}
	var savePicture={};
	savePicture.pics=materials;
	$.ajax({
		type : "POST",
		url : "index/savePicture",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(savePicture),
		success : function(data) {
			if(data.result==true){
				$.messager.alert('提示','保存成功','success');
			}else{
				$.messager.alert('警告','保存成功','info');
			}
		}
	});
	
}
picture_add.inits();


