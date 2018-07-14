var zeroBuy_detailed = {};
zeroBuy_detailed.pageId="#zeroBuy_list_detailed";
zeroBuy_detailed.dgId=zeroBuy_detailed.pageId+" #detailed";
zeroBuy_detailed.orderNum=zeroBuy_detailed.pageId+" #orderNum";
zeroBuy_detailed.status=zeroBuy_detailed.pageId+" #status";
zeroBuy_detailed.funcId=zeroBuy_detailed.pageId+" #funcId";
zeroBuy_detailed.salAgencyCode=zeroBuy_detailed.pageId+" #salAgencyCode";
zeroBuy_detailed.update_panel=zeroBuy_detailed.pageId+" #update_panel";
zeroBuy_detailed.zeroBuy_list_detailed_form=zeroBuy_detailed.pageId+" #zeroBuy_list_detailed_form";
zeroBuy_detailed.add_panel=zeroBuy_detailed.pageId+" #add_panel"
zeroBuy_detailed.searImage_panel=zeroBuy_detailed.pageId+" #searImage_panel"
zeroBuy_detailed.promotionCode=zeroBuy_detailed.pageId+" #promotionCode";
/**
 * 页面初始化函数
 */
zeroBuy_detailed.inits = function() {
	var salAgencyCode=$(zeroBuy_detailed.salAgencyCode).val();
		$(zeroBuy_detailed.dgId).datagrid({
			title : "商品明细",
			url : "zeroBuy/getzeroBuyDetail",
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
				field : 'promotionCode',
				title : '活动号',
				align : 'center',
				width : 10
			}, {
				field : 'skuID',
				title : '商品SKUID',
				align : 'center',
				width :	10
			}, {
				field : 'skuName',
				title : '商品名称',
				align : 10
			},{
				field : 'salAgencyCode',
				title : '销售组织代码',
				align : 'center',
				width : 10
			}, {
				field : 'orderAgencyCode',
				title : '单据机构代码',
				align : 'center',
				width : 10
			}, {
				field : 'limitNum',
				title : '限制数量',
				align : 'center',
				width : 10
			},{
				field : 'distributionFee',
				title : '配送运费',
				align : 'center',
				width : 10
			}] ],
			onBeforeLoad :function(param) {
				param.orderNum=$(zeroBuy_detailed.orderNum).val();
			}
		});
};

/**
 * 从查看页面返回到列表页面
 */
zeroBuy_detailed.back=function(){
	$(zeroBuyManage.searchAndAuditing).hide();
	$(zeroBuyManage.zeroBuy_list_list_panel).show();
	$(zeroBuyManage.zeroBuy_list_dg).datagrid({url:"zeroBuy/queryList"});
};
/**
 * 删除商品
 */
zeroBuy_detailed.del=function(){
	var selectedRow = $(zeroBuy_detailed.dgId).datagrid('getSelections');
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
	var data1 = $(zeroBuy_detailed.dgId).datagrid("getChecked")[0];
	var isok=confirm("确认删除此商品么？");
	if(isok){
	$.ajax({ 
        type:"POST", 
        url:"zeroBuy/deletezeroBuyDetail",
        data:{orderNum:data1.orderNum,skuID:data1.skuID},
        success:function(data){
        	if(data.code==0){
        		$(zeroBuy_detailed.dgId).datagrid({url : "zeroBuy/getzeroBuyDetail"});
	        	parent.$.messager.alert('提示','删除成功！','success');
	        	$(zeroBuyManage.searchAndAuditing).panel('close');
				$(zeroBuyManage.searchAndAuditing).panel({href:"zeroBuy/toSearcherDetailedWomdow?orderNum="+data1.orderNum});
				$(zeroBuyManage.searchAndAuditing).panel('open');
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
zeroBuy_detailed.add=function(){
	var orderNum=$(zeroBuy_detailed.orderNum).val();
	var salAgencyCode=$(zeroBuy_detailed.salAgencyCode).val();
	$(zeroBuy_detailed.zeroBuy_list_detailed_form).hide();
	$(zeroBuy_detailed.add_panel).panel({href:"zeroBuy/openAddzeroBuyDetailWindow?orderNum="+orderNum+"&salAgencyCode="+salAgencyCode});
	$(zeroBuy_detailed.add_panel).panel('open');
}


/**
 * 审批同意
 */
zeroBuy_detailed.check=function(){
	var orderNum=$(zeroBuy_detailed.orderNum).val();
	var promotionCode=$(zeroBuy_detailed.promotionCode).val();
	var salAgencyCode=$(zeroBuy_detailed.salAgencyCode).val();
	$.ajax({
		url:"zeroBuy/check",
		data:{orderNum:orderNum,promotionCode:promotionCode,salAgencyCode:salAgencyCode},
		success:function(data){
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
				$(zeroBuyManage.searchAndAuditing).panel('close');
				$(zeroBuyManage.searchAndAuditing).panel({href:"zeroBuy/toSearcherDetailedWomdow?orderNum="+orderNum});
				$(zeroBuyManage.searchAndAuditing).panel('open');
			
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
}

/**
 * 审批不同意
 */
zeroBuy_detailed.checkNo=function(){
	var orderNum=$(zeroBuy_detailed.orderNum).val();
	$.ajax({
		url:"zeroBuy/checkNo",
		data:{orderNum:orderNum},
		success:function(data){
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
				$(zeroBuyManage.searchAndAuditing).panel('close');
				$(zeroBuyManage.searchAndAuditing).panel({href:"zeroBuy/toSearcherDetailedWomdow?orderNum="+orderNum});
				$(zeroBuyManage.searchAndAuditing).panel('open');
			
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
}
/**
 * 终止活动
 */
zeroBuy_detailed.stop=function(){
	var orderNum=$(zeroBuy_detailed.orderNum).val();
	var status=$(zeroBuy_detailed.status).val();
	if(status=="已录入"){
		$.messager.alert("警告","该活动未审核,请审核后终止","info")
		return false;
	}
	$.ajax({
		url:"zeroBuy/stopActivity",
		data:{orderNum:orderNum},
		success:function(data){
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
				$(zeroBuyManage.searchAndAuditing).panel('close');
				$(zeroBuyManage.searchAndAuditing).panel({href:"zeroBuy/toSearcherDetailedWomdow?orderNum="+orderNum});
				$(zeroBuyManage.searchAndAuditing).panel('open');
			
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
}
/**
 * 修改商品
 */
zeroBuy_detailed.updateDetail=function(){
	var selectedRow = $(zeroBuy_detailed.dgId).datagrid('getSelections');
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
	var data = $(zeroBuy_detailed.dgId).datagrid("getChecked")[0];
	var skuID=data.skuID;
	var orderNum=data.orderNum;
	var limitNum=data.limitNum;
	var distributionFee=data.distributionFee;
	$(zeroBuy_detailed.zeroBuy_list_detailed_form).hide();
	$(zeroBuy_detailed.add_panel).panel({href:"zeroBuy/openAddzeroBuyDetailWindow?orderNum="+orderNum+"&skuID="+skuID+"&limitNum="+limitNum+"&distributionFee="+distributionFee});
	$(zeroBuy_detailed.add_panel).panel('open');
}
zeroBuy_detailed.inits();
