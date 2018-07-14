var CheckBillDetailUtils = {};

//初始化
CheckBillDetailUtils.inits = function(){
	    
	var billId = $("#checkBillDetail_billId").val();
	
	var markSuccess = function(value,row,index){
		if (    row.checkSuccessFlag == '0'    ){
			return '<a href="javascript:void(0)" class="easyui-linkbutton" onclick="CheckBillDetailUtils.markSuccess(' + index + ',' +
			+ row.detailsId + ')">标记为通过</a>';
		}else{
			return '';
		}
	};
	CheckBillDetailUtils.refreshBill(billId);
	
	$("#checkBillDetailPage_dg1").datagrid({
//		height : 500,
		url:'checkbill/getDetailList',
		method: 'post',
		rownumbers:true,
		pagination:true,
		pageSize: 20,
		pageList: [20,50,100],
		striped:true,
		queryParams:{'billId':billId },
		checkOnSelect:false,
		toolbar : "#checkBillDetailPage_tb2",
		rowStyler:function(index,row){
			if (    row.checkSuccessFlag == '0'    ){
				return 'color:red;';
			};
		},
		frozenColumns:[[
		{field:'ck',checkbox:true}
		,{field:'checkSuccessFlag',title:'是否对账成功',width:50,align:'right',formatter:function(value, row, index) {
			if(value==0){
				return '否';
			}
			if(value==1){
				return '是';
			}
			}
		}
		,{field:'operate',title:'操作',width:80,align:'right',formatter:markSuccess}
		]],
	    columns:[[
		     {field:'detailsId',title:'支付对账明细ID',width:60,hidden:true}
	        ,{field:'billId',title:'所属单据编号',width:100,align:'right',hidden:true}
	        ,{field:'payMethodId',title:'支付方式ID',width:100,hidden:true}
	        ,{field:'payMethodName',title:'支付方式',width:60}
	        ,{field:'tradeNo',title:'支付交易号',width:100}
	        ,{field:'onlineOrderId',title:'订单号',width:100,align:'right'}
	        ,{field:'onlineOrderType',title:'类型',width:30,align:'right',formatter:function(value, row, index) {return CheckBillDetailUtils.getOrderType(row.onlineOrderType);}}

	        ,{field:'orderPayTime',title:'(订单)支付时间',width:100,align:'right',styler: function (value, row, index) {
	              return 'background-color:#AAAAAA;';
	           }}
	        ,{field:'orderPayment',title:'(订单)收付金额',width:100,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); },styler: function (value, row, index) {
	              return 'background-color:#AAAAAA;';
	           }}
	        ,{field:'orderCommissionRate',title:'(订单)手续费率',width:90,align:'right',formatter:function(value, row, index) {return( value/10000 ); },styler: function (value, row, index) {
	              return 'background-color:#AAAAAA;';
	           }}
	        ,{field:'orderCommissionCharge',title:'(订单)手续费',width:80,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); },styler: function (value, row, index) {
	              return 'background-color:#AAAAAA;';
	           }}

	        ,{field:'bankPayTime',title:'(支付)支付时间',width:100,align:'right'}
	        ,{field:'bankPayment',title:'(支付)收付金额',width:100,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	        ,{field:'bankCommissionRate',title:'(支付)手续费率',width:90,align:'right',formatter:function(value, row, index) {return( value/10000 ); }}
	        ,{field:'bankCommissionCharge',title:'(支付)手续费',width:80,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	        ,{field:'commissionCharge',title:'手续费',width:100,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	        ,{field:'payTradeSerialNo',title:'支付交易流水号',width:100,align:'right'}
	        ,{field:'receiveAccountNo',title:'收付账户号',width:100,align:'right'}
	        ,{field:'bankAccountNo',title:'银行账户号',width:100,align:'right'}

	    ]],
	    onLoadSuccess:function(data){
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
	    }
	});
};

