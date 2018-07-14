var applyCoupon_detailed = {};
applyCoupon_detailed.pageId="#applyCoupon_list_detailed";
applyCoupon_detailed.dgId=applyCoupon_detailed.pageId+" #detailed";
applyCoupon_detailed.orderNum=applyCoupon_detailed.pageId+" #orderNum";
applyCoupon_detailed.status=applyCoupon_detailed.pageId+" #status";
applyCoupon_detailed.funcId=applyCoupon_detailed.pageId+" #funcId";
applyCoupon_detailed.salAgencyCode=applyCoupon_detailed.pageId+" #salAgencyCode";
applyCoupon_detailed.update_panel=applyCoupon_detailed.pageId+" #update_panel";
applyCoupon_detailed.applyCoupon_list_detailed_form=applyCoupon_detailed.pageId+" #applyCoupon_list_detailed_form";
applyCoupon_detailed.add_panel=applyCoupon_detailed.pageId+" #add_panelss";
applyCoupon_detailed.searImage_panel=applyCoupon_detailed.pageId+" #searImage_panel";
applyCoupon_detailed.promotionCode=applyCoupon_detailed.pageId+" #promotionCode";
/**
 * 页面初始化函数
 */
applyCoupon_detailed.inits = function() {
		$(applyCoupon_detailed.dgId).datagrid({
			title : "优惠券明细",
			url : "applyCoupon/getApplyCouponDetail",
			height : document.documentElement.clientHeight * 0.86,
			striped : true,
			collapsible : true,
			rownumbers : true,
			pagination : true,
			pageSize : 20,
			fitColumns:true,
			singleSelect:true,
			columns : [ [ {
				field : 'orderNum',
				title : '单据编号',
				align:'center',
				width : 10
			}, {
				field : 'ordinal',
				title : '序号',
				align : 'center',
				width : 10
			}, {
				field : 'groupNo',
				title : '分组号',
				align : 'center',
				width :	10
			}, {
				field : 'couponType',
				title : '优惠券类型',
				align : 10
			},{
				field : 'couponNum',
				title : '优惠券数量',
				align : 'center',
				width : 10
			}, {
				field : 'couponPar',
				title : '优惠券面值',
				align : 'center',
				width : 10
			}, {
				field : 'havefunBegin',
				title : '有效期开始',
				align : 'center',
				width : 10
			},{
				field : 'havefunEnd',
				title : '有效期结束',
				align : 'center',
				width : 10
			},{
				field : 'titleLimits',
				title : '总限制值',
				align : 'center',
				width : 10
			},{
				field : 'pertitleLimits',
				title : '每人总限制值',
				align : 'center',
				width : 10
			}] ],
			onBeforeLoad :function(param) {
				param.orderNum=$(applyCoupon_detailed.orderNum).val();
			}
		});
};

/**
 * 从查看页面返回到列表页面
 */
applyCoupon_detailed.back=function(){
	$(applyCouponManage.searchAndAuditing).hide();
	$(applyCouponManage.applyCoupon_list_list_panel).show();
	$(applyCouponManage.applyCoupon_list_dg).datagrid({url:"applyCoupon/queryList"});
};
/**
 * 删除商品
 */
applyCoupon_detailed.del=function(){
	var selectedRow = $(applyCoupon_detailed.dgId).datagrid('getSelections');
	// 没选择数据时，显示告警，返回
	if (selectedRow.length != 1) {
		$.messager.show({
			title: '警告',
			msg: '请选择一条记录删除',
			showType: 'slide',
			timeout: 2000,
			style:{
				right:'',
				top:document.body.scrollTop+document.documentElement.scrollTop,
				bottom:''
			}
		});		
		
		return false;
	}
	var data1 = $(applyCoupon_detailed.dgId).datagrid("getChecked")[0];
	var isok=confirm("确认删除此商品么？");
	if(isok){
	$.ajax({ 
        type:"POST", 
        url:"applyCoupon/deleteApplyCouponDetail",
        data:{orderNum:data1.orderNum,ordinal:data1.ordinal},
        success:function(data){
        	if(data.code==0){
        		$(applyCoupon_detailed.dgId).datagrid('reload');
	        	parent.$.messager.alert('提示','删除成功！','success');
        	}else if(data.code==1){
        		parent.$.messager.alert('警告','删除失败！','worm');
        	}
        }
    });
	}
};



/**
 * 添加商品
 */
applyCoupon_detailed.add=function(){
	var orderNum=$(applyCoupon_detailed.orderNum).val();
	$(applyCoupon_detailed.applyCoupon_list_detailed_form).hide();
	$(applyCoupon_detailed.add_panel).panel({href:"applyCoupon/openAddApplyCouponDetailWindow?orderNum="+orderNum});
	$(applyCoupon_detailed.add_panel).panel("open");
}


/**
 * 审核
 */
applyCoupon_detailed.check=function(){
	var orderNum=$(applyCoupon_detailed.orderNum).val();
	$.ajax({
		url:"applyCoupon/check",
		data:{orderNum:orderNum},
		success:function(data){
			if(data.code==0){
				$(applyCouponManage.searchAndAuditing).panel('close');
				$(applyCouponManage.searchAndAuditing).panel({href:"applyCoupon/toSearcherDetailedWindow?orderNum="+orderNum});
				$(applyCouponManage.searchAndAuditing).panel('open');
				$.messager.alert("提示",data.msg,"info")
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
}



/**
 * 修改商品
 */
applyCoupon_detailed.updateDetail=function(){
	var selectedRow = $(applyCoupon_detailed.dgId).datagrid('getSelections');
	// 没选择数据时，显示告警，返回
	if (selectedRow.length != 1) {
		$.messager.show({
			title: '警告',
			msg: '请选择一条记录进行修改',
			showType: 'slide',
			timeout: 2000,
			style:{
				right:'',
				top:document.body.scrollTop+document.documentElement.scrollTop,
				bottom:''
			}
		});		
		
		return false;
	}
	var data = $(applyCoupon_detailed.dgId).datagrid("getChecked")[0];
	var orderNum=data.orderNum;
	var ordinal=data.ordinal;
	$(applyCoupon_detailed.applyCoupon_list_detailed_form).hide();
	$(applyCoupon_detailed.add_panel).panel({href:"applyCoupon/openUpdateApplyCouponDetailWindow?orderNum="+orderNum+"&ordinal="+ordinal});
	$(applyCoupon_detailed.add_panel).panel('open');
}
applyCoupon_detailed.inits();
