var underline = {};
underline.pageId = '#underline_index';
/**
 * 页面初始化函数
 */
underline.inits = function() {
	var payCompanyId=$(underline.pageId +" #payCompanyId").text();
    var payCompanyName=returnmoney.payCompanyName(payCompanyId);
    $(underline.pageId +" #payCompanyName").html(payCompanyName);
  
    var saleCompanyId=$(underline.pageId +" #saleCompanyId").text();
    var saleCompanyName=returnmoney.saleCompanyName(saleCompanyId);
    $(underline.pageId +" #saleCompanyName").html(saleCompanyName);
   
    var shopId=$(underline.pageId +" #shopId").text();
    var shopName=returnmoney.shopName(shopId);
    $(underline.pageId +" #shopName").html(shopName);
   
    var goodId=$(underline.pageId +" #goodId").text();
    var goodName=returnmoney.goodName(goodId);
    $(underline.pageId +" #goodName").html(goodName);
    
    var paymentTypeId11=$(underline.pageId +" #paymentTypeId11").combobox('getValue');
    var bankNum=underline.bankNum(payCompanyId,paymentTypeId11);
    $("#companyAccountNo11").html(bankNum);
};


$("#paymentTypeId11").combobox({
	onChange: function () {
		 var payCompanyId=$(underline.pageId +" #payCompanyId").text();
		 var paymentTypeId=$("#paymentTypeId11").combobox('getValue');
		 var bankNum=underline.bankNum(payCompanyId,paymentTypeId);
		 $("#companyAccountNo11").html(bankNum);
	}
});

underline.bankNum = function(payCompanyId,paymentTypeId11){
	var result="";
	$.ajax({url:"returnmoney/bankNum?payCompanyId="+payCompanyId+"&paymentTypeId="+paymentTypeId11,
		async:false,
		success:function(msg){
			result=msg.msg;
		}
	}
	);
	return result;
};

underline.save11= function(){
	if(!$(returnmoney.underlinepanel).find('form').form('enableValidation').form('validate')){
		  return false;
		}
	var save11={};
	save11.orderId=$(returnmoney.underlinepanel+" #returnParOrderId").val();
	save11.paymentTypeId=$("#paymentTypeId11").combobox('getValue');
	save11.refundAmount=Math.ceil($("#refundAmount11").val()*100);
	save11.refundInfo=$("#refundInfo11").val();
	save11.companyAccountNo=$("#companyAccountNo11").text();
	if(save11.companyAccountNo==""){
	    $.messager.alert('警告', '公司账号不能为空，请重新选择支付方式代码!', 'warning');
	    return;
	}
	var returnId=$(returnmoney.underlinepanel + " #returnId").text();
	$.messager.confirm('提示','请确认已线下退款至顾客账户成功！此操作不可以逆转.',function(r){if (r){   
		$.ajax({
			type : "POST",
			url : "returnmoney/checkUnderLinePass11?returnId="+returnId,
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(save11),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$("#underline_dialog").dialog('close');
					$(returnmoney.underlinepanel).panel('close');
					$(returnmoney.dgId).datagrid('reload');
					$(returnmoney.list_panel).show();
				}else{
					$("#underline_dialog").dialog('close');
					$(returnmoney.underlinepanel).panel('close');
					$(returnmoney.dgId).datagrid('reload');
					$(returnmoney.list_panel).show();
				}
			}
		});
	}});
	
};

/**
 * 从Panel页面返回到列表页面
 */
underline.returned =function(){
	$(returnmoney.underlinepanel).panel('close');
	$(returnmoney.list_panel).show();
};
underline.inits();
