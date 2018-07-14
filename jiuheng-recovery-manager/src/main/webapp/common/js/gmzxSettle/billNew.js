var GmzxSettleBillNewUtils = {};

//初始化
GmzxSettleBillNewUtils.inits = function(){

};


//新增
GmzxSettleBillNewUtils.addBill = function(obj){
	if($("#gmzxSettleBillCheckPage_form").form('validate')){
		$(obj).linkbutton('disable');
		var channelId = '83';
		var popShopId = $("#gmzxSettleBillNew_popShopId").combobox('getValue');
		var time1 = $("#gmzxSettleBillNew_time1").datebox('getValue');
		var time2 = $("#gmzxSettleBillNew_time2").datebox('getValue');
		var queryParams = {
				'channelId':channelId,
				'popShopId':popShopId,
				'startTime':time1,
				'endTime':time2
		};
		
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
        if (time2 >= now) {
        	$(obj).linkbutton('enable');
        	$.messager.confirm('提示', '结算结束日期不能大于等于当天',
					function(r) {
				return;
			})
        }else if(time1 > time2){
			$(obj).linkbutton('enable');
			$.messager.confirm('提示', '开始时间要小于结束时间',
					function(r) {
				return;
			}
			);
		}else{
			$.ajax({
				type : "POST",
				url : "gmzxSettleBill/newSettleBill",
				data : queryParams,
				success : function(result) {
					if ($.o2m.handleActionResult(result)) {
						
						$('#gmzxSettleBillPage_newPanel').panel('close');
						$('#gmzxSettleBillPage_billPanel').panel({
							title:'结算对账单', 
							href:"gmzxSettleBill/openBill?billId=" + result.data
						});
						$('#gmzxSettleBillPage_billPanel').panel('open');

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
GmzxSettleBillNewUtils.back = function(){
	$('#gmzxSettleBillPage_newPanel').panel('close');
	$('#gmzxSettleBillPage_listPanel').show();
	$('#gmzxSettleBillPage_dg').datagrid('reload');

};


GmzxSettleBillNewUtils.inits();