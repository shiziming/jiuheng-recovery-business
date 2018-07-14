var spic = {};

spic.pageId = '#spicPage';
spic.dgId = spic.pageId + ' #dg';
spic.toolBar = spic.pageId + ' #tb';
spic.listId = spic.pageId + ' #listPanel';
spic.panelId = spic.pageId + ' #editPanel';

/**
 * 页面初始化函数
 */
spic.inits = function() {
	$(spic.dgId).datagrid({
		rownumbers : true,
		striped : true,
		fitColumns : true,
		height : $.o2m.centerHeight-20,
		toolbar : spic.toolBar,
		pagination : true,
		pageSize : 20,
		checkbox : true,
		idField : 'id',
		url : 'spu/list',
		columns : [ [ {
			field : 'id',
			checkbox:true
		}, {
			field : 'code',
			title : '编码',
			width : 150,
			align : "center",
			formatter : function(value,row) {
				return "<a href='#' onClick='spic.showDetailPic(\""+row.id+"\")'>"+value+"</a>";
			}
		}, {
			field : 'name',
			title : '名称',
			align : "center",
			width : 250
		} , {
			field : 'status',
			title : '是否发布',
			align : "center",
			width : 40,
			formatter : function(value,row) {
				if(value == '1'){
					return "<span style='color:red'>是</span>";
				}else{
					return "<span>否</span>";
				}
			}
		} ] ],
		loadMsg : "数据加载中..."
	});
	$(spic.pageId + " #categroyCode").combotree({
		data : [{
			pid : '',
			id : '',
			text : '全部',
			state : "closed"	
		}],
		onBeforeExpand : function(node) {
			if (node.children && node.children.length) {
				return;
			};
			$(this).tree('append', {
				parent : node.target,
				data : $.o2m.getCategroyChildren(node.id)
			});
		}
	});
	
};
//查询
$(spic.pageId + ' #btnSearch').on("click", function() {
	$(spic.dgId).datagrid("clearChecked");
	var searchObj = $.o2m.serializeObject($(spic.pageId + " #searchForm"));
	categoryCode = $(spic.pageId + " #categroyCode").combotree('getValue');
	if(categoryCode != ''){
		searchObj.categoryCode = categoryCode;
	}
	$(spic.dgId).datagrid("load", searchObj);
});
//上传加工图
$(spic.pageId + ' #btnPicAdd').on("click", function() {
	$(spic.listId).hide();
	$(spic.panelId).panel({title:'上传加工图片', href:"spic/addView"});
	$(spic.panelId).panel('open');
});
//查看CDN图片
$(spic.pageId + ' #btnSearchPic').on("click", function() {
	var rows = $(spic.dgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spic.listId).hide();
		$(spic.panelId).panel({title:'CDN图片', href:"spic/cdnPicInfo/"+rows[0].id});
		$(spic.panelId).panel('open');
	}
});
//查看素材详情
$(spic.pageId + ' #btnMatINfo').on("click", function() {
	var rows = $(spic.dgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spic.listId).hide();
		$(spic.panelId).panel({title:'素材详情', href:"spic/matInfo/"+rows[0].id});
		$(spic.panelId).panel('open');
	}
});

//发布SPU
$(spic.pageId + ' #btnPublishSpu').on('click', function(event) {
	var rows = $(spic.dgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spic.listId).hide();
		$(spic.panelId).panel({title:'发布SPU', href:"spic/publishSpu/"+rows[0].id});
		$(spic.panelId).panel('open');
	}
	
});

//下载素材
$(spic.pageId + ' #btnDownMats').on('click', function(event) {
	var rows = $(spic.dgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else {
		var arr = [];
		for(var i =0 ;i<rows.length;i++){
			arr.push(rows[i].id);
		}
		window.open("spic/downloadMats?list="+arr);
	}
	
});

spic.showDetailPic = function(pid){
	$(spic.listId).hide();
	$(spic.panelId).panel({title:'图片详情', href:"spic/picInfo/"+pid});
	$(spic.panelId).panel('open');
}
/**
 * 从Panel页面返回到列表页面
 */
spic.returnToListPage = function() {
	$(spic.panelId).panel('close');
	$(spic.listId).show();
}
	spic.add = function(){
		$(spic.listId).hide();
		$(spic.addId).panel({href:"spic/addView"});
		$(spic.addId).show();
	};
	spic.showImg = function(obj){
		//$(spic.winId).show();
		$("#spic_list_win img").attr("src", obj.src);
		$("#spic_list_win").show();
		$("#spic_list_win").dialog("open");
	}
	spic.del = function (){
		var selected = $(spic.dgId).datagrid("getChecked");
        if (selected.length == 0) {
            alert("请选择要删除的内容!");
            return;
        }
        var ids = new Array();
        $.each(selected, function (index, item) {
            ids.push(item.id);
        });
    	var msg= "确认删除选中的 "+selected.length+" 条数据吗?";
    	parent.$.messager.alert('提示', msg, function(){
    		return;
    		$.ajax({ 
                type:"POST", 
                url:"spic/del", 
                dataType:"json",      
                data:{ids:ids}, 
                success:function(msg){
                	if($.o2m.handleActionResult(msg)){
                		$(spic.dgId).datagrid('reload');
                	}
                }
            }); 
    	});
	}
	spic.upload_back = function(){
		$(spic.addId).hide();
		//$(spic.addId).panel({href:"spic/addView"});
		$(spic.listId).show();
	}
	
spic.inits();