CheckBillDetailUtils.getOrderType = function(orderType){
	if(orderType==1 || orderType==2 || orderType==3){
		return "退款";
	}
	if(orderType==4){
		return "退货";
	}
	if(orderType==0){
		return "销售";
	}
};
//标记为通过
CheckBillDetailUtils.markSuccess = function(index,detailsId){
	$.ajax({
		type : "POST",
		url : "checkbill/markSuccess",
        data: {
        	'detailsId':detailsId
        }, 
		success : function(result) {
			if(result.code == 0){
				$('#checkBillDetailPage_dg1').datagrid('updateRow',{
					index: index,
					row: {
						checkSuccessFlag: '1',
						commissionCharge : result.data.commissionCharge
					}
				});
				
			}else{
				$.o2m.handleActionResult(result);
			};
		},
		error : function() {
			$.messager.confirm('提示', '未知错误',
					function(r) {}
			);
		}
	});
};

CheckBillDetailUtils.back = function(){
	var billId = $("#checkBillDetail_billId").val();
	$.ajax({
		type : "POST",
		url : "checkbill/unlock",
        data: {
        	'billId':billId
        }, 
		success : function(result) {
			if(result.code != 0){
				$.o2m.handleActionResult(result);
			};
		},
		error : function() {
			$.messager.confirm('提示', '未知错误',
					function(r) {}
			);
		}
	});
	$('#checkBillPage_billPanel').panel('close');
	$('#checkBillPage_listPanel').show();
	$('#checkBillPage_dg').datagrid('reload');
};

CheckBillDetailUtils.justBack = function(){
	$('#checkBillPage_billPanel').panel('close');
	$('#checkBillPage_listPanel').show();
	$('#checkBillPage_dg').datagrid('reload');
	
};

CheckBillDetailUtils.search = function(obj){
	$(obj).linkbutton('disable');
	var payCompanyCode_check = $("#checkBillCheck_payCompanyCode").val();
	var payMethodId_check = $("#checkBillCheck_payMethodId").combobox('getValue');
	var time1_check = $("#checkBillCheck_time1").datebox('getValue');
	var time2_check = $("#checkBillCheck_time2").datebox('getValue');
	var time3_check = $("#checkBillCheck_time3").datebox('getValue');
	
	var billId = $("#checkBillDetail_billId").val();
	
	//判断时间先后顺序
	if(time1_check > time2_check){
		$(obj).linkbutton('enable');
		$.messager.confirm('提示', '开始时间要小于结束时间',
				function(r) {
			return;
		}
		);
	}else{
		$.messager.confirm('提示', '刷新对账数据，将更新对账单头里的信息，并删除原有的对账数据',
				function(r) {
					if(r){
						var queryParams = {
								'payCompanyCode':payCompanyCode_check,
								'payMethodId':payMethodId_check,
								'startPayTime':time1_check,
								'endPayTime':time2_check,
								'arrivalDate':time3_check,
								'billId':billId
						};
						$.ajax({
							type : "POST",
							url : "checkbill/updateInfo",
					        data: queryParams, 
							success : function(result) {
								if($.o2m.handleActionResult(result)){
									$("#checkBillDetailPage_dg1").datagrid('reload');
									$("#checkBillDetail_payCompanyCode").textbox('setValue',payCompanyCode_check);
									$("#checkBillDetail_payMethodId").val(payMethodId_check);
									$("#checkBillDetail_time1").textbox('setValue',time1_check + " 00:00:00");
									$("#checkBillDetail_time2").textbox('setValue',time2_check + " 23:59:59");
									$("#checkBillDetail_arrivalDate").textbox('setValue',time3_check);
									$("#checkBillDetail_arrivalAmount").textbox('setValue',(result.data.arrivalAmount/100).toFixed(2));
									$("#checkBillDetail_commissionCharge").textbox('setValue',(result.data.commissionCharge/100).toFixed(2));
									$("#checkBillDetail_WithdrawAmount").textbox('setValue',(result.data.withdrawAmount));
								}
								$(obj).linkbutton('enable');

							},
							error : function() {
								$.messager.confirm('提示', '未知错误',
										function(r) {}
								);
							}
						});
					}else{
						$(obj).linkbutton('enable');
					}
				}
		);
	}
};


