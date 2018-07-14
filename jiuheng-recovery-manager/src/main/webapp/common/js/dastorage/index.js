var dastorage = {};

dastorage.pageId="#dastoragePage";
dastorage.list_panel = dastorage.pageId + " #dastorage_list_panel";
dastorage.view_panel = dastorage.pageId + " #view_panel";
dastorage.up_panel   = dastorage.pageId + " #up_panel";
dastorage.import_panel   = dastorage.pageId + " #import_panel";
dastorage.storage_panel   = dastorage.pageId + " #storage_panel";
dastorage.dgId=dastorage.list_panel + " #dg";
dastorage.tb = dastorage.list_panel + " #tb";
dastorage.query = dastorage.list_panel + " #dastorage_list_query";
dastorage.querystorage = dastorage.list_panel + " #query_storage";
dastorage.searchForm = dastorage.list_panel + " #searchForm";

/**
 * 页面初始化函数
 */
dastorage.inits = function() {
	$(dastorage.dgId).datagrid({
		rownumbers : true,
		height : document.documentElement.clientHeight,
		pagination : true,
		pageSize : 20,
		fitColumns : true,
		checkOnSelect : true,
		singleSelect : true,
		columns : [ [{
			field : 'billId',
			title : '单据编号',
			align:'center',
			width : 80
		},{
			field : 'companyCode',
			title : '公司代码',
			align:'center',
			width : 50
		},{
			field : 'buyOrgCode',
			title : '采购组织代码',
			align:'center',
			width : 70
		},{
			field : 'billOrgCode',
			title : '单据机构代码',
			align:'center',
			width : 80
		},{
			field : 'createId',
			title : '制单人ID',
			align:'center',
			width:80,
		},{
			field : 'createName',
			title : '制单人名称',
			align:'center',
			width:80,
		},{
			field : 'createTime',
			title : '制单时间',
			align:'center',
			width:100,
		},{
			field : 'checkId',
			title : '审核人ID',
			align :'center',
			width:80,
		},{
			field : 'checkName',
			title : '审核人名称',
			align : 'center',
			width:80,
		},{
			field : 'checkTime',
			title : '审核时间',
			align : 'center',
			width:100,
		},{
			field : 'status',
			title : '状态',
			align : 'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.status==0)
					{
					return "已录入";
					}else if(row.status==1){
						return "已审核";
					}
			}
		},{
			field : 'action',
			title : '操作',
			align :'center',
			formatter : function(value, row, index) {
				var handle ='<a href="#" onclick="dastorage.view(\'' + row.billId + '\');">查看</a>';
				if(row.status==0){
					if($(dastorage.pageId +' #func_maintain').val() == "true"){
						handle +=' <a href="#" onclick="dastorage.del(\'' + row.billId + '\');">删除</a> ';
					}
					if($(dastorage.pageId +' #func_check').val() == "true"){
						handle += ' <a href="#" onclick="dastorage.view(\'' + row.billId + '\');">审核</a>';
					}
				}
				return handle;

			}
		}] ],
		onLoadSuccess:function(data){
			if (data.total == 0) {
	            //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
	            $(this).datagrid('appendRow', { billId: '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'billId', colspan: 12 });
	            //隐藏分页导航条，这个需要熟悉datagrid的html结构，直接用jquery操作DOM对象，easyui datagrid没有提供相关方法隐藏导航条
	            $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
			}
			//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
			else{
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				$(dastorage.searchForm+' table').show();
				$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		toolbar : dastorage.tb
	});
	
};
    //条件查询
	$(dastorage.query).on("click", function() {
		var o = $.o2m.serializeObject($(dastorage.searchForm));
		$(dastorage.dgId).datagrid({url:'dastorage/list', queryParams:o});
	});
	//跳转查询库存
	$(dastorage.querystorage).on("click",function(){
		$(dastorage.list_panel).hide();
		$(dastorage.storage_panel).panel({href:"dastorage/storage"});
		$(dastorage.storage_panel).show();
	});
	
	//下载模板
	$(dastorage.pageId + " #btnUpload").on("click", function() {
		window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("带安商品库存设置单明细");
	});
	
	//批量导入
	$(dastorage.pageId + " #btnAdd").on("click", function() {
		 $(dastorage.list_panel).hide();
		    $(dastorage.import_panel).panel({
		        title:'导入', 
		        href:"dastorage/import"
		    });
		 $(dastorage.import_panel).panel('open');
	});
	//查看/审核
	dastorage.view = function(billId){
			$(dastorage.list_panel).hide();
			$(dastorage.view_panel).panel({href:"dastorage/view?billId="+billId});
			$(dastorage.view_panel).show();
		};
   //删除		
	dastorage.del = function(billId){
			$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
				if (r) {$.ajax({
					type : "POST",
					url : "dastorage/delete?billId="+billId,
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(dastorage.dgId).datagrid("reload");
						}
					}
				});
			}
			});
};
	/**
	 * 从Panel页面返回到列表页面
	 */
	dastorage.returnToListPage = function() {
		$(dastorage.import_panel).panel('close');
		$(dastorage.dgId).datagrid("reload");
		$(dastorage.list_panel).show();
	};
dastorage.inits();
