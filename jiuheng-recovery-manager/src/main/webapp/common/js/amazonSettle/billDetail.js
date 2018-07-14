var SettleBillDetailUtils = {};

//初始化
SettleBillDetailUtils.inits = function(){
	    
	var billId = $("#settleBillDetail_billId").val();
	
	$("#settleBillDetailPage_dg1").datagrid({
//		height : 500,
		url:'settlebill/getDetailList',
		method: 'post',
		rownumbers:true,
		pagination:true,
		pageSize: 20,
		pageList: [20,50,100],
		striped:true,
		queryParams:{'billId':billId },
		checkOnSelect:false,
		toolbar : "#settleBillDetailPage_tb2",
		frozenColumns:[[
		{field:'ck',checkbox:true}
		]],
	    columns:[[
		     {field:'detailsId',title:'结算单明细ID',width:60,hidden:true}
	        ,{field:'billId',title:'单据编号',width:100,align:'right',hidden:true}
            ,{field:'orderType',title:'订单类型',width:60,formatter:function(value, row, index) {return SettleBillDetailUtils.getOrderType(row.orderType);}}
	        ,{field:'subOrderId',title:'销售分单号',width:100}
	        ,{field:'skuId',title:'SKU内码',width:100}
	        ,{field:'skuName',title:'商品名称',width:150}
	        ,{field:'outerId',title:'外部订单号',width:100}
	        ,{field:'saleTime',title:'销售时间',width:150}
	        ,{field:'deliveryTime',title:'发货时间',width:150}
	        ,{field:'salesAmount',title:'成交金额',width:100,align:'right',formatter:function(value, row, index)  {return( (value/100).toFixed(2) ); }}
            ,{field:'settleRate',title:'佣金比例',width:100,align:'right',formatter: function (value, row, index) {return( ( value/10000 ) ); }}
	        ,{field:'advRate',title:'广告费比例',width:100,align:'right',formatter:function(value, row, index) {return( ( value/10000 ) ); }}
	        ,{field:'commission',title:'佣金',width:90,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	        ,{field:'advFee',title:'广告费',width:80,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
            ,{field:'refundMgmtFee',title:'退货管理费',width:100,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	        ,{field:'netSalesAmount',title:'销售净金额',width:100,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
	    ]],
	    onLoadSuccess:function(data){
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
	    }
	});
};

SettleBillDetailUtils.getOrderType = function(orderType){
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

SettleBillDetailUtils.back = function(){
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
	$('#settleBillPage_billPanel').panel('close');
	$('#settleBillPage_listPanel').show();
	$('#settleBillPage_dg').datagrid('reload');
};

SettleBillDetailUtils.justBack = function(){
	$('#settleBillPage_billPanel').panel('close');
	$('#settleBillPage_listPanel').show();
	$('#settleBillPage_dg').datagrid('reload');
	
};

$('#settleBillDetails_time3').datebox({
    onSelect: function(date){
        var time3 = $("#settleBillDetails_time3").datebox('getValue');
        var time1 = new Date(time3);
        var time2 = new Date(time3);
        
        time1.setDate(time1.getDate()-16);
        time2.setDate(time2.getDate()-2);
        
        $('#settleBillDetails_time1').datebox('setValue', time1.getFullYear()+"-"+(time1.getMonth()+1)+"-"+time1.getDate());
        $('#settleBillDetails_time2').datebox('setValue', time2.getFullYear()+"-"+(time2.getMonth()+1)+"-"+time2.getDate());
  	
    }
});


SettleBillDetailUtils.search = function(obj){
	$(obj).linkbutton('disable');
	var billId = $("#settleBillDetail_billId").val();
	var channelId = '82';
	var companyId = $("#settleBillDetail_companyId").val();
	var saleOrgId = $("#settleBillDetail_saleOrgId").val();
    var time1  = $("#settleBillDetails_time1").datebox('getValue');
	var time2  = $("#settleBillDetails_time2").datebox('getValue');
	var time3  = $("#settleBillDetails_time3").datebox('getValue');
	
	var now = new Date();
	var month = now.getMonth()+1
	var day = now.getDate()
	if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (day >= 0 && day <= 9) {
    	day = "0" + day;
    }
    now = now.getFullYear()+"-"+month+"-"+day;

    if (time3 > now) {
    	$(obj).linkbutton('enable');
    	$.messager.confirm('提示', '出账日期不能大于当天',
				function(r) {
			return;
		});
    }else if (time2 >= now) {
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
								'companyId':companyId,
								'saleOrgId':saleOrgId,
								'startTime':time1,
								'endTime':time2,
								'settleDate':time3
						};
//						alert(JSON.stringify(queryParams));
						$.ajax({
							type : "POST",
							url : "settlebill/updateInfo",
					        data: queryParams, 
							success : function(result) {
								if($.o2m.handleActionResult(result)){
									$("#settleBillDetailPage_dg1").datagrid('reload');
									$("#settleBillDetail_time1").textbox('setValue',time1 + " 00:00:00");
									$("#settleBillDetail_time2").textbox('setValue',time2 + " 23:59:59");
									$("#settleBillDetail_salesAmountSum").textbox('setValue',(result.data.salesAmountSum/100).toFixed(2));
									$("#settleBillDetail_commissionSum").textbox('setValue',(result.data.commissionSum/100).toFixed(2));
									$("#settleBillDetail_advFeeSum").textbox('setValue',(result.data.advFeeSum/100).toFixed(2));
									$("#settleBillDetail_refundMgmtFeeSum").textbox('setValue',(result.data.refundMgmtFeeSum/100).toFixed(2));
									$("#settleBillDetail_netSalesAmountSum").textbox('setValue',(result.data.netSalesAmountSum/100).toFixed(2));
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

SettleBillDetailUtils.remove = function(){
	var selectedRow = $('#settleBillDetailPage_dg1').datagrid('getSelections');
	var data = $("#settleBillDetailPage_dg1").datagrid("getChecked");
	if (selectedRow.length > 0) {
        var ids = [];
		for (var i=0;i<data.length;i++){
	        ids.push(data[i].detailsId);
		}
		$.ajax({
			type : "POST",
			url : "settlebill/removeDetail",
			data : {
				'ids':ids
			},
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$("#settleBillDetailPage_dg1").datagrid('reload');
					$("#settleBillDetailPage_dg2").datagrid('reload');
					$("#settleBillDetail_salesAmountSum").textbox('setValue',(result.data.salesAmountSum/100).toFixed(2));
					$("#settleBillDetail_commissionSum").textbox('setValue',(result.data.commissionSum/100).toFixed(2));
					$("#settleBillDetail_advFeeSum").textbox('setValue',(result.data.advFeeSum/100).toFixed(2));
					$("#settleBillDetail_refundMgmtFeeSum").textbox('setValue',(result.data.refundMgmtFeeSum/100).toFixed(2));
					$("#settleBillDetail_netSalesAmountSum").textbox('setValue',(result.data.netSalesAmountSum/100).toFixed(2));
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


SettleBillDetailUtils.audit = function(){
	$.messager.confirm('确认审核', '确认信息，完成审核？',
			function(r) {
		if(r){
			//检查合法性
			if(SettleBillDetailUtils.canBeAudit()){
				var billId = $('#settleBillDetail_billId').val();
				var channelId = '82';
				var companyId = $('#settleBillDetail_companyId').val();
				var saleOrgId = $('#settleBillDetail_saleOrgId').val();
				var time1  = $("#settleBillDetail_time1").datebox('getValue');
				//审核
				$.ajax({
					type : "POST",
					url : "settlebill/audit",
					data : {
						'billId':billId,
						'channelId':channelId,
						'companyId':companyId,
						'saleOrgId':saleOrgId,
						'startTime':time1
					},
					success : function(result) {
						if($.o2m.handleActionResult(result)){
							$('#settleBillDetail_status').val("1");
							$("#statusNameDetail").textbox('setValue','已审核');
							$("#settleBillDetail_auditUserId").textbox('setValue',result.data.auditUserId);
							$("#settleBillDetail_auditUserName").textbox('setValue',result.data.auditUserName);
							$("#settleBillDetail_autditTime").textbox('setValue',result.data.autditTime);
							
							$("#settleBillDetailPage_tb2").hide();
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
				$.messager.confirm('提示', '尚不符合审核条件，请检查',
						function(r) {}
				);
			}
		}
	});
	
};


SettleBillDetailUtils.canBeAudit = function(){
	return true;
};

//导出按钮
SettleBillDetailUtils.exportExcel = function(){
var billId = $("#settleBillDetail_billId").val();	
    alert(billId);
	window.open("settlebill/exportExcel?billId=" + billId);
};

SettleBillDetailUtils.inits();