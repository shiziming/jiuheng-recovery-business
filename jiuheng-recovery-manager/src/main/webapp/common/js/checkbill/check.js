var CheckBillCheckUtils = {};

//初始化
CheckBillCheckUtils.inits = function(){
	$("#checkBillCheckPage_dg").datagrid({
//		title : "支付交易对账单",
		height : $.o2m.centerHeight - 20,
//		fitColumns : true,
//		url:'checkbill/getBillList',
		method: 'post',
		rownumbers:true,
		pagination:true,
		pageSize: 20,
		pageList: [20,50,100],
		striped:true,
		toolbar : "#checkBillCheckPage_tb",
	    columns:[[
		     {field:'ck',checkbox:true}
	        ,{field:'billId',title:'单据编号',width:60}
	        ,{field:'saleOrgCode',title:'支付公司代码',width:100}
	        ,{field:'saleOrgName',title:'单据机构代码',width:150}
	        ,{field:'billOrgCode',title:'开始时间1',width:80,align:'right'}
	        ,{field:'createUserCode',title:'结束时间1',width:80,align:'right'}
	        ,{field:'createUserName',title:'开始时间2',width:100,align:'right'}
	        ,{field:'createTime',title:'结束时间2',width:100,align:'right'}
	        ,{field:'checkUserCode',title:'制单人ID',width:100,align:'right'}
	        ,{field:'checkUserName',title:'制单人名称',width:100,align:'right'}
	        ,{field:'checkTime',title:'制单时间',width:100,align:'right'}
	        ,{field:'checkTime',title:'审核人ID',width:100,align:'right'}
	        ,{field:'checkTime',title:'审核人名称',width:100,align:'right'}
	        ,{field:'checkTime',title:'审核时间',width:100,align:'right'}
	        ,{field:'checkTime',title:'状态',width:100,align:'right'}
	    ]],
	    onLoadSuccess:function(data){
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
	    }
	});

};

CheckBillCheckUtils.add = function(){
	var selectedRow = $('#commissionNewPage_dg').datagrid('getSelections');
	var data = $("#commissionNewPage_dg").datagrid("getChecked");
	$.ajax({
		type : "POST",
		url : "checkbill/addCheckBill",
		data : queryParams,
		success : function(result) {
			if ($.o2m.handleActionResult(result)) {
				
				$('#checkBillPage_newPanel').panel('close');
				$('#checkBillPage_billPanel').panel({
					title:'支付交易对账单', 
					href:"checkbill/openBill?billId=" + result.data
				});
				$('#checkBillPage_billPanel').panel('open');
			}
		},
		error : function() {
			$.messager.confirm('提示', '未知错误',
					function(r) {}
			);
		}
	});
};


CheckBillCheckUtils.inits();