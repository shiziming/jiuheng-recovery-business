var splc_goods_up_list = {};

splc_goods_up_list.pageId="#goods_up_manage11";
splc_goods_up_list.list_panel = splc_goods_up_list.pageId + " #goods_list_panel";
splc_goods_up_list.view_panel = splc_goods_up_list.pageId + " #view_panel";
splc_goods_up_list.up_panel   = splc_goods_up_list.pageId + " #up_panel";
splc_goods_up_list.dgId=splc_goods_up_list.list_panel + " #dg";
splc_goods_up_list.tb = splc_goods_up_list.list_panel + " #tb";
splc_goods_up_list.query = splc_goods_up_list.list_panel + " #goods_list_query";
splc_goods_up_list.searchForm = splc_goods_up_list.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
splc_goods_up_list.inits = function() {
	$(splc_goods_up_list.dgId).datagrid({
		rownumbers : true,
		height : document.documentElement.clientHeight,
		pagination : true,
		pageSize : 20,
		url : 'wareFloor/list?status=0',
		fitColumns : true,
		 checkOnSelect: true, selectOnCheck: true,
		columns : [ [
			{field:'ck',checkbox:true},
			{
			field : 'djbh',
			title : '单据编号',
			align:'center',
			width : 50
		},{
			field : 'xszzdm',
			title : '销售组织代码',
			align:'center',
			width : 50
		},{
			field : 'zdrmc',
			title : '录入人',
			align:'center',
			width : 50
		},{
			field : 'zdsj',
			title : '录入时间',
			align:'center',
			width : 100
		},{
			field : 'shrmc',
			title : '审核人',
			align:'center',
			width : 50
		},{
			field : 'shsj',
			title : '审核时间',
			align:'center',
			width : 100
		},{
			field : 'status',
			title : '状态',
			align :'center',
			width : 50,
			formatter : function(value, row, index) {
				if(value==0){
					return "已录入";
				}else if(value == 1){
					return "已审核";
				}else if(value == -1){
					return '<span style="color:red">不同意</span>';
				}
			}
		},{
			field : 'action',
			title : '操作',
			align :'center',
			formatter : function(value, row, index) {
				var handle ='<a href="#" onclick="splc_goods_up_list.view(\'' + row.djbh + '\');">查看</a>';
				/*if(row.status==0){
					if($(splc_goods_up_list.pageId +' #func_maintain').val() == "true"){
						handle += ' <a href="#" onclick="splc_goods_up_list.update(\'' + row.billId + '\');">修改</a>'+
						' <a href="#" onclick="splc_goods_up_list.view(\'' + row.billId + '\');">删除</a> ';
					}
					if($(splc_goods_up_list.pageId +' #func_check').val() == "true"){
						handle += ' <a href="#" onclick="splc_goods_up_list.view(\'' + row.billId + '\');">审核</a>';
					}
				}*/
				return handle;

			}
		}] ],
		onLoadSuccess:function(data){
			if (data.total == 0) {
	            //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
	            $(this).datagrid('appendRow', { djbh: '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'djbh', colspan: 8 });
	            //隐藏分页导航条，这个需要熟悉datagrid的html结构，直接用jquery操作DOM对象，easyui datagrid没有提供相关方法隐藏导航条
	            $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
			}
			//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
			else{
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				$(splc_goods_up_list.searchForm+' table').show();
				$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		toolbar : splc_goods_up_list.tb
	});
	
};
	
	$(splc_goods_up_list.query).on("click", function() {
		var o = $.o2m.serializeObject($(splc_goods_up_list.searchForm));
		$(splc_goods_up_list.dgId).datagrid({url:'wareFloor/list', queryParams:o});
	});
	
splc_goods_up_list.view = function(billId){
		$(splc_goods_up_list.list_panel).hide();
		$(splc_goods_up_list.up_panel).panel({href:"wareFloor/viewDjbhDetail/"+billId});
		$(splc_goods_up_list.up_panel).show();
	};
	
splc_goods_up_list.check = function(billId){
		$(splc_goods_up_list.list_panel).hide();
		$(splc_goods_up_list.view_panel).panel({href:"wareFloor/viewUp?djbh="+djbh});
		$(splc_goods_up_list.view_panel).show();
	};
	
splc_goods_up_list.update = function(billId){
	var rows = $(splc_goods_up_list.dgId).datagrid("getSelections");	
	if (rows.length==0) {
		$.messager.alert('警告', '请至少选择一条记录!', 'warning');
	} else if (rows.length>1) {
		$.messager.alert('警告', '请选择一条记录!', 'warning');
	} else {
	 var djbh= rows[0].djbh;
		$(splc_goods_up_list.list_panel).hide();
		$(splc_goods_up_list.up_panel).panel({href:"wareFloor/viewDjbhDetail/"+djbh});
		$(splc_goods_up_list.up_panel).show();
	}
	};
	
splc_goods_up_list.del = function(billId){
	var rows = $(splc_goods_up_list.dgId).datagrid("getSelections");
	var orders=[];  
	for (var i = 0; i < rows.length; i++) {  
	          var djbh=rows[i].djbh;
	          orders.push(djbh); 
	}  
	

	if (rows.length!=0) {
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if (r) {
				$.ajax({
					type : "POST",
					url : "wareFloor/deleteall",
					data : "orderNums=" + orders,
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$(splc_goods_up_list.dgId).datagrid("reload");
						}
					}
				});
			}
		});
	} else {
		$.messager.alert('警告', '请至少选择一条记录!', 'warning');
	}
	};
	
	
splc_goods_up_list.go_up = function(){
		$(splc_goods_up_list.list_panel).hide();
		$(splc_goods_up_list.up_panel).panel({href:"wareFloor/goUp"});
		//$(splc_goods_up_list.up_panel).panel('open');
		$(splc_goods_up_list.up_panel).show();
	};
	
	
		
splc_goods_up_list.inits();
