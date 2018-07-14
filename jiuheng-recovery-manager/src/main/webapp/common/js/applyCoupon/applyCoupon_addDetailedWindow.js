var applyCoupon_addss = {};
applyCoupon_add_pageId1 = "#applyCoupon_Add";
applyCoupon_addss.applyCoupondg = applyCoupon_add_pageId1+" #applyCoupondg";
applyCoupon_addss.billId1 = applyCoupon_add_pageId1+" #billId1";
applyCoupon_addss.tbId1 = applyCoupon_add_pageId1+" #tb1";
applyCoupon_addss.salAgencyCodeId1=applyCoupon_add_pageId1+" #salAgencyCode1";
applyCoupon_addss.orderNum1=applyCoupon_add_pageId1+" #orderNum1";
applyCoupon_addss.but=applyCoupon_add_pageId1+" #but";
/**
 * 页面初始化函数
 */
applyCoupon_addss.inits = function() {
	$(applyCoupon_addss.applyCoupondg).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		checkOnSelect: true,
		onDblClickRow : function(index,row){
				$(applyCoupon_addss.applyCoupondg).datagrid('endEdit',index);
				$(applyCoupon_addss.applyCoupondg).datagrid('beginEdit',index);
		},
		columns : [ [ {
			field : 'cb',
			width : 10,
			checkbox : true
		}, {
			field : 'getsInfo',
			title : '获取优惠券',
			align:'center',
			width : 70,
			formatter:function(value,row,index){
				return  '<a href="#" onclick="applyCoupon_addss.getSkuInfo(this);">查询</a>';
			}
		}, {
			field : 'couponType',
			title : '优惠券类型',
			align:'center',
			hidden:true,
			width : 50
		}, {
			field : 'couponName',
			title : '优惠券名称',
			align:'center',
			width : 50
		}, {
			field : 'couponNum',
			title : '优惠券数量',
			align:'center',
			width : 50,
			editor:{type:'textbox',options:{required:true}}
		},{
			field : 'couponPar',
			title : '优惠券面值',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		}, {
			field : 'havefunBegin',
			title : '有效期开始',
			align:'center',
			width : 100,
			editor:{type:'datebox',options:{required:true}}
		}, {
			field : 'havefunEnd',
			title : '有效期结束',
			align:'center',
			width : 100,
			editor:{type:'datebox',options:{required:true}}
		}, {
			field : 'pertitleLimits',
			title : '每人总限制值',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		}, {
			field : 'titleLimits',
			title : '总限制值',
			align:'center',
			width : 100,
			editor:{type:'textbox',options:{required:true}}
		}, {
			field : 'funBegin',
			title : '有效期开始',
			align:'center',
			width : 100,
			hidden:true
		}, {
			field : 'funEnd',
			title : '有效期结束',
			align:'center',
			width : 100,
			hidden:true
		}] ],
		toolbar : applyCoupon_addss.tbId1
	});
};

applyCoupon_addss.addRow = function() {
		$(applyCoupon_addss.applyCoupondg).datagrid('appendRow', {couponNum:0,couponPar:0,titleLimits:0,pertitleLimits:0});
	
}

applyCoupon_addss.delRow=function(){
	var rowNums = $(applyCoupon_addss.applyCoupondg).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(applyCoupon_addss.applyCoupondg).datagrid('deleteRow',rowNums[i]-1);
	}
	$(applyCoupon_addss.applyCoupondg).datagrid('clearChecked');
}

applyCoupon_addss.back=function(){
	$(applyCoupon_detailed.add_panel).panel('close');
	$(applyCoupon_detailed.applyCoupon_list_detailed_form).show();
	$(applyCoupon_detailed.dgId).datagrid('reload')
}

applyCoupon_addss.getSkuInfo=function(obj){
	var i =$(obj).parents('tr').attr('datagrid-row-index');
	$('#couponMagnifier').window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        method:'post',
        href: "applyCoupon/openCouponMagnifierWindow?i="+i,
        title: "全部优惠券"
    });
	$('#couponMagnifier').window('open');
}


