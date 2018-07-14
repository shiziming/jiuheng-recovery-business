var categoryAttrGroup = {};

categoryAttrGroup.pageId = '#attrGroupPage';
categoryAttrGroup.gridId = categoryAttrGroup.pageId + ' #dataGrid';
categoryAttrGroup.toolBar = categoryAttrGroup.pageId + ' #tb';
categoryAttrGroup.searchForm = categoryAttrGroup.pageId + ' #searchForm';
categoryAttrGroup.dlg = '#attr_group_dlg';
/**
 * 页面初始化函数
 */
categoryAttrGroup.inits = function() {

	$(categoryAttrGroup.gridId).datagrid({
		title : '属性组信息',
		url : "attributeGroup/loadData",
		striped : true,
		height : $.o2m.centerHeight - 20,
		fitColumns : true,
		singleSelect : true,
		checkOnSelect : true,
		pagination : true,
		pageSize : 20,
		checkbox : true,
		toolbar : categoryAttrGroup.toolBar,
		columns : [ [ {
			field : 'ck',
			checkbox : true,
		}, {
			field : 'id',
			title : 'ID',
			align : 'center',
			width : 200
		}, {
			field : 'name',
			title : '组名称',
			align : 'center',
			width : 500
		} ] ],
		loadMsg : "数据加载中..."
	});
};

//条件查询
$(categoryAttrGroup.pageId + " #btnSearch").on("click", function() {
	$(categoryAttrGroup.gridId).datagrid("load", $.o2m.serializeObject($(categoryAttrGroup.searchForm)));
});
//添加
$(categoryAttrGroup.pageId + " #btnAdd").on("click", function() {
/*	$(categoryAttrGroup.dlg).dialog('open');*/
	$(categoryAttrGroup.dlg).dialog({'title':'增加属性组'});
	$(categoryAttrGroup.dlg +" #group_fm").form('clear');
	$(categoryAttrGroup.dlg).dialog('open');
	$('#group_attr_name').focus();
	categoryAttrGroup.handleUrl= "attributeGroup/addData";
});
//修改
$(categoryAttrGroup.pageId + " #btnEdit").on("click", function() {
	var row = $(categoryAttrGroup.gridId).datagrid("getSelected");
	if(row){
		$(categoryAttrGroup.dlg).dialog({'title':'修改属性组'});
		$(categoryAttrGroup.dlg +" #group_fm").form('clear');
		$('#group_attr_id').val(row.id);
		$('#group_attr_name').val(row.name);
		$(categoryAttrGroup.dlg).dialog('open');
		$('#group_attr_name').focus();
		categoryAttrGroup.handleUrl = "attributeGroup/addData?id=" +row.id;
	 }else{
		   $.messager.alert('警告', '请选择一条记录!', 'warning'); 
	 }
});

//删除
$(categoryAttrGroup.pageId + " #btnDel").on("click", function() {
	var row = $(categoryAttrGroup.gridId).datagrid("getSelected");
	if(row){
		$.messager.confirm('确认','您确认想要删除记录吗？',function(r){   
		    if (r){  
		    	$.ajax({
		    		type : "POST",
		    		url : "attributeGroup/delete",
		    		data : "id="+row.id,
		    		success : function(result) {
		    			if($.o2m.handleActionResult(result)){
		    				$(categoryAttrGroup.gridId).datagrid("reload");
		    			}
		    		}
		    	});
		    }
		});
	 }else{
		   $.messager.alert('警告', '请选择一条记录!', 'warning'); 
	 }
});

//保存
categoryAttrGroup.save = function(){
	var name = $(categoryAttrGroup.dlg +" #group_fm").find('input[name=name]').val();
	var id = $(categoryAttrGroup.dlg +" #group_fm").find('input[name=id]').val();
	if(name != ""){
		var data = {};
		if(id != ""){
			data.id = id;
		}
		data.name = name;
    	$.ajax({
    		type : "POST",
    		url : categoryAttrGroup.handleUrl,
    		data : data,
    		success : function(result) {
    			if($.o2m.handleActionResult(result)){
    				$(categoryAttrGroup.dlg).dialog('close');
					$(categoryAttrGroup.gridId).datagrid("reload");
    			}
    		}
    	});
	}else{
		$.messager.alert('警告', '请输入属性组名称!', 'warning'); 
	}
}
//取消
categoryAttrGroup.cancel = function(){
	$(categoryAttrGroup.dlg).dialog('close');
};
categoryAttrGroup.inits();
