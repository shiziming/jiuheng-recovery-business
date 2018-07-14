var supplierbranch = {};

supplierbranch.pageId = '#supplier_branch';
supplierbranch.gridId = supplierbranch.pageId + ' #dataGrid';
supplierbranch.toolBar = supplierbranch.pageId + ' #tb';
supplierbranch.searchForm = supplierbranch.pageId + ' #searchForm1';
supplierbranch.listId = supplierbranch.pageId + ' #listPanel';
supplierbranch.panelId = supplierbranch.pageId + ' #addPanel';
/**
 * 页面初始化函数
 */
supplierbranch.inits = function() {

	$(supplierbranch.gridId).datagrid(
			{
				title : "供应商分部信息",
				url : "branch/loadData",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : false,
				toolbar : supplierbranch.toolBar,
				columns : [ [
						{
							field : 'ck',
							checkbox : true,
						},
						{
							field : 'saleOrgCode',
							title : '销售组织',
							width : 50,
							align : 'center'
						},
						{
							field : 'saleOrgName',
							title : '销售组织描述',
							width : 100,
							align : 'center'
						},
						{
							field : 'supplierCode',
							title : '供应商编码',
							width : 50,
							align : 'center',
						}, {
							field : 'supplierName',
							title : '供应商名称',
							width : 50,
							align : 'center',
						}, {
							field : 'platformFlag',
							title : '是否平台商',
							width : 80,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								if(row.platformFlag==1){
									return "是";
								}
								if(row.platformFlag==0){
									return "否";
								}
							}
						},{
							field : 'handlerId',
							title : '维护人id',
							width : 100,
							align : 'center',
							sortable : true,
						},{
							field : 'handlerName',
							title : '维护人名称',
							width : 100,
							align : 'center',
							sortable : true,
						},{
							field : 'lastUpTime',
							title : '最后维护时间',
							width : 100,
							align : 'center',
							sortable : true,
						},{
							field : 'status',
							title : '删除标记',
							width : 100,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								if(row.status==-1){
									return "已删除";
								}
								if(row.status==1){
									return "已录入";
								}
							}
						},{
							field : 'action',
							title : '操作',
							width : 30,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return '<a href="#" onclick="supplierbranch.del(\'' + row.saleOrgCode+'\',\''+row.supplierCode+'\',\''+row.status+'\');">删除</a>';
							}
						}] ],
				loadMsg : "数据加载中..."
			});
};

// 条件查询
$(supplierbranch.pageId + " #btnSearch").on("click",function() {
			$(supplierbranch.gridId).datagrid("load",$.o2m.serializeObject($(supplierbranch.searchForm)));
		});
//增加
$(supplierbranch.pageId + " #btnAdd").on("click", function() {
	 $(supplierbranch.listId).hide();
	    $(supplierbranch.panelId).panel({
	        title:'新增', 
	        href:"branch/add",
	        height : $.o2m.centerHeight - 20
	    });
	 $(supplierbranch.panelId).panel('open');
});
//导出
$(supplierbranch.pageId + " #experotExcel").on("click", function() {
	var searchObj = $.o2m.serializeObject($(supplierbranch.searchForm));
	window.open("branch/exportExcel?"+encodeURI($.param(searchObj)));
});
// 删除
supplierbranch.del= function(saleOrgCode,supplierCode,status){
	   if(status==-1){
		   $.messager.alert('警告', '不能重复删除!', 'warning');
		   return;
	   }
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "branch/delete",
					data : "saleOrgCode=" +saleOrgCode+"&supplierCode="+supplierCode,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(supplierbranch.gridId).datagrid("reload");
						}
					}
				});
			}
		});
}
// 批量删除
$(supplierbranch.pageId + " #btnDel").on("click", function() {
	var rows = $(supplierbranch.gridId).datagrid("getSelections");
	var saleOrgCodes=[];  
	var supplierCodes=[]; 
	for (var i = 0; i < rows.length; i++) {  
	          var saleOrgCode=rows[i].saleOrgCode;
	          var supplierCode=rows[i].supplierCode;
	          saleOrgCodes.push(saleOrgCode); 
	          supplierCodes.push(supplierCode); 
	          if(rows[i].status==-1){
	        	  $.messager.alert('警告', '不能重复删除!', 'warning');
	   		   return;
	          }
	    }  
	if (rows.length!=0) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "branch/deleteall",
					data : "saleOrgCodes=" + saleOrgCodes+"&supplierCodes="+supplierCodes,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(supplierbranch.gridId).datagrid("reload");
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
supplierbranch.returnToListPage = function() {
	$(supplierbranch.panelId).panel('close');
	$(supplierbranch.gridId).datagrid("reload");
	$(supplierbranch.listId).show();
}
supplierbranch.save=function(){
	if(!$(supplierbranch.panelId).find('form').form('enableValidation').form('validate')){
		  return false;
		}
	
	var branch={};
	  branch.saleOrgCode=$(supplierbranch.panelId+" #saleOrgCode").val();
	  branch.supplierCode=$(supplierbranch.panelId+" #supplierCode").val();
	  branch.platformFlag=$(supplierbranch.panelId+" #platformFlag:checked").val();
	  if(branch.platformFlag==null){
		  $.messager.alert('警告', '平台标记不能为空!', 'warning');
		   return;
	  }
	 $.ajax({
			type : "POST",
			url : "branch/save",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(branch),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(supplierbranch.panelId).panel('close');
					$(supplierbranch.listId).show();
					$(supplierbranch.gridId).datagrid({url:"branch/loadData"});
				}
			}
		 }); 
}
supplierbranch.inits();