applyCoupon_addss.saveNew=function(){
	$(applyCoupon_addss.applyCoupondg).datagrid('acceptChanges');
	var materials = $(applyCoupon_addss.applyCoupondg).datagrid('getRows');
	for (var i = 0; i < materials.length; i++) {
		if ($.o2m.isEmpty(materials[i].couponName)) {
			$.messager.alert('请核实数据', '第' + (i + 1) + '行数据未添加优惠券！', 'warning');
			return false;
		}
		if ($.o2m.isEmpty(materials[i].couponNum)) {
			if(materials[i].couponNum!=0){
			$.messager.alert('请核实数据', '第' + (i + 1) + '行数据未添加优惠券数量！', 'warning');
			return false;
			}
		}
		if ($.o2m.isEmpty(materials[i].couponPar)) {
			if(materials[i].couponPar!=0){
			$.messager.alert('请核实优惠券面值', '第' + (i + 1) + '行数据未添加优惠券面值！', 'warning');
			return false;
			}
		}
		if ($.o2m.isEmpty(materials[i].titleLimits)) {
			if(materials[i].titleLimits!=0){
			$.messager.alert('请核实优惠券总限制值', '第' + (i + 1) + '行数据未添加总限制值！', 'warning');
			return false;
			}
		}
		if ($.o2m.isEmpty(materials[i].pertitleLimits)) {
			if(materials[i].pertitleLimits!=0){
			$.messager.alert('请核实优惠券每人总限制值', '第' + (i + 1) + '行数据未添加每人总限制值！', 'warning');
			return false;
			}
		}
		var re = /^[1-9]+[0-9]*]*$/;
		if (!re.test(materials[i].pertitleLimits/materials[i].couponPar)){
			$.messager.alert('请核实优惠券每人总限制值', '第' + (i + 1) + '行每人总限制值必须是优惠券面值整数倍！', 'warning');
			return false;
		}
		if (!re.test(materials[i].titleLimits/materials[i].couponPar)){
			$.messager.alert('请核实优惠券总限制值', '第' + (i + 1) + '行总限制值必须是优惠券面值整数倍！', 'warning');
			return false;
		}
		if (parseInt(materials[i].titleLimits)<parseInt(materials[i].pertitleLimits)){
			$.messager.alert('请核实优惠券总限制值', '第' + (i + 1) + '行总限制值必须大于等于每人总限制值！', 'warning');
			return false;
		}
		var startDate=materials[i].havefunBegin;
		var startDateId=materials[i].funBegin;
		var endDate=materials[i].havefunEnd;
		var endDateId=materials[i].funEnd;
		var arys1= new Array();     
	    var arys2= new Array();
		var arys3= new Array();     
	    var arys4= new Array();
	    arys1=startDate.split('-');
	    arys2=startDateId.split('-');
	    arys3=endDate.split('-');
	    arys4=endDateId.split('-');
	    var newTime=arys1[0]+arys1[1]+arys1[2];/*修改后开始时间*/
	    var oldTime=arys2[0]+arys2[1]+arys2[2];/*优惠券有效开始时间*/
	    var newTime1=arys3[0]+arys3[1]+arys3[2];/*修改后结束时间*/
	    var oldTime1=arys4[0]+arys4[1]+arys4[2];/*优惠券有效结束时间*/
	    if(newTime-newTime1>0){
	    	$.messager.alert('提示','第' + (i + 1) + '行有效期开始时间不能大于效期结束时间','info');
	    	return false;
	    }
	    if(newTime-oldTime1>0){
	    	$.messager.alert('提示','第' + (i + 1) + '行有效期开始时间不能大于预计有效期结束时间','info');
	    	return false;
	    }
	    if(newTime1-newTime<0){
	    	$.messager.alert('提示','第' + (i + 1) + '行有效期结束时间不能小于有效期开始时间','info');
	    	return false;
	    }
	    if(newTime1-oldTime<0){
	    	$.messager.alert('提示','第' + (i + 1) + '行有效期结束时间不能小于预计有效期开始时间','info');
	    	return false;
	    }
	    if(oldTime-newTime>0){
	    	$.messager.alert('提示','第' + (i + 1) + '行有效期开始时间不能小于有效期预计开始时间','info');
	    	return false;
	    }
	    if(oldTime1-newTime1<0){
	    	$.messager.alert('提示','第' + (i + 1) + '行有效期结束时间不能大于有效期预计结束时间','info');
	    	return false;
	    }
	};
	var saveApplyCoupon={};
	saveApplyCoupon.coupons=materials;
	var orderNum=$(applyCoupon_addss.orderNum1).val();
	$.ajax({
		type : "POST",
		url : "applyCoupon/addCoupon?orderNum="+orderNum,
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(saveApplyCoupon),
		success : function(data) {
			if(data.code==0){
				$.messager.alert('提示',data.msg,'success');
			}else if(data.code==1){
				$.messager.alert('警告',data.msg,'info');
			}
		}
	});

}
applyCoupon_addss.inits();

