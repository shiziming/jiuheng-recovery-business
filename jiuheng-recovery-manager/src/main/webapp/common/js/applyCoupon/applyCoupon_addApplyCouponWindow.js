var applyCoupon_add = {};
applyCoupon_add_pageId = "#applyCoupon_Add_Page";
applyCoupon_add.dgId = applyCoupon_add_pageId+ " #dg";
applyCoupon_add.billId = applyCoupon_add_pageId+" #billId";
applyCoupon_add.tbId = applyCoupon_add_pageId+" #tb";
applyCoupon_add.activityId=applyCoupon_add_pageId+" #activityId";
applyCoupon_add.activityName=applyCoupon_add_pageId+" #activityName";
applyCoupon_add.startDate=applyCoupon_add_pageId+" #startDate";
applyCoupon_add.endDate=applyCoupon_add_pageId+" #endDate";
applyCoupon_add.but=applyCoupon_add_pageId+" #but";
applyCoupon_add.endDateId=applyCoupon_add_pageId+" #endDateId";
applyCoupon_add.startDateId=applyCoupon_add_pageId+" #startDateId";
applyCoupon_add.sceneType=applyCoupon_add_pageId+" #sceneType";
applyCoupon_add.channelCode=applyCoupon_add_pageId+" #channelCode";
/*applyCoupon_add.monthDayList=applyCoupon_add_pageId+" #monthDayList";
applyCoupon_add.weekDayList=applyCoupon_add_pageId+" #weekDayList";
applyCoupon_add.dayTimeList=applyCoupon_add_pageId+" #dayTimeList";*/
/**
 * 页面初始化函数
 */
applyCoupon_add.inits = function() {
	$(applyCoupon_add.dgId).datagrid({
		striped : true,
		fitColumns : true,
		rownumbers : true,
		checkOnSelect : true,
		onDblClickRow : function(index,row){
				$(applyCoupon_add.dgId).datagrid('endEdit',index);
				$(applyCoupon_add.dgId).datagrid('beginEdit',index);
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
				return  '<a href="#" onclick="applyCoupon_add.getCouponInfo(this);">查询</a>';
			}
		}, {
			field : 'couponType',
			title : '优惠券类型',
			align:'center',
			hidden:true,
			width : 50,
		}, {
			field : 'couponName',
			title : '优惠券名称',
			align:'center',
			width : 50,
		}, {
			field : 'couponNum',
			title : '优惠券数量',
			align:'center',
			width : 50,
			editor:{type:'numberbox',options:{required:true}}
		},{
			field : 'couponPar',
			title : '优惠券面值',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true}}
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
			editor:{type:'numberbox',options:{required:true}}
		}, {
			field : 'titleLimits',
			title : '总限制值',
			align:'center',
			width : 100,
			editor:{type:'numberbox',options:{required:true}}
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
		toolbar : applyCoupon_add.tbId
	});
};

applyCoupon_add.addRow = function() {
		$(applyCoupon_add.dgId).datagrid('appendRow', {couponNum:0,couponPar:0,titleLimits:0,pertitleLimits:0});
}
applyCoupon_add.queryActivity=function(){
	$("#addApplyCouponMagnifier").window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        href: "applyCoupon/openActivityMagnifierWindow",
        title: "活动查询"
    });
	$('#addApplyCouponMagnifier').window('open');
}

applyCoupon_add.delRow=function(){
	var rowNums = $(applyCoupon_add.dgId).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(applyCoupon_add.dgId).datagrid('deleteRow',rowNums[i]-1);
	}
	$(applyCoupon_add.dgId).datagrid('clearChecked');
}

applyCoupon_add.back=function(){
	$(applyCouponManage.add).panel('close');
	$(applyCouponManage.applyCoupon_list_list_panel).show();
	$(applyCouponManage.applyCoupon_list_dg).datagrid('reload')
	
}

applyCoupon_add.getCouponInfo=function(obj){
	var i =$(obj).parents('tr').attr('datagrid-row-index');
	$('#addApplyCouponMagnifier').window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        method:'post',
        href: "applyCoupon/openApplyCouponMagnifierWindow?i="+i,
        title: "全部优惠券"
    });
	$('#addApplyCouponMagnifier').window('open');
}