CheckBillDetailUtils.add = function(){
	var selectedRow = $('#checkBillDetailPage_dg2').datagrid('getSelections');
	var data = $("#checkBillDetailPage_dg2").datagrid("getChecked");
	if (selectedRow.length > 0) {
		//组装参数
		var obj = new Object();
		obj.billId= $("#checkBillDetail_billId").val();
		var attr = [];
		for (var i=0;i<data.length;i++){
			var element = new Object();
			element.onlineOrderId=data[i].onlineOrderId; //线上订单号
			element.payMethodId = data[i].orderPayMethodId;//支付方式
			element.orderCommissionRate = data[i].orderCommissionRate;//手续费率1 
			element.orderCommissionCharge = data[i].orderCommissionCharge;//手续费1
			
			element.tradeNo = data[i].bankTradeNo;//支付交易号（bank）
			element.commissionCharge = data[i].commissionCharge;//手续费（修改的）
			
			//修改后的手续费
			attr.push(element);
		};
		obj.details = attr;
		$.ajax({
			type : "POST",
			url : "checkbill/addDetail",
	        dataType:"json",      
	        contentType:"application/json",
	        data:JSON.stringify(obj), 
			success : function(result) {
				if(result.code == 0){
					$("#checkBillDetailPage_dg1").datagrid('reload');
					$("#checkBillDetailPage_dg2").datagrid('reload');
				}else{
					$.o2m.handleActionResult(result);
				};
			},
			error : function() {
				$.messager.confirm('提示', '未知错误',
						function(r) {;
					}
				);
			}
		});
	}
};

CheckBillDetailUtils.remove = function(){
	var selectedRow = $('#checkBillDetailPage_dg1').datagrid('getSelections');
	var data = $("#checkBillDetailPage_dg1").datagrid("getChecked");
	if (selectedRow.length > 0) {
        var ids = [];
		for (var i=0;i<data.length;i++){
	        ids.push(data[i].detailsId);
		}
		$.ajax({
			type : "POST",
			url : "checkbill/removeDetail",
			data : {
				'ids':ids
			},
			success : function(result) {
				if(result.code == 0){
					$("#checkBillDetailPage_dg1").datagrid('reload');
					$("#checkBillDetailPage_dg2").datagrid('reload');
				}else{
					$.o2m.handleActionResult(result);
				}
			},
			error : function() {
				$.messager.confirm('提示', '未知错误',
						function(r) {}
				);
			}
		});
	}
};


CheckBillDetailUtils.audit = function(){
	$.messager.confirm('确认审核', '确认信息，完成审核？',
			function(r) {
		if(r){
			//检查合法性
			if(CheckBillDetailUtils.canBeAudit()){
				var billId = $('#checkBillDetail_billId').val();
				//审核
				$.ajax({
					type : "POST",
					url : "checkbill/audit",
					data : {
						'billId':billId
					},
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$('#checkBillDetail_status').val("1");
							$("#statusNameDetail").textbox('setValue','已审核');
							$("#checkBillDetail_auditUserId").textbox('setValue',result.data.auditUserId);
							$("#checkBillDetail_auditUserName").textbox('setValue',result.data.auditUserName);
							$("#checkBillDetail_autditTime").textbox('setValue',result.data.autditTime);
							$("#checkBillDetail_financeVoucherNo").textbox('setValue',result.data.financeVoucherNo);
							
							$("#checkBillDetail_arrivalAmount").textbox('setValue',result.data.arrivalAmount/100);
							$("#checkBillDetail_commissionCharge").textbox('setValue',result.data.commissionCharge/100);
							
							
							$("#checkBillDetailPage_tb2").hide();
							$("#detail_href_audit").hide();
						}
					},
					error : function() {
						$.messager.confirm('提示', '未知错误',
								function(r) {}
						);
					}
				});
			}else{
				$.messager.confirm('提示', '尚不符合审核条件，请修改部分明细的“手续费”',
						function(r) {}
				);
			}
		}
	});
	
};
CheckBillDetailUtils.refreshBill = function(billId){
	var result="";
	$.ajax({url:"checkbill/getWithdrawAmount/"+billId ,
		async:false,
		success:function(msg){
			result=msg;
		}
	});
	$("#checkBillDetail_WithdrawAmount").val(result);

};
CheckBillDetailUtils.getBillDrawAmount = function(billId){
	var result="";
	$.ajax({url:"checkbill/getWithdrawAmount/"+billId ,
		async:false,
		success:function(msg){
			result=msg;
		}
	});
	$("#checkBillDetail_WithdrawAmount").val(result);

};
CheckBillDetailUtils.canBeAudit = function(){
	return true;
};


CheckBillDetailUtils.inits();