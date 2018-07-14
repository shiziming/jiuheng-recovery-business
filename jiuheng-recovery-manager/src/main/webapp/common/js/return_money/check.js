var check = {};

check.pageId = '#check_index';
check.checkpanel = check.pageId + ' #checkpanel';
check.detaildataGrid = check.pageId + ' #detail_dataGrid';
check.historydataGrid = check.pageId + ' #history_dataGrid';
/**
 * 页面初始化函数
 */
check.inits = function() {
    var payCompanyId=$(check.pageId +" #payCompanyId").text();
    var payCompanyName=returnmoney.payCompanyName(payCompanyId);
    $(check.pageId +" #payCompanyName").html(payCompanyName);
  
    var goodId=$(check.pageId +" #goodId").text();
    var goodName=returnmoney.goodName(goodId);
    $(check.pageId +" #goodName").html(goodName);
    
    var saleCompanyId=$(check.pageId +" #saleCompanyId").text();
    var saleCompanyName=returnmoney.saleCompanyName(saleCompanyId);
    $(check.pageId +" #saleCompanyName").html(saleCompanyName);
   
    var shopId=$(check.pageId +" #shopId").text();
    var shopName=returnmoney.shopName(shopId);
    $(check.pageId +" #shopName").html(shopName);
   
};

$(check.pageId+" #retBill1").combobox({onChange: function () {
	var status = $(check.pageId +' #retBill1').combobox("getValue");
	  if(status=="true"){
		  $(check.pageId +" #td1").show();  
		  $(check.pageId +" #td2").show();
		  $(check.pageId +" #td3").hide();  
		  $(check.pageId +" #td4").hide();
	  }else if(status=="false"){
		  $(check.pageId +" #td1").hide();  
		  $(check.pageId +" #td2").hide();
		  $(check.pageId +" #td3").show(); 
		  $(check.pageId +" #td4").show();  
	  }
}
});
//审核通过  配送会计
check.Pass1 = function(){
	var financialCheckStatus={};
	financialCheckStatus.orderId=$(returnmoney.checkpanel+" #returnParOrderId").val();
	financialCheckStatus.invoiceReturned = $(returnmoney.checkpanel + " #retBill1").combobox('getValue');
	var oldBillid=$(returnmoney.checkpanel + " #oldBillid1").val();
	var despReason=$(returnmoney.checkpanel + " #despReason1").val();
	var returnId=$(returnmoney.checkpanel + " #returnId").text();
	if(financialCheckStatus.invoiceReturned=="true"){
		if(oldBillid==""){
			$.messager.alert('警告', '原发票号不能为空!', 'warning');
			return false;
		}else{
			financialCheckStatus.invoiceInfo = oldBillid;
		}
	}
	if(financialCheckStatus.invoiceReturned=="false"){
	   if(despReason==""){
		  $.messager.alert('警告', '备注原因不能为空!', 'warning');
		  return false;
	   }else{
		financialCheckStatus.invoiceInfo = despReason;
	   }
	}
	financialCheckStatus.note=$(returnmoney.checkpanel + " #despMessage").val();
	$.ajax({
		type : "POST",
		url : "returnmoney/checkPass1?returnId="+returnId,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(financialCheckStatus),
		success : function(result) {
			if($.o2m.handleActionResult(result)){
				$(returnmoney.checkpanel).panel('close');
				$(returnmoney.dgId).datagrid('reload');
				$(returnmoney.list_panel).show();
			}
		}
	}); 
};
//资金主管审核通过
check.Pass2 = function(){
	var financialCheckStatus={};
	financialCheckStatus.orderId=$(returnmoney.checkpanel+" #returnParOrderId").val();
	var oldBillid=$(returnmoney.checkpanel + " #oldBillid2").text();
	var despReason=$(returnmoney.checkpanel + " #despReason2").text();
	var returnId=$(returnmoney.checkpanel + " #returnId").text();
	financialCheckStatus.note=$(returnmoney.checkpanel + " #despMessage").val();
	$.ajax({
		type : "POST",
		url : "returnmoney/checkPass2?returnId="+returnId,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(financialCheckStatus),
		success : function(result) {
			if($.o2m.handleActionResult(result)){
				$(returnmoney.checkpanel).panel('close');
				$(returnmoney.dgId).datagrid('reload');
				$(returnmoney.list_panel).show();
			}
		}
	}); 
};
//审核驳回
check.Back = function(){
	var financialCheckStatus={};
	financialCheckStatus.orderId=$(returnmoney.checkpanel+" #returnParOrderId").val();
	financialCheckStatus.note = $(returnmoney.checkpanel + " #despMessage").val();
	var returnId=$(returnmoney.checkpanel + " #returnId").text();
	$.ajax({
		type : "POST",
		url : "returnmoney/checkBack?returnId="+returnId,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(financialCheckStatus),
		success : function(result) {
			if($.o2m.handleActionResult(result)){
				$(returnmoney.checkpanel).panel('close');
				$(returnmoney.dgId).datagrid('reload');
				$(returnmoney.list_panel).show();
			}
		}
	}); 
};
//线下退款确认
check.save8= function(){
	if(!$("#check_dialog").find('form').form('enableValidation').form('validate')){
		  return false;
		}
	var save8={};
	save8.orderId=$(returnmoney.checkpanel+" #returnParOrderId").val();
	var oldBillid=$(returnmoney.checkpanel + " #oldBillid").val();
	var despReason=$(returnmoney.checkpanel + " #despReason").val();
	var returnId=$(returnmoney.checkpanel + " #returnId").text();
	save8.note=$(returnmoney.checkpanel + " #despMessage").val();
	var offlineRefund={};
	offlineRefund.paymentTypeId=$("#paymentTypeId8").combobox('getValue');
	offlineRefund.refundAmount=Math.ceil(($("#refundAmount8").val()*1000)/10);
	offlineRefund.refundInfo=$("#refundInfo8").val();
	offlineRefund.companyAccountNo=$("#companyAccountNo8").text();
	if(offlineRefund.companyAccountNo==""){
	    $.messager.alert('警告', '公司账号不能为空，请重新选择支付方式代码!', 'warning');
	    return;
	}
	save8.offlineRefund=offlineRefund;
	$.messager.confirm('提示','请确认已线下退款至顾客账户成功！此操作不可以逆转.',function(r){if (r){   
		$.ajax({
			type : "POST",
			url : "returnmoney/checkUnderLinePass8?returnId="+returnId,
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(save8),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$("#check_dialog").dialog('close');
					$(returnmoney.checkpanel).panel('close');
					$(returnmoney.dgId).datagrid('reload');
					$(returnmoney.list_panel).show();
				}else{
					$("#check_dialog").dialog('close');
					$(returnmoney.checkpanel).panel('close');
					$(returnmoney.dgId).datagrid('reload');
					$(returnmoney.list_panel).show();
				}
				
			}
		}); 
	}});
};

