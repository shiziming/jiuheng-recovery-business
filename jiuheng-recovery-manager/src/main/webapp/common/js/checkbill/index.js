var CheckBillUtils = {};

// 初始化
CheckBillUtils.inits = function() {
	$("#checkBillPage_dg").datagrid({
		title : "支付交易对账单",
		height : $.o2m.centerHeight - 20,
		// fitColumns : true,
		url : 'checkbill/getBillList',
		method : 'post',
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		pageList : [20,50,100],
		striped : true,
		toolbar : "#checkBillPage_tb",
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
			align : 'right',
			align : 'right',
			formatter : function(value, row, index) {
				if (value == 0) {
					return "建单中";
				} else if (value == 1) {
					return "已审核";
				}
			}
		}, {
			field : 'payCompanyCode',
			title : '支付公司代码',
			width : 60,
			align : 'right'
		}, {
			field : 'payMethodId',
			title : '支付方式ID',
			width : 100,
			hidden : true
		}, {
			field : 'payMethodName',
			title : '支付方式',
			width : 100,
			align : 'right'
		}, {
			field : 'receiveAccountNo',
			title : '收付账户号',
			width : 100,
			align : 'right'
		}, {
			field : 'bankAccountNo',
			title : '银行账户号',
			width : 100,
			align : 'right'
		}, {
			field : 'arrivalRecordNo',
			title : '资金到账记录号',
			width : 100,
			align : 'right'
		}, {
			field : 'billAgencyCode',
			title : '单据机构代码',
			width : 100,
			align : 'right'
		}, {
			field : 'startPayTime',
			title : '订单支付开始时间',
			width : 100,
			align : 'right'
		}, {
			field : 'endPayTime',
			title : '订单支付结束时间',
			width : 100,
			align : 'right'
		}, {
			field : 'payDate',
			title : '支付日期',
			width : 100,
			align : 'right'
		}, {
			field : 'arrivalDate',
			title : '资金到账日期',
			width : 100,
			align : 'right'
		}, {
			field : 'voucherDate',
			title : '凭证日期',
			width : 100,
			align : 'right'
		}, {
			field : 'arrivalAmount',
			title : '资金到账金额',
			width : 100,
			align : 'right',
			formatter:function(value, row, index) {return( (value/100).toFixed(2)); }
		}, {
			field : 'commissionCharge',
			title : '手续费',
			width : 100,
			align : 'right',
			formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }
		}, {
			field : 'createUserId',
			title : '制单人ID',
			width : 100,
			align : 'right'
		}, {
			field : 'createUserName',
			title : '制单人名称',
			width : 100,
			align : 'right'
		}, {
			field : 'createTime',
			title : '制单时间',
			width : 100,
			align : 'right'
		}, {
			field : 'auditUserId',
			title : '审核人ID',
			width : 100,
			align : 'right'
		}, {
			field : 'auditUserName',
			title : '审核人名称',
			width : 100,
			align : 'right'
		}, {
			field : 'autditTime',
			title : '审核时间',
			width : 100,
			align : 'right'
		}, {
			field : 'financeVoucherNo',
			title : '财务凭证号',
			width : 100,
			align : 'right'
		}, {
			field : 'voucherUploadFlag',
			title : '凭证上传标记',
			width : 100,
			align : 'right',
			formatter : function(value, row, index) {
				if (value == 0) {
					return "未上传";
				} else if (value == 1) {
					return "已上传";
				} else if (value == -1) {
					return "上传反馈失败";
				} else if (value == 2) {
					return "上传反馈成功";
				}
			}
		}, {
			field : 'sapFeedbackTime',
			title : 'SAP反馈时间',
			width : 100,
			align : 'right'
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
CheckBillUtils.search = function() {
	if ($('#checkBillPage_compCode').validatebox('isValid')) {
		var compCode = $('#checkBillPage_compCode').val();
		var payType = $('#checkBillPage_payType').combobox('getValue');
		var queryParams = {
			'payCompanyCode' : compCode,
			'payMethodId' : payType
		};
		$('#checkBillPage_dg').datagrid({
			queryParams : queryParams
		});
	}
};

// 打开新建页面
CheckBillUtils.openNew = function() {
	$('#checkBillPage_listPanel').hide();
	$('#checkBillPage_editPanel').hide();
	$('#checkBillPage_newPanel').panel({
		title : '新建支付交易对账单',
		href : "checkbill/openNew"
	});
	$('#checkBillPage_newPanel').panel('open');

};

// 打开查看明细页面
CheckBillUtils.openDetail = function() {

	var selectedRow = $('#checkBillPage_dg').datagrid('getSelections');
	if (selectedRow.length == 1) {
		var billId = $("#checkBillPage_dg").datagrid("getChecked")[0].billId;

		$.ajax({
			type : "POST",
			url : "checkbill/checkLock",
			data : {
				'billId' : billId
			},
			success : function(result) {
				if (result.code == 0) {
					$('#checkBillPage_listPanel').hide();
					$('#checkBillPage_billPanel').panel({
						title : '更改支付交易对账单',
						href : "checkbill/openBill?billId=" + billId
					});
					$('#checkBillPage_billPanel').panel('open');

				} else {
					$.o2m.handleActionResult(result);
				};
			},
			error : function() {
				$.messager.confirm('提示', '未知错误', function(r) {
				});
			}
		});
	}
};

CheckBillUtils.viewDetail = function() {

	var selectedRow = $('#checkBillPage_dg').datagrid('getSelections');
	if (selectedRow.length == 1) {
		var billId = $("#checkBillPage_dg").datagrid("getChecked")[0].billId;
		$('#checkBillPage_listPanel').hide();
		$('#checkBillPage_billPanel').panel({
			title : '查看支付交易对账单',
			href : "checkbill/viewBill?billId=" + billId
		});
		$('#checkBillPage_billPanel').panel('open');

	}
	;
};

CheckBillUtils.inits();