applyCoupon_add.save=function(){
	$(applyCoupon_add.dgId).datagrid('acceptChanges');
	var materials = $(applyCoupon_add.dgId).datagrid('getRows');
	var activityId=$(applyCoupon_add.activityId).textbox('getValue');
	var activityName=$(applyCoupon_add.activityName).textbox('getValue');
	var activityEndDateId=$(applyCoupon_add.endDateId).val();
	var activityStartDateId=$(applyCoupon_add.startDateId).val();
	var activityStartDate=$(applyCoupon_add.startDate).datebox('getValue');
	var activityEndDate=$(applyCoupon_add.endDate).datebox('getValue');
	var sceneType=$(applyCoupon_add.sceneType).combobox('getValue');
	var channelCode=$(applyCoupon_add.channelCode).textbox('getValue');
	/*var monthDayList=$(applyCoupon_add.monthDayList).textbox('getValue');
	var weekDayList=$(applyCoupon_add.weekDayList).textbox('getValue');
	var dayTimeList=$(applyCoupon_add.dayTimeList).textbox('getValue');*/
	/*alert(activityId+","+activityName+","+endDateId+","+startDateId+","+startDate+","+endDate+","+sceneType+","+channelCode
			+","+monthDayList+","+weekDayList+","+dayTimeList);*/
	if($.o2m.isEmpty(activityId)){
		$.messager.alert('提示','请添加活动','info');
		return false;
	}
	if($.o2m.isEmpty(channelCode)){
		$.messager.alert('提示','请添加渠道代码','info');
		return false;
	}
	/*if($.o2m.isEmpty(monthDayList)){
		$.messager.alert('提示','请添加每月日集合','info');
		return false;
	}
	if($.o2m.isEmpty(weekDayList)){
		$.messager.alert('提示','请添加每周日集合','info');
		return false;
	}
	if($.o2m.isEmpty(dayTimeList)){
		$.messager.alert('提示','请添加每天时段集合','info');
		return false;
	}*/
	if($.o2m.isEmpty(sceneType)){
		$.messager.alert('提示','请选择使用场景','info');
		return false;
	}
	var arys1= new Array();     
    var arys2= new Array();
	var arys3= new Array();     
    var arys4= new Array();
    arys1=activityStartDate.split('-');
    arys2=activityStartDateId.split('-');
    arys3=activityEndDate.split('-');
    arys4=activityEndDateId.split('-');
    var afTime=arys1[0]+arys1[1]+arys1[2];
    var beTime=arys2[0]+arys2[1]+arys2[2];
    var afTime1=arys3[0]+arys3[1]+arys3[2];
    var beTime1=arys4[0]+arys4[1]+arys4[2];
    if(afTime-afTime1>0){
    	$.messager.alert('提示','活动开始时间不能大于活动结束时间','info');
    	return false;
    }
    if(afTime-beTime1>0){
    	$.messager.alert('提示','活动开始时间不能大于预计活动结束时间','info');
    	return false;
    }
    if(afTime1-afTime<0){
    	$.messager.alert('提示','活动结束时间不能小于活动开始时间','info');
    	return false;
    }
    if(afTime1-beTime<0){
    	$.messager.alert('提示','活动结束时间不能小于预计活动开始时间','info');
    	return false;
    }
    if(beTime-afTime>0){
    	$.messager.alert('提示','活动开始时间不能小于活动预计开始时间','info');
    	return false;
    }
    if(beTime1-afTime1<0){
    	$.messager.alert('提示','活动结束时间不能大于活动预计结束时间','info');
    	return false;
    }
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
		if (materials[i].titleLimits<materials[i].pertitleLimits){
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
	if(materials.length==0){
		$.messager.alert('提示','请添加数据保存','info');
		return false;
	}
	var saveApplyCoupon={};
	saveApplyCoupon.coupons=materials;
	var channelCode=$(applyCoupon_add.channelCode).textbox('getValue');
	/*var monthDayList=$(applyCoupon_add.monthDayList).textbox('getValue');
	var weekDayList=$(applyCoupon_add.weekDayList).textbox('getValue');
	var dayTimeList=$(applyCoupon_add.dayTimeList).textbox('getValue');*/
	
	$.ajax({
		type : "POST",
		url : "applyCoupon/addCoupon?promotionCode="+activityId+"&beginTime="+activityStartDate+"&endTime="+activityEndDate+"&sceneType="+sceneType+"&channelCode="+channelCode,
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
applyCoupon_add.inits();