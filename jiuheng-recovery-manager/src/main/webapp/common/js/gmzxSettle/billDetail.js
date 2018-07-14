var GmzxSettleBillDetailUtils = {};

//初始化
GmzxSettleBillDetailUtils.inits = function(){
	    
	var billId = $("#gmzxSettleBillDetail_billId").val();
	
	$("#gmzxSettleBillDetailPage_dg1").datagrid({
//		height : 500,
		url:'gmzxSettleBill/getDetailList',
		method: 'post',
		rownumbers:true,
		pagination:true,
		pageSize: 20,
		pageList: [20,50,100],
		striped:true,
		queryParams:{'billId':billId },
		checkOnSelect:false,
		toolbar : "#gmzxSettleBillDetailPage_tb2",
		frozenColumns:[[
		{field:'ck',checkbox:true}
		]],
	    columns:[[
		     {field:'detailsId',title:'结算单明细ID',width:60,hidden:true}
	        ,{field:'billId',title:'单据编号',width:100,align:'right',hidden:true}
            ,{field:'orderType',title:'订单类型',width:60,formatter:function(value, row, index) {return GmzxSettleBillDetailUtils.getOrderType(row.orderType);}}
	        ,{field:'subOrderId',title:'销售分单号',width:100}
	        ,{field:'companyId',title:'销售公司代码',width:100}
	        ,{field:'saleOrgId',title:'销售组织代码',width:100}
	        ,{field:'skuId',title:'sku内码',width:100}
	        ,{field:'skuName',title:'商品名称',width:100}
	        ,{field:'outerId',title:'外部订单号',width:100}
	        ,{field:'outerSkuId',title:'sku外码',width:100}
	        ,{field:'saleTime',title:'销售时间',width:150}
	        ,{field:'deliveredTime',title:'妥投时间',width:150}
	        ,{field:'salesAmount',title:'成交金额',width:100,align:'right',formatter:function(value, row, index)  {return( (value/100).toFixed(2) ); }}
	        ,{field:'discAmountPop',title:'平台优惠金额',width:100,align:'right',formatter:function(value, row, index)  {return( (value/100).toFixed(2) ); }}
	        ,{field:'discAmountShop',title:'店铺优惠金额',width:100,align:'right',formatter:function(value, row, index)  {return( (value/100).toFixed(2) ); }}
            ,{field:'settleRate',title:'佣金比例',width:100,align:'right',formatter: function (value, row, index) {return( ( value/10000 ) ); }}
	        ,{field:'commission',title:'佣金',width:90,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	        ,{field:'netSalesAmount',title:'销售净金额',width:100,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	    ]],
	    onLoadSuccess:function(data){
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
	    }
	});
};

GmzxSettleBillDetailUtils.getOrderType = function(orderType){
	if(orderType==1 || orderType==2 || orderType==3){
		return "退款";
	}
	if(orderType==4){
		return "退货";
	}
	if(orderType==5){
		return "换货";
	}
	if(orderType==0){
		return "销售";
	}
};

GmzxSettleBillDetailUtils.back = function(){
//	var billId = $("#billId").val();
//	$.ajax({
//		type : "POST",
//		url : "checkbill/unlock",
//        data: {
//        	'billId':billId
//        }, 
//		success : function(result) {
//			if(result.code != 0){
//				$.o2m.handleActionResult(result);
//			};
//		},
//		error : function() {
//			$.messager.confirm('提示', '未知错误',
//					function(r) {}
//			);
//		}
//	});
	$('#gmzxSettleBillPage_billPanel').panel('close');
	$('#gmzxSettleBillPage_listPanel').show();
	$('#gmzxSettleBillPage_dg').datagrid('reload');
};

GmzxSettleBillDetailUtils.justBack = function(){
	$('#gmzxSettleBillPage_billPanel').panel('close');
	$('#gmzxSettleBillPage_listPanel').show();
	$('#gmzxSettleBillPage_dg').datagrid('reload');
	
};


GmzxSettleBillDetailUtils.search = function(obj){
	$(obj).linkbutton('disable');
	var billId = $("#gmzxSettleBillDetail_billId").val();
	var channelId = '83';
	var popShopId = $("#gmzxSettleBillDetail_popShopId").val();
	var time1  = $("#gmzxSettleBillDetails_time1").datebox('getValue');
	var time2  = $("#gmzxSettleBillDetails_time2").datebox('getValue');
	
	var now = new Date();
	var month = now.getMonth()+1;
	var day = now.getDate();
	if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (day >= 0 && day <= 9) {
    	day = "0" + day;
    }
    now = now.getFullYear()+"-"+month+"-"+day;

    if (time2 >= now) {
    	$(obj).linkbutton('enable');
    	$.messager.confirm('提示', '结算结束日期不能大于等于当天',
				function(r) {
			return;
		});
    }else if(time1 > time2){
		$(obj).linkbutton('enable');
		$.messager.confirm('提示', '开始时间要小于结束时间',
				function(r) {
			return;
		}
		);
	}else{
		$.messager.confirm('提示', '刷新结算数据，将更新结算单头里的信息，并删除原有的结算数据',
				function(r) {
					if(r){
						var queryParams = {
								'billId':billId,
								'channelId':channelId,
								'popShopId':popShopId,
								'startTime':time1,
								'endTime':time2
						};
//						alert(JSON.stringify(queryParams));
						$.ajax({
							type : "POST",
							url : "gmzxSettleBill/updateInfo",
					        data: queryParams, 
							success : function(result) {
								if($.o2m.handleActionResult(result)){
									$("#gmzxSettleBillDetailPage_dg1").datagrid('reload');
									$("#gmzxSettleBillDetail_time1").textbox('setValue',time1 + " 00:00:00");
									$("#gmzxSettleBillDetail_time2").textbox('setValue',time2 + " 23:59:59");
									$("#gmzxSettleBillDetail_salesAmountSum").textbox('setValue',(result.data.salesAmountSum/100).toFixed(2));
									$("#gmzxSettleBillDetail_discAmountPopSum").textbox('setValue',(result.data.discAmountPopSum/100).toFixed(2));
									$("#gmzxSettleBillDetail_commissionSum").textbox('setValue',(result.data.commissionSum/100).toFixed(2));
									$("#gmzxSettleBillDetail_netSalesAmountSum").textbox('setValue',(result.data.netSalesAmountSum/100).toFixed(2));
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

GmzxSettleBillDetailUtils.remove = function(){
	var selectedRow = $('#gmzxSettleBillDetailPage_dg1').datagrid('getSelections');
	var data = $("#gmzxSettleBillDetailPage_dg1").datagrid("getChecked");
	if (selectedRow.length > 0) {
        var ids = [];
		for (var i=0;i<data.length;i++){
	        ids.push(data[i].detailsId);
		}
		$.ajax({
			type : "POST",
			url : "gmzxSettleBill/removeDetail",
			data : {
				'ids':ids
			},
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$("#gmzxSettleBillDetailPage_dg1").datagrid('reload');
					$("#gmzxSettleBillDetailPage_dg2").datagrid('reload');
					$("#gmzxSettleBillDetail_salesAmountSum").textbox('setValue',(result.data.salesAmountSum/100).toFixed(2));
					$("#gmzxSettleBillDetail_discAmountPopSum").textbox('setValue',(result.data.discAmountPopSum/100).toFixed(2));
					$("#gmzxSettleBillDetail_commissionSum").textbox('setValue',(result.data.commissionSum/100).toFixed(2));
					$("#gmzxSettleBillDetail_netSalesAmountSum").textbox('setValue',(result.data.netSalesAmountSum/100).toFixed(2));
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


GmzxSettleBillDetailUtils.audit = function(){
	$.messager.confirm('确认审核', '确认信息，完成审核？',
			function(r) {
		if(r){
			//检查合法性
			if(GmzxSettleBillDetailUtils.canBeAudit()){
				var billId = $('#gmzxSettleBillDetail_billId').val();
				var channelId = '83';
				var popShopId = $('#gmzxSettleBillDetail_popShopId').val();
				var time1  = $("#gmzxSettleBillDetail_time1").datebox('getValue');
				//审核
				$.ajax({
					type : "POST",
					url : "gmzxSettleBill/audit",
					data : {
						'billId':billId,
						'channelId':channelId,
						'popShopId':popShopId,
						'startTime':time1
					},
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$('#gmzxSettleBillDetail_status').val("1");
							$("#gmzxStatusNameDetail").textbox('setValue','已审核');
							$("#gmzxSettleBillDetail_auditUserId").textbox('setValue',result.data.auditUserId);
							$("#gmzxSettleBillDetail_auditUserName").textbox('setValue',result.data.auditUserName);
							$("#gmzxSettleBillDetail_autditTime").textbox('setValue',result.data.autditTime);
							
							$("#gmzxSettleBillDetailPage_tb2").hide();
							$("#gmzx_detail_href_audit").hide();
						}
					},
					error : function() {
						$.messager.confirm('提示', '未知错误',
								function(r) {}
						);
					}
				});
			}else{
				$.messager.confirm('提示', '尚不符合审核条件，请检查',
						function(r) {}
				);
			}
		}
	});
	
};


GmzxSettleBillDetailUtils.canBeAudit = function(){
	return true;
};

//导出按钮
GmzxSettleBillDetailUtils.exportExcel = function(){
var billId = $("#gmzxSettleBillDetail_billId").val();	
    alert(billId);
	window.open("gmzxSettleBill/exportExcel?billId=" + billId);
};

GmzxSettleBillDetailUtils.inits();