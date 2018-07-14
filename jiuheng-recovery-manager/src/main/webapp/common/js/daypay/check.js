var check = {};

check.pageId = '#check_index';
check.checkpanel = check.pageId + " #checkpanel";
check.detaildataGrid = check.pageId + ' #detail_dataGrid';
check.historydataGrid = check.pageId + ' #history_dataGrid';
/**
 * 页面初始化函数
 */
check.inits = function() {

};

$("#retBill").combobox({onChange: function () {
	var status = $('#retBill').combobox("getValue");
	  if(status=="true"){
		  $("#td1").show();  
		  $("#td2").show();
		  $("#td3").hide();  
		  $("#td4").hide();
	  }else if(status=="false"){
		  $("#td1").hide();  
		  $("#td2").hide();
		  $("#td3").show(); 
		  $("#td4").show();  
	  }
}
});
//审核通过
check.Pass = function(type){
	var financialCheckStatus={};
	financialCheckStatus.orderId=$(returnmoney.checkpanel+" #returnParOrderId").text();
	financialCheckStatus.invoiceReturned = $(returnmoney.checkpanel + " #retBill").combobox('getValue');
	financialCheckStatus.type=type;
	var oldBillid=$(returnmoney.checkpanel + " #oldBillid").val();
	var despReason=$(returnmoney.checkpanel + " #despReason").val();
	var returnId=$(returnmoney.checkpanel + " #returnId").val();
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
		url : "returnmoney/checkPass?returnId="+returnId,
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
	financialCheckStatus.orderId=$(returnmoney.checkpanel+" #returnParOrderId").text();
	financialCheckStatus.note = $(returnmoney.checkpanel + " #despMessage").val();
	$.ajax({
		type : "POST",
		url : "returnmoney/checkBack",
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
/**
 * 从Panel页面返回到列表页面
 */
check.Return= function(){
	$(returnmoney.checkpanel).panel('close');
	$(returnmoney.list_panel).show();
};
check.inits();
