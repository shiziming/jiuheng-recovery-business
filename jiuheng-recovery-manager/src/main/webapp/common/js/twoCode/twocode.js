var twocode = {};

twocode.pageId="#twocodePage";
twocode.list_panel = twocode.pageId + " #twocode_list_panel";
twocode.edit_panel = twocode.pageId + " #edit_panel";
twocode.dgId=twocode.list_panel + " #dg";
twocode.toolBar = twocode.pageId + ' #toolbar';

twocode.query = twocode.list_panel + " #twocode_list_query";
twocode.reset = twocode.list_panel + " #twocode_list_reset";
twocode.add=twocode.list_panel+" #twocode_list_btnAdd";
twocode.create=twocode.list_panel+" #twocode_list_btnCreate";
twocode.search=twocode.list_panel+" #twocode_list_search";
twocode.upload=twocode.list_panel+" #twocode_list_btnUpload";
twocode.searchForm = twocode.list_panel + " #searchForm";

/**
 * 页面初始化函数
 */
 
twocode.inits = function() {
	$(twocode.dgId).datagrid({
		striped : true,
		height : $.o2m.centerHeight - 20,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		toolbar : twocode.toolBar,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : false,
		columns : [ [{
			field : 'ck',
			checkbox : true
		},{
			field : 'storeCode',
			title : '门店代码',
			align:'center',
			width:80
		},{
			field : 'storeName',
			title : '门店名称',
			align:'center',
			width:80
		},{
			field : 'skuId',
			title : '商品内码',
			align:'center',
			width:100
		},{
			field : 'skuName',
			title : '商品名称',
			align:'center',
			width:80
		},{
			field : 'channelCode',
			title : '渠道代码',
			align:'center',
			width:80
		},{
			field : 'twoCodeMess',
			title : '商品二维码内容',
			align:'center',
			width:150
		},{
			field : 'height',
			title : '图片高度',
			align:'center',
			width:80
		},{
			field : 'width',
			title : '图片宽度',
			align:'center',
			width:80
		},{
			field : 'url',
			title : '图片URL',
			align:'center',
			width:100
		},{
			field : 'handlerId',
			title : '最后维护人ID',
			align :'center',
			width:80
		},{
			field : 'handlerName',
			title : '最后维护人名称',
			align : 'center',
			width:100
		},{
			field : 'handelTime',
			title : '最后维护时间',
			align : 'center',
			width:100
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
						return "已生成";
					}
			}
//		},{
//			field : 'action',
//			title : '操作',
//			align :'center',
//			formatter : function(value, row, index) {
//				return '<a href="#" onclick="twocode.cre(\'' + row.storeCode + '\',\''+row.skuId+'\',\''+row.twoCodeMess+'\');">生成二维码</a>';
//			}
		}] ],
		loadMsg : "数据加载中...",
		onLoadSuccess : function() {
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
		}
	});
};

    //条件查询
	$(twocode.query).on("click", function() {
		var o = $.o2m.serializeObject($(twocode.searchForm));
		$(twocode.dgId).datagrid({url:'twocode/listloadData', queryParams:o});
	});
	//重置
	$(twocode.reset).on("click", function() {
		$(twocode.searchForm).form("clear");
	});
	// 添加
	$(twocode.add).on("click", function() {
		$(twocode.list_panel).hide();
		$(twocode.edit_panel).panel({title:'添加',href:"twocode/toAdd",height : $.o2m.centerHeight - 20});
		$(twocode.edit_panel).panel('open');
	});
	//下载模板
	$(twocode.upload).on("click", function() {
		window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("商品二维码信息");
	});
	//批量导入
	 $(twocode.pageId + " #twocode_list_btnImport").on("click", function() {
		$(twocode.list_panel).hide();
		$(twocode.edit_panel).panel({title:'导入',href:"twocode/import"});
		$(twocode.edit_panel).panel('open');
	});
