var commissionrate = {};

commissionrate.pageId = '#ratePage';
commissionrate.gridId = commissionrate.pageId + ' #dataGrid';
commissionrate.toolBar = commissionrate.pageId + ' #tb';
commissionrate.searchForm = commissionrate.pageId + ' #searchForm';
commissionrate.listId = commissionrate.pageId + ' #listPanel';
commissionrate.panelId = commissionrate.pageId + ' #importPanel';
/**
 * 页面初始化函数
 */
commissionrate.inits = function() {

	$(commissionrate.gridId).datagrid(
			{
				title : "手续费费率",
				url : "rate/loadData",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : false,
				toolbar : commissionrate.toolBar,
				columns : [ [
						{
							field : 'ck',
							checkbox : true,
						},
						{
							field : 'payid',
							title : '支付方式代码',
							width : 50,
							align : 'center'
						},
						{
							field : 'payname',
							title : '支付方式名称',
							width : 50,
							align : 'center'
						},
						{
							field : 'startdate',
							title : '开始日期',
							width : 50,
							align : 'center',
						}, {
							field : 'enddate',
							title : '结束日期',
							width : 50,
							align : 'center',
						}, {
							field : 'rate',
							title : '手续费费率',
							width : 50,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								 return row.rate/100+"%";
							}
						} ,{
							field : 'action',
							title : '操作',
							width : 50,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return '<a href="#" onclick="commissionrate.del(\'' + row.id + '\');">删除</a>';
							}
						} ] ],
				loadMsg : "数据加载中..."
			});
};

// 条件查询
$(commissionrate.pageId + " #btnSearch").on(
		"click",
		function() {
			$(commissionrate.gridId).datagrid("load",
					$.o2m.serializeObject($(commissionrate.searchForm)));
		});
//下载模板
$(commissionrate.pageId + " #btnUpload").on("click", function() {
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("微店支付手续费");
});
//手动增加
$(commissionrate.pageId + " #btnAddid").on("click", function() {
	 $(commissionrate.listId).hide();
	    $(commissionrate.panelId).panel({
	        title:'手动增加', 
	        href:"rate/add",
	        height : $.o2m.centerHeight - 20
	    });
	 $(commissionrate.panelId).panel('open');
});
//批量导入
$(commissionrate.pageId + " #btnAdd").on("click", function() {
	 $(commissionrate.listId).hide();
	    $(commissionrate.panelId).panel({
	        title:'导入', 
	        href:"rate/import"
	    });
	 $(commissionrate.panelId).panel('open');
});
// 删除
	commissionrate.del = function(id){
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "rate/delete",
					data : "id=" + id,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(commissionrate.gridId).datagrid("reload");
						}
					}
				});
			}
		});
	}
// 批量删除
$(commissionrate.pageId + " #btnDel").on("click", function() {
	var rows = $(commissionrate.gridId).datagrid("getSelections"); 
	var ids=[];  
	for (var i = 0; i < rows.length; i++) {  
	          var id=rows[i].id;     
	          ids.push(id); 
	    }  
	if (rows.length!=0) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "rate/deleteall",
					data : "ids=" + ids,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(commissionrate.gridId).datagrid("reload");
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
commissionrate.returnToListPage = function() {
	$(commissionrate.panelId).panel('close');
	$(commissionrate.gridId).datagrid("reload");
	$(commissionrate.listId).show();
}
//保存
commissionrate.save=function(){
	if(!$(commissionrate.panelId).find('form').form('enableValidation').form('validate')){
		 return false;
		}
	    var rate={};
	    rate.payid=$(commissionrate.panelId+" #payid").combobox('getValue');
		rate.startdate=$(commissionrate.panelId+" #startdate").datebox('getValue'); 
		rate.enddate=$(commissionrate.panelId+" #enddate").datebox('getValue'); 
		rate.rate =Math.ceil($(commissionrate.panelId+" #rate").val()*10000);
	 $.ajax({
			type : "POST",
			url : "rate/save",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(rate),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(commissionrate.panelId).panel('close');
					$(commissionrate.gridId).datagrid('reload');
					$(commissionrate.listId).show();
				}
			}
		 }); 
}
commissionrate.inits();