check.bankNum = function(payCompanyId,paymentTypeId){
	var result="";
	$.ajax({url:"returnmoney/bankNum?payCompanyId="+payCompanyId+"&paymentTypeId="+paymentTypeId,
		async:false,
		success:function(msg){
			result=msg.msg;
		}
	}
	);
	return result;
};

	//线下已退款
	check.returned8 = function(){
		$("#check_checkFrom1").form('clear');
		$("#check_checkFrom2").form('clear');
		$("#paymentTypeId8").combobox('setValue',12);
		$("#paymentTypeId8").combobox('setText','微信');
		 var payCompanyId=$(check.pageId +" #payCompanyId").text();
		 var paymentTypeId=$("#paymentTypeId8").combobox('getValue');
		 var bankNum=check.bankNum(payCompanyId,paymentTypeId);
		 $("#companyAccountNo8").html(bankNum);
		 $("#paymentTypeId8").combobox({
				onChange: function () {
					 var payCompanyId=$(check.pageId +" #payCompanyId").text();
					 var paymentTypeId=$("#paymentTypeId8").combobox('getValue');
					 var bankNum=check.bankNum(payCompanyId,paymentTypeId);
					 $("#companyAccountNo8").html(bankNum);
				}
			});
		$("#check_dialog").dialog('open');     
	};
/**
 * 从Panel页面返回到列表页面
 */
check.Return= function(){
	$(returnmoney.checkpanel).panel('close');
	$(returnmoney.list_panel).show();
};

check.returned =function(){
	$("#check_dialog").dialog('close');
	/*$(returnmoney.checkpanel).panel('open');*/
};
check.inits();
