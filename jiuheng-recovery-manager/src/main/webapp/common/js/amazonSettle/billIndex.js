var SettleBillUtils = {};

// 初始化
SettleBillUtils.inits = function() {
	$("#settleBillPage_dg").datagrid({
		title : "结算对账单",
		height : $.o2m.centerHeight - 20,
		// fitColumns : true,
		url : 'settlebill/getBillList',
		method : 'post',
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		pageList : [20,50,100],
		striped : true,
		toolbar : "#settleBillPage_tb",
		columns : [ [ {
			field : 'ck',
			checkbox : true
		}, {
			field : 'billId',
			title : '单据编号',
			width : 60,
			align : 'right'
		}, {
			field : 'status',
			title : '状态',
			width : 60,
			align : 'left',
			formatter : function(value, row, index) {
				if (value == 0) {
					return "建单中";
				} else if (value == 1) {
					return "已审核";
				}
			}
		}, {
			field : 'channelId',
			title : '渠道代码',
			width : 60,
			hidden : true
		}, {
			field : 'companyId',
			title : '销售公司代码',
			width : 100,
			align : 'left'
		}, {
			field : 'saleOrgId',
			title : '销售组织代码',
			width : 100,
			align : 'left'
		}, {
			field : 'settleDate',
			title : '结算出账日期',
			width : 85,
			align : 'left'
		}, {
			field : 'startTime',
			title : '结算开始时间',
			width : 85,
			align : 'left'
		}, {
			field : 'endTime',
			title : '结算结束时间',
			width : 85,
			align : 'left'
		}, {
			field : 'salesAmountSum',
			title : '总成交金额',
			width : 85,
			align : 'right',
			formatter : function(value, row, index) {
				 return (value/100).toFixed(2);
			}
		}, {
			field : 'commissionSum',
			title : '佣金合计',
			width : 85,
			align : 'right',
			formatter : function(value, row, index) {
				 return (value/100).toFixed(2);
			}
		}, {
			field : 'advFeeSum',
			title : '广告费合计',
			width : 85,
			align : 'right',
			formatter : function(value, row, index) {
				 return (value/100).toFixed(2);
			}
		}, {
			field : 'refundMgmtFeeSum',
			title : '退款管理费合计',
			width : 90,
			align : 'right',
			formatter : function(value, row, index) {
				 return (value/100).toFixed(2);
			}
		}, {
			field : 'netSalesAmountSum',
			title : '销售净金额合计',
			width : 90,
			align : 'right',
			formatter : function(value, row, index) {
				 return (value/100).toFixed(2);
			}
		}, {
			field : 'billAgencyCode',
			title : '单据机构代码',
			width : 100,
			align : 'left'
		}, {
			field : 'createUserId',
			title : '制单人ID',
			width : 100,
			align : 'left'
		}, {
			field : 'createUserName',
			title : '制单人名称',
			width : 100,
			align : 'left'
		}, {
			field : 'createTime',
			title : '制单时间',
			width : 150,
			align : 'left'
		}, {
			field : 'auditUserId',
			title : '审核人ID',
			width : 100,
			align : 'left'
		}, {
			field : 'auditUserName',
			title : '审核人名称',
			width : 100,
			align : 'left'
		}, {
			field : 'autditTime',
			title : '审核时间',
			width : 150,
			align : 'left'
		} ] ],
		onLoadSuccess : function(data) {
			$(this).datagrid('doCellTip', {
				'max-width' : '300px',
				'delay' : 500
			});
		}
	});

};

// 打开查询页面
SettleBillUtils.search = function() {
	var companyId = $('#settleBillPage_companyId').val();
	var saleOrgId = $('#settleBillPage_saleOrgId').val();
	var queryParams = {
		'companyId' : companyId,
		'saleOrgId' : saleOrgId
	};
	$('#settleBillPage_dg').datagrid({
		queryParams : queryParams
	});

};

// 打开新建页面
SettleBillUtils.openNew = function() {
	$('#settleBillPage_listPanel').hide();
	$('#settleBillPage_editPanel').hide();
	$('#settleBillPage_newPanel').panel({
		title : '新建结算对账单',
		href : "settlebill/openNew"
	});
	$('#settleBillPage_newPanel').panel('open');

};

// 打开查看明细页面
SettleBillUtils.openDetail = function() {

	var selectedRow = $('#settleBillPage_dg').datagrid('getSelections');
	if (selectedRow.length == 1) {
		var billId = $("#settleBillPage_dg").datagrid("getChecked")[0].billId;
		$('#settleBillPage_listPanel').hide();
		$('#settleBillPage_billPanel').panel({
			title : '更改结算对账单',
			href : "settlebill/openBill?billId=" + billId
		});
		$('#settleBillPage_billPanel').panel('open');
//		alert(billId);
//		$.ajax({
//			type : "POST",
//			url : "settlebill/checkLock",
//			data : {
//				'billId' : billId
//			},
//			success : function(result) {
//				if (result.code == 0) {
//					$('#settleBillPage_listPanel').hide();
//					$('#settleBillPage_billPanel').panel({
//						title : '更改结算对账单',
//						href : "settlebill/openBill?billId=" + billId
//					});
//					$('#settleBillPage_billPanel').panel('open');
//
//				} else {
//					$.o2m.handleActionResult(result);
//				};
//			},
//			error : function() {
//				$.messager.confirm('提示', '未知错误', function(r) {
//				});
//			}
//		});
	}
};

SettleBillUtils.viewDetail = function() {

	var selectedRow = $('#settleBillPage_dg').datagrid('getSelections');
	if (selectedRow.length == 1) {
		var billId = $("#settleBillPage_dg").datagrid("getChecked")[0].billId;
		$('#settleBillPage_listPanel').hide();
		$('#settleBillPage_billPanel').panel({
			title : '查看结算对账单',
			href : "settlebill/viewBill?billId=" + billId
		});
		$('#settleBillPage_billPanel').panel('open');

	}
	;
};


SettleBillUtils.inits();