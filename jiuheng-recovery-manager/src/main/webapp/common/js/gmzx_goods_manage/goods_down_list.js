var gmzx_goods_down_list = {};

gmzx_goods_down_list.pageId="#gmzx_goods_down_manage";
gmzx_goods_down_list.list_panel = gmzx_goods_down_list.pageId + " #goods_list_panel";
gmzx_goods_down_list.view_panel = gmzx_goods_down_list.pageId + " #view_panel";
gmzx_goods_down_list.down_panel   = gmzx_goods_down_list.pageId + " #down_panel";
gmzx_goods_down_list.dgId=gmzx_goods_down_list.list_panel + " #dg";
gmzx_goods_down_list.tb = gmzx_goods_down_list.list_panel + " #tb";
gmzx_goods_down_list.query = gmzx_goods_down_list.list_panel + " #goods_list_query";
gmzx_goods_down_list.searchForm = gmzx_goods_down_list.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
gmzx_goods_down_list.inits = function() {
	$(gmzx_goods_down_list.dgId).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight,
		pagination : true,
		pageSize : 20,
		fitColumns : true,
		columns : [ [{
			field : 'billId',
			title : '单据编号',
			align:'center',
			width : 80
		},{
			field : 'channelCode',
			title : '渠道代码',
			align:'center',
			width : 100
		},{
			field : 'billOrgCode',
			title : '单据机构代码',
			align:'center',
			width : 100
		},{
			field : 'createUserName',
			title : '录入人',
			align:'center',
			width : 100
		},{
			field : 'createUserCode',
			title : '录入人代码',
			align:'center',
			width : 100
		},{
			field : 'createTime',
			title : '录入时间',
			align:'center',
			width : 180
		},{
			field : 'checkUserName',
			title : '审核人',
			align:'center',
			width : 100
		},{
			field : 'checkUserCode',
			title : '审核人ID',
			align:'center',
			width : 100
		},{
			field : 'checkTime',
			title : '审核时间',
			align:'center',
			width : 180
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
				var handle ='<a href="#" onclick="gmzx_goods_down_list.view(\'' + row.billId + '\');">查看</a>';
				if(row.status==0){
					if($(gmzx_goods_down_list.pageId +' #func_maintain').val() == "true"){
						handle += ' <a href="#" onclick="gmzx_goods_down_list.update(\'' + row.billId + '\');">修改</a>'+
						' <a href="#" onclick="gmzx_goods_down_list.view(\'' + row.billId + '\');">删除</a> ';
					}
					if($(gmzx_goods_down_list.pageId +' #func_check').val() == "true"){
						handle += ' <a href="#" onclick="gmzx_goods_down_list.view(\'' + row.billId + '\');">审核</a>';
					}
				}
				return handle;
			}
		} ]],
		onLoadSuccess:function(data){
			if (data.total == 0) {
	            //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
	            $(this).datagrid('appendRow', { billId: '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'billId', colspan: 11 });
	            //隐藏分页导航条，这个需要熟悉datagrid的html结构，直接用jquery操作DOM对象，easyui datagrid没有提供相关方法隐藏导航条
	            $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
			}
			//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
			else{
				$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
				$(gmzx_goods_down_list.searchForm+' table').show();
				//$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		toolbar : gmzx_goods_down_list.tb
	});
	
};
	
	$(gmzx_goods_down_list.query).on("click", function() {
		var o = $.o2m.serializeObject($(gmzx_goods_down_list.searchForm));
		$(gmzx_goods_down_list.dgId).datagrid({url:'gmzxGoodsManager/downlist?billType=2', queryParams:o});
	});
	
gmzx_goods_down_list.view = function(billId){
		$(gmzx_goods_down_list.list_panel).hide();
		$(gmzx_goods_down_list.view_panel).panel({href:"gmzxGoodsManager/viewDown?billId="+billId});
		$(gmzx_goods_down_list.view_panel).show();
	};
	
gmzx_goods_down_list.check = function(billId){
		$(gmzx_goods_down_list.list_panel).hide();
		$(gmzx_goods_down_list.view_panel).panel({href:"gmzxGoodsManager/checkDown?billId="+billId});
		$(gmzx_goods_down_list.view_panel).show();
	};
	
gmzx_goods_down_list.update = function(billId){
		$(gmzx_goods_down_list.list_panel).hide();
		$(gmzx_goods_down_list.down_panel).panel({href:"gmzxGoodsManager/goDown?billId="+billId});
		$(gmzx_goods_down_list.down_panel).show();
	};
	
gmzx_goods_down_list.del = function(billId){
		$(gmzx_goods_down_list.list_panel).hide();
		$(gmzx_goods_down_list.view_panel).panel({href:"gmzxGoodsManager/viewDown?billId="+billId});
		$(gmzx_goods_down_list.view_panel).show();
	};
	
	
gmzx_goods_down_list.go_down = function(){
		$(gmzx_goods_down_list.list_panel).hide();
		$(gmzx_goods_down_list.down_panel).panel({href:"gmzxGoodsManager/goDown"});
		$(gmzx_goods_down_list.down_panel).show();
	};
gmzx_goods_down_list.inits();
