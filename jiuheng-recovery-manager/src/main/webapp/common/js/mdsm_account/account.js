var mdsm_account = {};

mdsm_account.pageId = '#mdsm_accountPage';
mdsm_account.gridId = mdsm_account.pageId + ' #dataGrid';
mdsm_account.toolBar = mdsm_account.pageId + ' #tb';
mdsm_account.searchForm = mdsm_account.pageId + ' #searchForm';
mdsm_account.listId = mdsm_account.pageId + ' #listPanel';
mdsm_account.panelId = mdsm_account.pageId + ' #importPanel';
/**
 * 页面初始化函数
 */
mdsm_account.inits = function() {

	$(mdsm_account.gridId).datagrid(
			{
				title : "支付账户",
				url : "mdsm_account/loadData",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : false,
				toolbar : mdsm_account.toolBar,
				columns : [ [
						{
							field : 'ck',
							checkbox : true
						},
						{
							field : 'companyCode',
							title : '公司代码',
							width : 50,
							align : 'center'
						},
						{
							field : 'companyName',
							title : '公司名称',
							width : 100,
							align : 'center'
						},
						{
							field : 'payCode',
							title : '支付方式代码',
							width : 50,
							align : 'center'
						}, {
							field : 'payName',
							title : '支付方式名称',
							width : 50,
							align : 'center'
						},{
							field : 'sapBankCode',
							title : 'sap银行科目',
							width : 50,
							align : 'center',
							sortable : true
						}, {
							field : 'payNum',
							title : '收付账户号',
							width : 80,
							align : 'center'
						},{
							field : 'bankNum',
							title : '银行账户号',
							width : 100,
							align : 'center',
							sortable : true
						},{
							field : 'bankName',
							title : '银行名称',
							width : 100,
							align : 'center',
							sortable : true
						},{
							field : 'action',
							title : '操作',
							width : 30,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return '<a href="#" onclick="mdsm_account.del(\'' + row.payCode+'\',\''+row.companyCode+'\');">删除</a>';
							}
						}] ],
				loadMsg : "数据加载中...",
				onLoadSuccess : function() {
						$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
					}
			});
};

// 条件查询
$(mdsm_account.pageId + " #btnSearch").on("click",function() {
			$(mdsm_account.gridId).datagrid("load",$.o2m.serializeObject($(mdsm_account.searchForm)));
		});
//下载模板
$(mdsm_account.pageId + " #btnUpload").on("click", function() {
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("门店扫码支付账户");
});
//手动增加
$(mdsm_account.pageId + " #btnAddid").on("click", function() {
	 $(mdsm_account.listId).hide();
	    $(mdsm_account.panelId).panel({
	        title:'手动增加', 
	        href:"mdsm_account/add",
	        height : $.o2m.centerHeight - 20
	    });
	 $(mdsm_account.panelId).panel('open');
});
//批量导入
$(mdsm_account.pageId + " #btnAdd").on("click", function() {
	 $(mdsm_account.listId).hide();
	    $(mdsm_account.panelId).panel({
	        title:'导入', 
	        href:"mdsm_account/import"
	    });
	 $(mdsm_account.panelId).panel('open');
});
// 删除
mdsm_account.del= function(payCode,companyCode){
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "mdsm_account/delete",
					data : "payCode=" +payCode+"&companyCode="+companyCode,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(mdsm_account.gridId).datagrid("reload");
						}
					}
				});
			}
		});
}
// 批量删除
$(mdsm_account.pageId + " #btnDel").on("click", function() {
	var rows = $(mdsm_account.gridId).datagrid("getSelections");
	var payids=[];  
	var companyids=[]; 
	for (var i = 0; i < rows.length; i++) {  
	          var payid=rows[i].payCode;
	          var companyid=rows[i].companyCode;
	          payids.push(payid); 
	          companyids.push(companyid); 
	    }  
	if (rows.length!=0) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "mdsm_account/deleteall",
					data : "payids=" + payids+"&companyids="+companyids,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(mdsm_account.gridId).datagrid("reload");
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
mdsm_account.returnToListPage = function() {
	$(mdsm_account.panelId).panel('close');
	$(mdsm_account.gridId).datagrid("reload");
	$(mdsm_account.listId).show();
}
mdsm_account.save=function(){
	if(!$(mdsm_account.panelId).find('form').form('enableValidation').form('validate')){
		  return false;
		}
	var account={};
	  companyid=$(mdsm_account.panelId+" #companyid").val();
	  if(companyid.length==4)
		{
		   account.companyCode=companyid;
		}else{
			     $.messager.alert('警告', '公司代码只能为4位！', 'warning'); 
			     return false;
			}
	account.payCode=$(mdsm_account.panelId+" #payid").combobox('getValue');
	account.sapBankCode=$(mdsm_account.panelId+" #sapBankCode").val();
	if(account.sapBankCode.length>10){
		$.messager.alert('警告', 'sap银行科目最多为10位!', 'warning');
		return;
	}
	account.payNum=$(mdsm_account.panelId+" #getnum").val();
	account.bankNum=$(mdsm_account.panelId+" #banknum").val();
	account.bankName=$(mdsm_account.panelId+" #bankname").val();
	 $.ajax({
			type : "POST",
			url : "mdsm_account/save",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(account),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(mdsm_account.panelId).panel('close');
					$(mdsm_account.gridId).datagrid('reload');
					$(mdsm_account.listId).show();
				}
			}
		 }); 
}
mdsm_account.inits();
