var CommissionUtils = {};

//初始化
CommissionUtils.inits = function(){
	$("#commissionPage_dg").datagrid({
		title : "线上佣金发放单",
		height : $.o2m.centerHeight - 20,
		fitColumns : true,
		url:'commission/billList',
		method: 'post',
		rownumbers:true,
		pagination:true,
		pageSize: 10,
		pageList: [20],
		striped:true,
		toolbar : '#commissionPage_tb',
	    columns:[[
		          	{field:'ck',checkbox:true}
	        ,{field:'billId',title:'单据编号',width:60}
	        ,{field:'saleOrgCode',title:'销售组织代码',width:100}
	        ,{field:'saleOrgName',title:'销售组织名称',width:150}
	        ,{field:'billOrgCode',title:'单据机构代码',width:80,align:'right'}
	        ,{field:'createUserCode',title:'制单人ID',width:80,align:'right'}
	        ,{field:'createUserName',title:'制单人名称',width:100,align:'right'}
	        ,{field:'createTime',title:'制单时间',width:100,align:'right'}
	        ,{field:'checkUserCode',title:'审核人ID',width:100,align:'right'}
	        ,{field:'checkUserName',title:'审核人名称',width:100,align:'right'}
	        ,{field:'checkTime',title:'审核时间',width:100,align:'right'}
	        ,{field:'status',title:'状态',width:60,align:'right',
			        	formatter : function(value, row, index) {
										if (value == 0) {
											return "建单中";
										} else if (value == 1) {
											return "已审核";
										}
									}
	        }
	    ]]
	});
	
	
};

//打开查询页面
CommissionUtils.openSearch = function(){
	$("#commissionPage_search").window({
		title: '线上佣金发放单查询',
		iconCls: 'icon-ok',
	    width: 400,
	    height: 250,
	    modal:true,
	    collapsible: false,
	    minimizable: false,
	    maximizable: false,
	    href: 'commission/queryCommissionBill'
	});
};

//打开新建页面
CommissionUtils.openAdd = function(){
	 $('#commissionPage_listPanel').hide();
	 $('#commissionPage_newPanel').panel({
		 title:'新增佣金发放单', 
		 href:"commission/newCommissionBill"
	 });
	 $('#commissionPage_newPanel').panel('open');
	
//	$("#commissionPage_add").window({
//		title: '新增佣金发放单',
//	    onClose: function(){$("#commissionPage_dg").datagrid('reload');},
//		iconCls: 'icon-ok',
//	    width: 800,
//	    height: 650,
//	    top: 50,
//	    modal:true,
//	    collapsible: false,
//	    minimizable: false,
//	    maximizable: false,
//	    href: 'commission/newCommissionBill',
//	});
};

//打开查看明细页面
CommissionUtils.openDetail = function(){
	var selectedRow = $('#commissionPage_dg').datagrid('getSelections');
	if (selectedRow.length == 1 ) {
		var billId = $("#commissionPage_dg").datagrid("getChecked")[0].billId;
		
		 $('#commissionPage_listPanel').hide();
		 $('#commissionPage_detailPanel').panel({
			 title:'佣金发放明细', 
			 href:"commission/detailCommissionBill?billId=" + billId,
		 });
		 $('#commissionPage_detailPanel').panel('open');
		
		
		
		
//		$("#commissionPage_detail").window({
//			title: '佣金发放明细',
//		    onClose: function(){$("#commissionPage_dg").datagrid('reload');},
//			iconCls: 'icon-ok',
//		    width: 800,
//		    height: 650,
//		    top: 50,
//		    modal:true,
//		    collapsible: false,
//		    minimizable: false,
//		    maximizable: false,
//		    href: 'commission/detailCommissionBill?billId=' + billId,
//		});
		
	}
};


CommissionUtils.inits();