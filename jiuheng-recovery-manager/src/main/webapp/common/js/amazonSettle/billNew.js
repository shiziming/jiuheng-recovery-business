var SettleBillNewUtils = {};

//初始化
SettleBillNewUtils.inits = function(){

};


$('#settleBillNew_time3').datebox({
    onSelect: function(date){
        var time3 = $("#settleBillNew_time3").datebox('getValue');
        var time1 = new Date(time3);
        var time2 = new Date(time3);
        
        time1.setDate(time1.getDate()-16);
        time2.setDate(time2.getDate()-2);
        
        $('#settleBillNew_time1').datebox('setValue', time1.getFullYear()+"-"+(time1.getMonth()+1)+"-"+time1.getDate());
        $('#settleBillNew_time2').datebox('setValue', time2.getFullYear()+"-"+(time2.getMonth()+1)+"-"+time2.getDate());
  	
    }
});


//新增
SettleBillNewUtils.addBill = function(obj){
	if($("#settleBillCheckPage_form").form('validate')){
		$(obj).linkbutton('disable');
		var channelId = '82';
		var companyId = $("#settleBillNew_companyId").val();
		var saleOrgId = $("#settleBillNew_saleOrgId").val();
		var time1 = $("#settleBillNew_time1").datebox('getValue');
		var time2 = $("#settleBillNew_time2").datebox('getValue');
		var time3 = $("#settleBillNew_time3").datebox('getValue');

		var queryParams = {
				'channelId':channelId,
				'companyId':companyId,
				'saleOrgId':saleOrgId,
				'startTime':time1,
				'endTime':time2,
				'settleDate':time3
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
        if (time3 > now) {
        	$(obj).linkbutton('enable');
        	$.messager.confirm('提示', '出账日期不能大于当天',
					function(r) {
				return;
			})
        }else if (time2 >= now) {
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
				url : "settlebill/newSettleBill",
				data : queryParams,
				success : function(result) {
					if ($.o2m.handleActionResult(result)) {
						
						$('#settleBillPage_newPanel').panel('close');
						$('#settleBillPage_billPanel').panel({
							title:'结算对账单', 
							href:"settlebill/openBill?billId=" + result.data
						});
						$('#settleBillPage_billPanel').panel('open');

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
SettleBillNewUtils.back = function(){
	$('#settleBillPage_newPanel').panel('close');
	$('#settleBillPage_listPanel').show();
	$('#settleBillPage_dg').datagrid('reload');

};


SettleBillNewUtils.inits();