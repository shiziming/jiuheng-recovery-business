var pricelogquery = {};

pricelogquery.pageId="#wdPriceLog_index";
pricelogquery.list_panel = pricelogquery.pageId + " #list_panel";
pricelogquery.viewpanel = pricelogquery.pageId + " #view_panel";
pricelogquery.dgId=pricelogquery.list_panel + " #dg";
pricelogquery.query = pricelogquery.list_panel + " #list_query";
pricelogquery.reset = pricelogquery.list_panel + " #list_reset";
pricelogquery.searchForm = pricelogquery.list_panel + " #searchForm";
pricelogquery.tb = pricelogquery.list_panel + " #tb";
/**
 * 页面初始化函数
 */
pricelogquery.inits = function() {
	$(pricelogquery.dgId).datagrid({
		striped : true,
		height : $.o2m.centerHeight - 205,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : false,
		columns:[ [
		{
		  field : 'ck',
		  checkbox : true,
		},{
			field : 'seqId',
			title : '售价流水号',
			align:'center',
			width:100,
		},{
			field : 'saleOrgCode',
			title : '销售组织代码',
			align:'center',
			width:80,
		},{
			field : 'skuId',
			title : 'SKU码',
			align:'center',
			width:80,
		},{
			field : 'priceType',
			title : '商品价格类型',
			align:'center',
			width:80,
			formatter:function(value){
				if(value=='ZP47'){
					return '佣金';
				}else if(value=='ZP43'){
					return '一口价集采';
				}else if(value=='ZP44'){
					return '一口价地采';
				}
			}
		},{
			field : 'startDate',
			title : '开始日期',
			align:'center',
			width:100,
		},{
			field : 'endDate',
			title : '结束日期',
			align:'center',
			width:100,
		},{
			field : 'price',
			title : '商品价格',
			align:'center',
			width:60,
		},{
			field : 'limitNum',
			title : '限制数量',
			align:'center',
			width:60,
		},{
			field : 'status',
			title : '价格状态',
			align:'center',
			width:100,
		},{
			field : 'lastUpdate',
			title : '最后维护时间',
			align:'center',
			width:150,
		},{
			field : 'scbj',
			title : '上传标记',
			align:'center',
			width:80,
			formatter:function(value){
				if(value=='1'){
					return '成功';
				}else if(value=='-1'){
					return '失败';
				}else{
					return '未上传';
				}
			}
		},{
			field : 'uploadTime',
			title : '上传时间',
			align:'center',
			width:150,
		},{
			field : 'zhMsg',
			title : '上传失败原因',
			align:'center',
			width:250,
		},{
			field : 'failMsg',
			title : '上传失败信息',
			align:'center',
			width:250,
		}] ],
		toolbar:pricelogquery.tb,
		onLoadSuccess : function() {
			$('#searchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(pricelogquery.query).on("click", function() {
		if($(pricelogquery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(pricelogquery.searchForm));
			$(pricelogquery.dgId).datagrid({url:'sku/priceLoglist', queryParams:o});
		}
	});
	$(pricelogquery.reset).on("click", function() {
		$(pricelogquery.searchForm).form("clear");
	});
	//重新推送
	pricelogquery.push = function() {
	var rows = $(pricelogquery.dgId).datagrid("getSelections");
	var seqIds=[];  
	for (var i = 0; i < rows.length; i++) {  
	          var seqId=rows[i].seqId;
	          seqIds.push(seqId); 
	    } 
	if (rows.length!=0) {
				$.ajax({
					type : "POST",
					url : "sku/pushPrice",
					data : "seqIds=" +seqIds,
					success : function(result) {
								$(pricelogquery.dgId).datagrid("reload");
					}
				});
	} 
	if (rows.length==0){
		$.messager.alert('警告', '请至少选择一条记录!', 'warning');
	}
  };
pricelogquery.inits();