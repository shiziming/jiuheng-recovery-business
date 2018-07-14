var applyUpdate = {};
applyUpdatePageId="#applyCoupon_updateApplyCoupon";
applyUpdate.updateApplyCouponForm=applyUpdatePageId+" #updateApplyCouponForm";
applyUpdate.orderNum=applyUpdatePageId+" #orderNumId";
applyUpdate.activityId=applyUpdatePageId+" #activityId";
applyUpdate.activityName=applyUpdatePageId+" #activityName";
applyUpdate.beginTime=applyUpdatePageId+" #beginTime";
applyUpdate.endTime=applyUpdatePageId+" #endTime";
applyUpdate.beginTimeId=applyUpdatePageId+" #beginTimeId";
applyUpdate.endTimeId=applyUpdatePageId+" #endTimeId";

applyUpdate.queryActivity=function(){
	var orderNum=$(applyUpdate.orderNum).val();
	$("#applyCoupoonMagnifier_Activity_window").window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        href: "applyCoupon/openActivityMagnifierWindow?orderNum="+orderNum,
        title: "活动查询"
    });
	$("#applyCoupoonMagnifier_Activity_window").window('open');
}

/**
 * 返回列表页面
 */
applyUpdate.returnToListPage=function(){
	$(applyCouponManage.update).panel('close');
	$(applyCouponManage.applyCoupon_list_list_panel).show();
	$(applyCouponManage.applyCoupon_list_dg).datagrid('reload')
	
}

/**
 * 修改
 */
applyUpdate.updateApplyCoupon=function(){
	$(applyUpdate.updateApplyCouponForm).form('submit', {
		url: "applyCoupon/updateApplyCoupon",
		onSubmit: function(){
			var isValid = $(this).form('validate');
			if (!isValid){
				return isValid;	
			}
			var startDate=$(applyUpdate.beginTime).textbox('getValue');
			var endDate=$(applyUpdate.endTime).textbox('getValue');
			var beginDateId=$(applyUpdate.beginTimeId).val();
			var endDateId=$(applyUpdate.endTimeId).val();
			var arys1= new Array();     
		    var arys2= new Array();
			var arys3= new Array();     
		    var arys4= new Array();
		    arys1=startDate.split('-');
		    arys2=beginDateId.split('-');
		    arys3=endDate.split('-');
		    arys4=endDateId.split('-');
		    var newTime=arys1[0]+arys1[1]+arys1[2];
		    var oldTime=arys2[0]+arys2[1]+arys2[2];
		    var newTime1=arys3[0]+arys3[1]+arys3[2];
		    var oldTime1=arys4[0]+arys4[1]+arys4[2];
		    if(newTime-newTime1>0){
		    	$.messager.alert('提示','活动开始时间不能大于活动结束时间','info');
		    	return false;
		    }
		    if(newTime-oldTime1>0){
		    	$.messager.alert('提示','活动开始时间不能大于活动预计结束时间','info');
		    	return false;
		    }
		    if(newTime1-newTime<0){
		    	$.messager.alert('提示','活动结束时间不能小于活动开始时间','info');
		    	return false;
		    }
		    if(newTime1-oldTime<0){
		    	$.messager.alert('提示','活动结束时间不能小于活动预计开始时间','info');
		    	return false;
		    }
		    if(oldTime-newTime>0){
		    	$.messager.alert('提示','活动开始时间不能小于活动预计开始时间','info');
		    	return false;
		    }
		    if(oldTime1-newTime1<0){
		    	$.messager.alert('提示','活动结束时间不能大于活动预计结束时间','info');
		    	return false;
		    }
			},success:function(data){
				var data=eval('('+data+')');
					$.messager.alert('提示',data.msg,'info');
		}
	})
}
