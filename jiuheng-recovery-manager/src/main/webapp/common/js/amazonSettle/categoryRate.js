var categoryrate = {};

categoryrate.pageId = '#categoryRatePage';
categoryrate.gridId = categoryrate.pageId + ' #dataGrid';
categoryrate.toolBar = categoryrate.pageId + ' #tb';
categoryrate.searchForm = categoryrate.pageId + ' #searchForm';
categoryrate.listId = categoryrate.pageId + ' #listPanel';
categoryrate.panelId = categoryrate.pageId + ' #importPanel';
/**
 * 页面初始化函数
 */
categoryrate.inits = function() {

	$(categoryrate.gridId).datagrid(
			{
				title : "商品大类结算扣率定义",
 				url : "categoryRate/loadData",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : false,
				
				columns : [ [
						{
							field : 'ck',
							checkbox : true
						},
						{
							field : 'channelId',
							title : '销售渠道代码',
							width : 50,
							align : 'center'
						},
						{
							field : 'categoryId',
							title : '大类代码',
							width : 50,
							align : 'center'
						},
						{
							field : 'categoryName',
							title : '商品大类名称',
							width : 100,
							align : 'center'
						},
						{
							field : 'settleRate',
							title : '结算扣率',
							width : 50,
							align : 'center',
							formatter : function(value, row, index) {
								 return row.settleRate/100+"%";
							}
						},
						{
							field : 'advRate',
							title : '广告费比例',
							width : 50,
							align : 'center',
							formatter : function(value, row, index) {
								 return row.advRate/100+"%";
							}
						},
						{
							field : 'maintainDate',
							title : '最后维护日期',
							width : 50,
							align : 'center'
						},{
							field : 'action',
							title : '操作',
							width : 30,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return '<a href="#" onclick="categoryrate.del(\'' + row.channelId+'\',\''+row.categoryId+'\');">删除</a>';
							}
						}] ],
			    toolbar : categoryrate.toolBar,
				loadMsg : "数据加载中..."
			});
	
};

// 条件查询
$(categoryrate.pageId + " #btnSearch").on("click",function() {
			$(categoryrate.gridId).datagrid("load",$.o2m.serializeObject($(categoryrate.searchForm)));
		});
//手动增加
$(categoryrate.pageId + " #btnAdd").on("click", function() {
	 $(categoryrate.listId).hide();
	    $(categoryrate.panelId).panel({
	        title:'手动增加', 
	        href:"categoryRate/add",
	        height : $.o2m.centerHeight - 20
	    });
	 $(categoryrate.panelId).panel('open');
});

// 删除
categoryrate.del= function(channelId,categoryId){
		$.messager.confirm('确认', '您确认想要删除记录吗？'+channelId+','+categoryId, function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "categoryRate/delete",
					data : "channelId=" + channelId + "&categoryId=" + categoryId,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(categoryrate.gridId).datagrid("reload");
						}
					}
				});
			}
		});
}
// 批量删除
$(categoryrate.pageId + " #btnDel").on("click", function() {
	var rows = $(categoryrate.gridId).datagrid("getSelections");
	var channelIds=[];
	var categoryIds=[];  
	for (var i = 0; i < rows.length; i++) {
		      var channelId=rows[i].channelId; 
	          var categoryId=rows[i].categoryId;
	          channelIds.push(channelId);
	          categoryIds.push(categoryId);
	    }  
	if (rows.length!=0) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "categoryRate/deleteall",
					data : "channelIds=" + channelIds + "&categoryIds=" + categoryIds,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(categoryrate.gridId).datagrid("reload");
						}
					}
				});
			}
		});
	} else {
		$.messager.alert('警告', '请至少选择一条记录!', 'warning');
	}
});

/**
 * 从Panel页面返回到列表页面
 */
categoryrate.returnToListPage = function() {
	$(categoryrate.panelId).panel('close');
	$(categoryrate.gridId).datagrid("reload");
	$(categoryrate.listId).show();
}
categoryrate.save=function(){
	if(!$(categoryrate.panelId).find('form').form('enableValidation').form('validate')){
		  return false;
		}
	 var categoryRate={};
	 channelId=$(categoryrate.panelId+" #channelId").val();
	  if(channelId.length==2)
		{
		  categoryRate.channelId=channelId;
		}else{
				 alert("渠道代码只能为2位！");
			     return true;
			}
	 categoryRate.categoryId=$(categoryrate.panelId+" #categoryId").combobox('getValue');
	 categoryRate.settleRate=$(categoryrate.panelId+" #settleRate").val()*10000;
	 categoryRate.advRate=$(categoryrate.panelId+" #advRate").val()*10000;
	 if((categoryRate.settleRate+categoryRate.advRate)>=10000)
	    {
		 alert("结算扣率与广告费比例之和应小于1！");
	     return true;
		}
//	 alert(JSON.stringify(categoryRate));
	 $.ajax({
			type : "POST",
			url : "categoryRate/save",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(categoryRate),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(categoryrate.panelId).panel('close');
					$(categoryrate.gridId).datagrid('reload');
					$(categoryrate.listId).show();
				}
			}
		 }); 
}
//商品大类下拉
categoryrate.goodsCatLoader = function(param,success,error){
	var q = param.q || '';
	var data = {};
	if(q!=''){
		if(!isNaN(q)){
			data.id = q;
		}else{
			data.name = q;
		}
	}
	$.ajax({
		url: "categoryRate/searchGoodsCat",
		dataType: "json",
		type:"post",  
        data: data,
		success: function(data){
			success(data);
		},
        error: function(){
			error.apply(this, arguments);
		}
	});
}
categoryrate.inits();