//	//生成二维码
//	twocode.cre=function(storeCode,skuId){
//		$(twocode.list_panel).hide();
//		$(twocode.import_panel).panel({title:'生成二维码',href:"twocode/create?storeCode=" +storeCode+"&skuId="+skuId+"&ewmUrl="+ewmUrl,height : $.o2m.centerHeight - 20});
//		$(twocode.import_panel).panel('open');
//		}
	//批量生成二维码
//	$(twocode.create).on("click", function() {
//		var rows = $(twocode.dgId).datagrid("getSelections");
//		if(rows.length!=0){
//			if(rows.length==1){
//				$(twocode.dlg).dialog({'title':'单个生成二维码'});
//				$(twocode.dlg+" #saveForm").form('clear');
//				$(twocode.dlg).dialog('open');
//			}else{
//				$.messager.alert('警告', '只能选择一条记录!', 'warning');
//			}
//		}else{
//			$.messager.alert('警告', '至少选择一条记录!', 'warning');
//		}
//	});
			$(twocode.create).on("click", function() {
			var rows = $(twocode.dgId).datagrid("getSelections");
			if(rows.length==1){
				var storeCodes=[];  
				var skuIds=[];
				for (var i = 0; i < rows.length; i++) {  
				          var storeCode=rows[i].storeCode;
				          var skuId=rows[i].skuId
				          storeCodes.push(storeCode); 
				          skuIds.push(skuId);
				    } 
			$.o2m.showProgressing();
				 $.ajax({
					type : "POST",
					url : "twocode/createAll?storeCodes="+storeCodes+"&skuIds="+skuIds,
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						$.o2m.closeProgressing();
						if($.o2m.handleActionResult(result)){
							$(twocode.dgId).datagrid("reload");
							$(twocode.dlg).dialog('close');
						}
					}
				});
			}else{
				$.messager.alert('警告', '请选择一条记录!', 'warning');
			}
		});
	//查看二维码
	$(twocode.search).on("click", function() {
		var rows=$(twocode.dgId).datagrid("getSelections");
		if(rows.length!=0){
		$(twocode.list_panel).hide();
		$(twocode.edit_panel).panel({title:'查看',href:"twocode/toSearch",height : $.o2m.centerHeight - 20});
		$(twocode.edit_panel).panel('open');
		}else{
			$.messager.alert('警告', '至少选择一条记录!', 'warning');
		}
	});
	//下载二维码
	twocode.btnExport = function() {
		var rows = $(twocode.dgId).datagrid("getSelections");
		if(rows.length!=0){
			var storeCodes = [];
			var skuIds = [];
			for (var i = 0; i < rows.length; i++) {
				var storeCode = rows[i].storeCode;
				var skuId = rows[i].skuId
				storeCodes.push(storeCode);
				skuIds.push(skuId);
			}
		window.location.href = "twocode/export?storeCodes=" + storeCodes
				+ "&skuIds=" + skuIds;
		}else{
			$.messager.alert('警告', '至少选择一条记录!', 'warning');
		}
	};
	//保存
	twocode.save=function(){
		if(!$(twocode.edit_panel).find('form').form('enableValidation').form('validate')){
			 return false;
			}
		   var two={};
		   two.storeCode=$(twocode.edit_panel+" #storeCode").val();
		   two.skuId=$(twocode.edit_panel+" #skuId").val();
		 $.ajax({
				type : "POST",
				url: "twocode/save",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(two),
				success : function(result) {
					if($.o2m.handleActionResult(result)){
						$(twocode.edit_panel).panel('close');
						$(twocode.dgId).datagrid("reload");
						$(twocode.list_panel).show();
					}
				}
			 }); 
	};
	/**
	 * 从Panel页面返回到列表页面
	 */
	twocode.returnToListPage = function() {
		$(twocode.edit_panel).panel('close');
		$(twocode.dgId).datagrid("reload");
		$(twocode.list_panel).show();
	};
	/**
	 * 从Panel页面返回到列表页面
	 */
	twocode.returned= function() {
		$(twocode.dlg).panel('close');
		$(twocode.dgId).datagrid("reload");
	};
	
twocode.inits();
