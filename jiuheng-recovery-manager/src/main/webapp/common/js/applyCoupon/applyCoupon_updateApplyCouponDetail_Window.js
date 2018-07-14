var applyCoupon_update = {};

applyCoupon_update_pageId = "#applyCoupon_Update_Page";
applyCoupon_update.dgId = applyCoupon_update_pageId+ " #dg";
applyCoupon_update.billId = applyCoupon_update_pageId+" #billId";
applyCoupon_update.tbId = applyCoupon_update_pageId+" #tb";
applyCoupon_update.but=applyCoupon_update_pageId+" #but";
applyCoupon_update.couponType=applyCoupon_update_pageId+" #couponType";
applyCoupon_update.couponName=applyCoupon_update_pageId+" #couponName";
applyCoupon_update.havefunBegin=applyCoupon_update_pageId+" #havefunBegin";
applyCoupon_update.havefunBeginId=applyCoupon_update_pageId+" #havefunBeginId";
applyCoupon_update.havefunEnd=applyCoupon_update_pageId+" #havefunEnd";
applyCoupon_update.havefunEndId=applyCoupon_update_pageId+" #havefunEndId";
applyCoupon_update.updateForm=applyCoupon_update_pageId+" #updateForm";
applyCoupon_update.couponPar=applyCoupon_update_pageId+" #couponPar";
applyCoupon_update.pertitleLimits=applyCoupon_update_pageId+" #pertitleLimits";
applyCoupon_update.titleLimits=applyCoupon_update_pageId+" #titleLimits";
applyCoupon_update.queryActivity=function(){
	$("#applyCouponMagnifier").window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        href: "applyCoupon/openCouponMagnifierWindow",
        title: "活动查询"
    });
	$('#applyCouponMagnifier').window('open');
}

applyCoupon_update.back=function(){
	$(applyCoupon_detailed.add_panel).panel('close');
	$(applyCoupon_detailed.applyCoupon_list_detailed_form).show();
	$(applyCoupon_detailed.dgId).datagrid('reload')
	
}


applyCoupon_update.save=function(){
	$(applyCoupon_update.updateForm).form('submit', {
		url: "applyCoupon/updateApplyCouponDetail",
		onSubmit: function(){
			var isValid = $(this).form('validate');
			if (!isValid){
				return isValid;	
			}
			
			var re = /^[1-9]+[0-9]*]*$/;
			var couponPar=$(applyCoupon_update.couponPar).textbox('getValue');
			var pertitleLimits=$(applyCoupon_update.pertitleLimits).textbox('getValue');
			var titleLimits=$(applyCoupon_update.titleLimits).textbox('getValue');
			if (!re.test(pertitleLimits/couponPar)){
				$.messager.alert('请核实优惠券每人总限制值', '每人总限制值必须是优惠券面值整数倍！', 'warning');
				return false;
			}
			if (!re.test(titleLimits/couponPar)){
				$.messager.alert('请核实优惠券总限制值', '总限制值必须是优惠券面值整数倍！', 'warning');
				return false;
			}
			if (titleLimits<pertitleLimits){
				$.messager.alert('请核实优惠券总限制值', '总限制值必须大于等于每人总限制值！', 'warning');
				return false;
			}
			},success:function(data){
				var data=eval('('+data+')');
					$.messager.alert('提示',data.msg,'info');
		}
	})
}

