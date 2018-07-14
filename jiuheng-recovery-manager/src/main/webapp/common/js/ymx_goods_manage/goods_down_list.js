var ymx_goods_down_list = {};

ymx_goods_down_list.pageId="#ymx_goods_down_manage";
ymx_goods_down_list.list_panel = ymx_goods_down_list.pageId + " #ymx_goods_list_panel";
ymx_goods_down_list.view_panel = ymx_goods_down_list.pageId + " #ymx_view_panel";
ymx_goods_down_list.down_panel   = ymx_goods_down_list.pageId + " #ymx_down_panel";
ymx_goods_down_list.dgId=ymx_goods_down_list.list_panel + " #ymx_dg";
ymx_goods_down_list.tb = ymx_goods_down_list.list_panel + " #ymx_tb";
ymx_goods_down_list.query = ymx_goods_down_list.list_panel + " #ymx_goods_list_query";
ymx_goods_down_list.searchForm = ymx_goods_down_list.list_panel + " #ymx_searchForm";
/**
 * 页面初始化函数
 */
ymx_goods_down_list.inits = function() {
	$(ymx_goods_down_list.dgId).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight,
		pagination : true,
		pageSize : 20,
		url : 'ymx_goodsManage/downlist?billType=2&status=0&channelCode=82',
		fitColumns : true,
		columns : [ [{
			field : 'billId',
			title : '单据编号',
			align:'center',
			width : 80
		},{
			field : 'channelCode',
			title : '渠道编码',
			align:'center',
			width : 50
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
				var handle ='<a href="#" onclick="ymx_goods_down_list.view(\'' + row.billId + '\');">查看</a>';
				if(row.status==0){
					if($(ymx_goods_down_list.pageId +' #func_maintain').val() == "true"){
						handle += ' <a href="#" onclick="ymx_goods_down_list.update(\'' + row.billId + '\');">修改</a>'+
						' <a href="#" onclick="ymx_goods_down_list.view(\'' + row.billId + '\');">删除</a> ';
					}
					if($(ymx_goods_down_list.pageId +' #func_check').val() == "true"){
						handle += ' <a href="#" onclick="ymx_goods_down_list.view(\'' + row.billId + '\');">审核</a>';
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
				$(ymx_goods_down_list.searchForm+' table').show();
				//$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		toolbar : ymx_goods_down_list.tb
	});
	
};
	
	$(ymx_goods_down_list.query).on("click", function() {
		var o = $.o2m.serializeObject($(ymx_goods_down_list.searchForm));
		$(ymx_goods_down_list.dgId).datagrid({url:'ymx_goodsManage/downlist?billType=2', queryParams:o});
	});
	
ymx_goods_down_list.view = function(billId){
		$(ymx_goods_down_list.list_panel).hide();
		$(ymx_goods_down_list.view_panel).panel({href:"ymx_goodsManage/viewDown?billId="+billId});
		$(ymx_goods_down_list.view_panel).show();
	};
	
ymx_goods_down_list.check = function(billId){
		$(ymx_goods_down_list.list_panel).hide();
		$(ymx_goods_down_list.view_panel).panel({href:"ymx_goodsManage/checkDown?billId="+billId});
		$(ymx_goods_down_list.view_panel).show();
	};
	
ymx_goods_down_list.update = function(billId){
		$(ymx_goods_down_list.list_panel).hide();
		$(ymx_goods_down_list.down_panel).panel({href:"ymx_goodsManage/goDown?billId="+billId});
		$(ymx_goods_down_list.down_panel).show();
	};
	
ymx_goods_down_list.del = function(billId){
		$(ymx_goods_down_list.list_panel).hide();
		$(ymx_goods_down_list.view_panel).panel({href:"ymx_goodsManage/viewDown?billId="+billId});
		$(ymx_goods_down_list.view_panel).show();
	};
	
	
ymx_goods_down_list.go_down = function(){
		$(ymx_goods_down_list.list_panel).hide();
		$(ymx_goods_down_list.down_panel).panel({href:"ymx_goodsManage/goDown"});
		$(ymx_goods_down_list.down_panel).show();
	};
ymx_goods_down_list.inits();
