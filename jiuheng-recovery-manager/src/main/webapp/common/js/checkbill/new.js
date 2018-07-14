var CheckBillNewUtils = {};

//初始化
CheckBillNewUtils.inits = function(){

};

//新增
CheckBillNewUtils.addBill = function(obj){
	if($("#checkBillCheckPage_form").form('validate')){
		$(obj).linkbutton('disable');
		var payCompCode = $("#checkBillNew_payCompCode").val();
		var payType = $("#checkBillNew_payType").combobox('getValue');
		var time1 = $("#checkBillNew_time1").datebox('getValue');
		var time2 = $("#checkBillNew_time2").datebox('getValue');
		var time3 = $("#checkBillNew_time3").datebox('getValue');

		var queryParams = {
				'payCompanyCode':payCompCode,
				'payMethodId':payType,
				'startPayTime':time1,
				'endPayTime':time2,
				'arrivalDate':time3
		};

		//判断时间先后顺序
		if(time1 > time2){
			$(obj).linkbutton('enable');
			$.messager.confirm('提示', '开始时间要小于结束时间',
					function(r) {
				return;
			}
			);
		}else{
			$.ajax({
				type : "POST",
				url : "checkbill/newCheckBill",
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
					$(obj).linkbutton('enable');
				},
				error : function() {
					$(obj).linkbutton('enable');
					$.messager.confirm('提示', '未知错误',
							function(r) {}
					);
				}
			});

		}
	}
};


//返回
CheckBillNewUtils.back = function(){
	$('#checkBillPage_newPanel').panel('close');
	$('#checkBillPage_listPanel').show();
	$('#checkBillPage_dg').datagrid('reload');

};


CheckBillNewUtils.inits();