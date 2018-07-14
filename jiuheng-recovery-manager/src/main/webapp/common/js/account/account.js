var commissionaccount = {};

commissionaccount.pageId = '#accountPage';
commissionaccount.gridId = commissionaccount.pageId + ' #dataGrid';
commissionaccount.toolBar = commissionaccount.pageId + ' #tb';
commissionaccount.searchForm = commissionaccount.pageId + ' #searchForm';
commissionaccount.listId = commissionaccount.pageId + ' #listPanel';
commissionaccount.panelId = commissionaccount.pageId + ' #importPanel';
/**
 * 页面初始化函数
 */
commissionaccount.inits = function() {

	$(commissionaccount.gridId).datagrid(
			{
				title : "支付账户",
				url : "account/loadData",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : false,
				toolbar : commissionaccount.toolBar,
				columns : [ [
						{
							field : 'ck',
							checkbox : true,
						},
						{
							field : 'companyid',
							title : '公司代码',
							width : 50,
							align : 'center'
						},
						{
							field : 'companyname',
							title : '公司名称',
							width : 100,
							align : 'center'
						},
						{
							field : 'payid',
							title : '支付方式代码',
							width : 50,
							align : 'center',
						}, {
							field : 'payname',
							title : '支付方式名称',
							width : 50,
							align : 'center',
						}, {
							field : 'getnum',
							title : '收付账户号',
							width : 80,
							align : 'center',
							sortable : true,
						},{
							field : 'banknum',
							title : '银行账户号',
							width : 100,
							align : 'center',
							sortable : true,
						},{
							field : 'bankname',
							title : '银行名称',
							width : 100,
							align : 'center',
							sortable : true,
						},{
							field : 'action',
							title : '操作',
							width : 30,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return '<a href="#" onclick="commissionaccount.del(\'' + row.payid+'\',\''+row.companyid+'\');">删除</a>';
							}
						}] ],
				loadMsg : "数据加载中..."
			});
};

// 条件查询
$(commissionaccount.pageId + " #btnSearch").on("click",function() {
			$(commissionaccount.gridId).datagrid("load",$.o2m.serializeObject($(commissionaccount.searchForm)));
		});
//下载模板
$(commissionaccount.pageId + " #btnUpload").on("click", function() {
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("微店支付账户");
});
//手动增加
$(commissionaccount.pageId + " #btnAddid").on("click", function() {
	 $(commissionaccount.listId).hide();
	    $(commissionaccount.panelId).panel({
	        title:'手动增加', 
	        href:"account/add",
	        height : $.o2m.centerHeight - 20
	    });
	 $(commissionaccount.panelId).panel('open');
});
//批量导入
$(commissionaccount.pageId + " #btnAdd").on("click", function() {
	 $(commissionaccount.listId).hide();
	    $(commissionaccount.panelId).panel({
	        title:'导入', 
	        href:"account/import"
	    });
	 $(commissionaccount.panelId).panel('open');
});
// 删除
commissionaccount.del= function(payid,companyid){
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "account/delete",
					data : "payid=" +payid+"&companyid="+companyid,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(commissionaccount.gridId).datagrid("reload");
						}
					}
				});
			}
		});
}
// 批量删除
$(commissionaccount.pageId + " #btnDel").on("click", function() {
	var rows = $(commissionaccount.gridId).datagrid("getSelections");
	var payids=[];  
	var companyids=[]; 
	for (var i = 0; i < rows.length; i++) {  
	          var payid=rows[i].payid;
	          var companyid=rows[i].companyid;
	          payids.push(payid); 
	          companyids.push(companyid); 
	    }  
	if (rows.length!=0) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "account/deleteall",
					data : "payids=" + payids+"&companyids="+companyids,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(commissionaccount.gridId).datagrid("reload");
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
commissionaccount.returnToListPage = function() {
	$(commissionaccount.panelId).panel('close');
	$(commissionaccount.gridId).datagrid("reload");
	$(commissionaccount.listId).show();
}
commissionaccount.save=function(){
	if(!$(commissionaccount.panelId).find('form').form('enableValidation').form('validate')){
		  return false;
		}
	var account={};
	  companyid=$(commissionaccount.panelId+" #companyid").val();
	  if(companyid.length==4)
		{
		   account.companyid=companyid;
		}else{
				 alert("公司代码只能为4位！");
			     return true;
			}
	account.payid=$(commissionaccount.panelId+" #payid").combobox('getValue');
	account.getnum=$(commissionaccount.panelId+" #getnum").val();
	account.banknum=$(commissionaccount.panelId+" #banknum").val();
	account.bankname=$(commissionaccount.panelId+" #bankname").val();
	 $.ajax({
			type : "POST",
			url : "account/save",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(account),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(commissionaccount.panelId).panel('close');
					$(commissionaccount.gridId).datagrid('reload');
					$(commissionaccount.listId).show();
				}
			}
		 }); 
}
commissionaccount.inits();
