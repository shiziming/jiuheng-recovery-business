var gmj_goods_up_list = {};
 
gmj_goods_up_list.pageId="#goods_up_manage1";
gmj_goods_up_list.list_panel = gmj_goods_up_list.pageId + " #goods_list_panel";
gmj_goods_up_list.view_panel = gmj_goods_up_list.pageId + " #view_panel";
gmj_goods_up_list.up_panel   = gmj_goods_up_list.pageId + " #up_panel";
gmj_goods_up_list.dgId=gmj_goods_up_list.list_panel + " #dg";
gmj_goods_up_list.tb = gmj_goods_up_list.list_panel + " #tb";
gmj_goods_up_list.query = gmj_goods_up_list.list_panel + " #goods_list_query";
gmj_goods_up_list.searchForm = gmj_goods_up_list.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
gmj_goods_up_list.inits = function() {
	$(gmj_goods_up_list.dgId).datagrid({
		rownumbers : true,
		height : document.documentElement.clientHeight,
		pagination : true,
		pageSize : 20,
		url : 'gmjGoodsManage/uplist?billType=1&status=0&channelCode=84',
		fitColumns : true,
		columns : [ [{
			field : 'billId',
			title : '单据编号',
			align:'center',
			width : 50
		},{
			field : 'channelCode',
			title : '渠道编码',
			align:'center',
			width : 50
		},{
			field : 'billOrgCode',
			title : '单据机构代码',
			align:'center',
			width : 50
		},{
			field : 'createUserName',
			title : '录入人',
			align:'center',
			width : 50
		},{
			field : 'createUserCode',
			title : '录入人代码',
			align:'center',
			width : 50
		},{
			field : 'createTime',
			title : '录入时间',
			align:'center',
			width : 100
		},{
			field : 'checkUserName',
			title : '审核人',
			align:'center',
			width : 50
		},{
			field : 'checkUserCode',
			title : '审核人ID',
			align:'center',
			width : 50
		},{
			field : 'checkTime',
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
				var handle ='<a href="#" onclick="gmj_goods_up_list.view(\'' + row.billId + '\');">查看</a>';
				if(row.status==0){
					if($(gmj_goods_up_list.pageId +' #func_maintain').val() == "true"){
						handle += ' <a href="#" onclick="gmj_goods_up_list.update(\'' + row.billId + '\');">修改</a>'+
						' <a href="#" onclick="gmj_goods_up_list.view(\'' + row.billId + '\');">删除</a> ';
					}
					if($(gmj_goods_up_list.pageId +' #func_check').val() == "true"){
						handle += ' <a href="#" onclick="gmj_goods_up_list.view(\'' + row.billId + '\');">审核</a>';
					}
				}
				return handle;

			}
		}] ],
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
				$(gmj_goods_up_list.searchForm+' table').show();
				$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		toolbar : gmj_goods_up_list.tb
	});
	
};
	
	$(gmj_goods_up_list.query).on("click", function() {
		var o = $.o2m.serializeObject($(gmj_goods_up_list.searchForm));
		$(gmj_goods_up_list.dgId).datagrid({url:'gmjGoodsManage/uplist?billType=1', queryParams:o});
	});
	
gmj_goods_up_list.view = function(billId){
		$(gmj_goods_up_list.list_panel).hide();
		$(gmj_goods_up_list.view_panel).panel({href:"gmjGoodsManage/viewUp?billId="+billId});
		$(gmj_goods_up_list.view_panel).show();
	};
	
gmj_goods_up_list.check = function(billId){
		$(gmj_goods_up_list.list_panel).hide();
		$(gmj_goods_up_list.view_panel).panel({href:"gmjGoodsManage/viewUp?billId="+billId});
		$(gmj_goods_up_list.view_panel).show();
	};
	
gmj_goods_up_list.update = function(billId){
		$(gmj_goods_up_list.list_panel).hide();
		$(gmj_goods_up_list.up_panel).panel({href:"gmjGoodsManage/goUp?billId="+billId});
		$(gmj_goods_up_list.up_panel).show();
	};
	
gmj_goods_up_list.del = function(billId){
		$(gmj_goods_up_list.list_panel).hide();
		$(gmj_goods_up_list.view_panel).panel({href:"gmjGoodsManage/viewUp?billId="+billId});
		$(gmj_goods_up_list.view_panel).show();
	};
	
	
gmj_goods_up_list.go_up = function(){
		$(gmj_goods_up_list.list_panel).hide();
		$(gmj_goods_up_list.up_panel).panel({href:"gmjGoodsManage/goUp"});
		$(gmj_goods_up_list.up_panel).show();
	};
gmj_goods_up_list.inits();
