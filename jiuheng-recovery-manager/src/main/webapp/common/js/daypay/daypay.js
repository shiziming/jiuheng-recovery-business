var daypay = {};

daypay.pageId="#daypay";
daypay.list_panel = daypay.pageId + " #list_panel";
daypay.checkpanel = daypay.pageId + " #check_panel";
daypay.viewpanel = daypay.pageId + " #view_panel";
daypay.dgId=daypay.list_panel + " #dg";
daypay.query = daypay.list_panel + " #query";
daypay.reset = daypay.list_panel + " #check_list_reset";
daypay.searchForm = daypay.list_panel + " #searchForm";
daypay.tb=daypay.list_panel + " #tb";
/**
 * 页面初始化函数
 */
daypay.inits = function() {
	$(daypay.dgId).datagrid({
		striped : true,
		height : document.documentElement.clientHeight * 0.86,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
//		fitColumns:true,
		checkOnSelect : true,
		columns : [ [
		{	field:'ck',
			checkbox:true},
		{
			field : 'id',
			title : 'OTM凭证号',
			align:'center',
			width:160,
		},{
			field : 'payCompCode',
			title : '支付公司代码',
			align:'center',
			width:160,
		},{
			field : 'shopId',
			title : '门店代码	',
			align:'center',
			width:160,
		},{
			field : 'uploaded',
			title : '上传状态',
			align:'center',
			width:160,
			formatter : function(value, row, index) {
				if(row.uploaded==1){
					return '上传未反馈';
				}else if(row.uploaded==0){
					return '未上传';
				}else if(row.uploaded==-1){
					return '上传失败';
				}else if(row.uploaded==2){
					return '上传成功';
				}
			}
		},{
			field : 'uploadTime',
			title : '凭证上传时间',
			align:'center',
			width:180,
		},{
			field : 'voucherTime',
			title : '凭证反馈时间',
			align:'center',
			width:180,
		},{
			field : 'voucherDate',
			title : '凭证日期',
			align:'center',
			width:180,
		},{
			field : 'sapInfo',
			title : '反馈信息',
			align:'center',
			width:400
		}] ],
		toolbar:daypay.tb,
		onLoadSuccess : function() {
			$('#searchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(daypay.query).on("click", function() {
		var interfacetype=$('#interfacetype').combobox('getValue');
		if('FI187'==interfacetype||'FI188'==interfacetype){
			var o = $.o2m.serializeObject($(daypay.searchForm));
			$(daypay.dgId).datagrid({url:'daypay/listloadData', queryParams:o});
		}
		if('FI207'==interfacetype){
			var o = $.o2m.serializeObject($(daypay.searchForm));
			$(daypay.dgId).datagrid({url:'daypay/amazonListloadData', queryParams:o});
		}
	});
	$(daypay.reset).on("click", function() {
		$(daypay.searchForm).form("clear");
	});
	daypay.resend=function(){
		var checkedItems = $(daypay.dgId).datagrid('getChecked');
		var row= $(daypay.dgId).datagrid('getSelected');
		var ids = [];
		for(var i=0;i<checkedItems.length; i++){
			if(checkedItems[i].uploaded == -1 || checkedItems[i].uploaded==1){
				ids.push(checkedItems[i].id);
			}else{
				$.messager.alert('提示','只能重发失败或未反馈消息消息','error',null);
				return;
			}
		}
		if(ids.length<1){
			$.messager.alert('提示','至少选择一条失败消息重发！','error',null);
			return;
		}
		$.o2m.showProgressing();
		$.ajax({
			type : "POST",
			url : "daypay/resend?interfacetype="+row.interfacetype,
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(ids),
			success : function(msg) {
				$.o2m.closeProgressing();
				$.messager.alert("重发完成", msg.msg, "info", function () {  
					$(daypay.dgId).datagrid('reload');
		        });  
				
			}
		});
	};
	
	daypay.check = function(returnId){
		$(daypay.list_panel).hide();
		$(daypay.checkpanel).panel({title:'微店退款审核',href:"daypay/toCheck?returnId="+returnId});
		$(daypay.checkpanel).panel('open');
	};
	daypay.view = function(returnId){
		$(daypay.list_panel).hide();
		$(daypay.viewpanel).panel({title:'微店退款审核查看',href:"daypay/toView?returnId="+returnId});
		$(daypay.viewpanel).panel('open');
	};

daypay.inits();
