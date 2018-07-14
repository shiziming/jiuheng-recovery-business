var indexGoods_detailed = {};
indexGoods_detailed.pageId="#indexGoods_list_detailed";
indexGoods_detailed.dgId=indexGoods_detailed.pageId+" #detailed";
indexGoods_detailed.orderNum=indexGoods_detailed.pageId+" #orderNum";
indexGoods_detailed.status=indexGoods_detailed.pageId+" #status";
indexGoods_detailed.funcId=indexGoods_detailed.pageId+" #funcId";
indexGoods_detailed.salAgencyCode=indexGoods_detailed.pageId+" #salAgencyCode";
indexGoods_detailed.update_panel=indexGoods_detailed.pageId+" #update_panel";
indexGoods_detailed.indexGoods_list_detailed_form=indexGoods_detailed.pageId+" #indexGoods_list_detailed_form";
indexGoods_detailed.add_panel=indexGoods_detailed.pageId+" #add_panel"
indexGoods_detailed.searImage_panel=indexGoods_detailed.pageId+" #searImage_panel"
indexGoods_detailed.choice_salAgencyCode_panel=indexGoods_detailed.pageId+" #choice_salAgencyCode_panel";
/**
 * 页面初始化函数
 */
indexGoods_detailed.inits = function() {
	var salAgencyCode=$(indexGoods_detailed.salAgencyCode).val();
	if(salAgencyCode=='GMZB'){
		$(indexGoods_detailed.dgId).datagrid({
			title : "单据明细",
			url : "wdIndexGoodsController/getIndexGoodsDetail",
			height : document.documentElement.clientHeight * 0.86,
			striped : true,
			collapsible : true,
			rownumbers : true,
			fitColumns:true,
			singleSelect:true,
			fixed:true,
			columns : [ [ {
				field : 'orderNum',
				title : '单据编号',
				align:'center',
				width : 80
			}, {
				field : 'keyWord',
				title : '关键字',
				align : 'center',
				width : 80
			},{
				field : 'spuCode',
				title : '商品SPU码',
				align : 'center',
				width : 80
			}, {
				field : 'spuName',
				title : '商品名称',
				align : 'center',
				width : 120
			},{
				field : 'salAgencyCode',
				title : '销售组织代码',
				align : 'center',
				width : 80
			}, {
				field : 'orderAgencyCode',
				title : '单据机构代码',
				align : 'center',
				width : 80
			}, {
				field : 'showNum',
				title : '图片位置',
				align : 'center',
				width : 80
			},{
				field : 'url',
				title : '图片链接地址',
				align : 'center',
				width : 80
			}, {
				field : 'goodsSPUID',
				title : '商品SUPID',
				align : 'center',
				hidden: true
			}] ],
			onBeforeLoad :function(param) {
				param.orderNum=$(indexGoods_detailed.orderNum).val();
			}
		});
	}else{
		$(indexGoods_detailed.dgId).datagrid({
			title : "单据明细",
			url : "wdIndexGoodsController/getIndexGoodsDetail",
			height : document.documentElement.clientHeight * 0.86,
			striped : true,
			collapsible : true,
			rownumbers : true,
			fitColumns:true,
			singleSelect:true,
			fixed:true,
			columns : [ [ {
				field : 'orderNum',
				title : '单据编号',
				align:'center',
				width : 80
			}, {
				field : 'keyWord',
				title : '关键字',
				align : 'center',
				width : 80
			},{
				field : 'spuCode',
				title : '商品SPU码',
				align : 'center',
				width : 80
			}, {
				field : 'spuName',
				title : '商品名称',
				align : 'center',
				width : 120
			},{
				field : 'salAgencyCode',
				title : '销售组织代码',
				align : 'center',
				width : 80
			}, {
				field : 'orderAgencyCode',
				title : '单据机构代码',
				align : 'center',
				width : 80
			}, {
				field : 'showNum',
				title : '图片位置',
				align : 'center',
				width : 80
			}, {
				field : 'goodsSPUID',
				title : '商品SUPID',
				align : 'center',
				hidden: true
			}] ],
			onBeforeLoad :function(param) {
				param.orderNum=$(indexGoods_detailed.orderNum).val();
			}
		});
	}
};

/**
 * 从查看页面返回到列表页面
 */
indexGoods_detailed.back=function(){
	$(indexGoodsManage.searchAndAuditing).hide();
	$(indexGoodsManage.indexGoods_list_list_panel).show();
	$('#indexGoods_list_dg').datagrid({url:"wdIndexGoodsController/queryList"});
};
/**
 * 删除商品
 */
indexGoods_detailed.del=function(){
	var selectedRow = $(indexGoods_detailed.dgId).datagrid('getSelections');
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
	var data1 = $(indexGoods_detailed.dgId).datagrid("getChecked")[0];
	var isok=confirm("确认删除此商品么？");
	if(isok){
	$.ajax({ 
        type:"POST", 
        url:"wdIndexGoodsController/deleteIndexGoodsDetail",
        data:{orderNum:data1.orderNum,goodsSPUID:data1.goodsSPUID},
        success:function(data){
        	if(data.code==0){
        		$(indexGoods_detailed.dgId).datagrid({url : "wdIndexGoodsController/getIndexGoodsDetail"});
	        	parent.$.messager.alert('提示','删除成功！','success');
	        	$(indexGoodsManage.searchAndAuditing).panel('close');
				$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+data1.orderNum});
				$(indexGoodsManage.searchAndAuditing).panel('open');
        	}else if(data.code==1){
        		parent.$.messager.alert('警告','删除失败！','worm');
        	}
        }
    });
	}
};
/**
 *上传/修改图片
 */
indexGoods_detailed.update=function(){
	var orderNum=$(indexGoods_detailed.orderNum).val();
	//上传加工图
		$(indexGoods_detailed.indexGoods_list_detailed_form).hide();
		$(indexGoods_detailed.update_panel).panel({title:'上传/修改图片', href:"wdIndexGoodsController/addView?orderNum="+orderNum});
		$(indexGoods_detailed.update_panel).panel('open');
};

/**
 * 下载图片
 */
indexGoods_detailed.downloadImage=function(){
	var selectedRow = $(indexGoods_detailed.dgId).datagrid('getSelections');
	// 没选择数据时，显示告警，返回
	if (selectedRow.length != 1) {
		$.messager.show({
			title: '警告',
			msg: '请选择一条商品下载图片',
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
	var data = $(indexGoods_detailed.dgId).datagrid("getChecked")[0];
	window.location.href="wdIndexGoodsController/downloadImage?orderNum="+data.orderNum+'&&goodsSPUID='+data.goodsSPUID;
}

/**
 * 查看图片
 */
indexGoods_detailed.searImage=function(){
	var selectedRow = $(indexGoods_detailed.dgId).datagrid('getSelections');
	// 没选择数据时，显示告警，返回
	if (selectedRow.length != 1) {
		$.messager.show({
			title: '警告',
			msg: '请选择一条记录查看图片',
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
	var data = $(indexGoods_detailed.dgId).datagrid("getChecked")[0];
	var goodsSPUID=data.goodsSPUID;
	var orderNum=data.orderNum;
	var spuName=data.spuName;
	var spuCode=data.spuCode;
	$(indexGoods_detailed.indexGoods_list_detailed_form).hide();
	$(indexGoods_detailed.searImage_panel).panel({href:"wdIndexGoodsController/toSearImage_panel?orderNum="+orderNum+"&&goodsSPUID="+goodsSPUID+"&&spuCode="+spuCode+"&&currtime="+Math.random()});
	$(indexGoods_detailed.searImage_panel).panel('open');
	
}
/**
 * 添加商品
 */
indexGoods_detailed.add=function(){
	var getRows = $(indexGoods_detailed.dgId).datagrid('getRows');
	var j=0;
	for (var i = 0; i < getRows.length; i++) {
		if(getRows[i].spuCode>0){
			j++
		}
	}
	/*if(getRows.length == 6||getRows.length == 7){
		$.messager.alert('提示','商品已满,无法添加','info');
		return;
	}*/
	if(j==6){
		$.messager.alert('提示','商品已满,无法添加','info');
		return;
	}
	var orderNum=$(indexGoods_detailed.orderNum).val();
	$(indexGoods_detailed.indexGoods_list_detailed_form).hide();
	$(indexGoods_detailed.add_panel).panel({href:"wdIndexGoodsController/openAddIndexGoodsDetailWindow?orderNum="+orderNum});
	$(indexGoods_detailed.add_panel).panel('open');
}
/**
 * 非爆款添加
 */
indexGoods_detailed.newAdd=function(){
	var getRows = $(indexGoods_detailed.dgId).datagrid('getRows');
	var salAgencyCode=$("#salAgencyCode").val();
	if("GMZB"==salAgencyCode){
		if(getRows.length == 8){
			$.messager.alert('提示','商品已满,无法添加','info');
			return;
		}
	}else{
	if(getRows.length == 6){
		$.messager.alert('提示','商品已满,无法添加','info');
		return;
	}
	}
	var orderNum=$(indexGoods_detailed.orderNum).val();
	$.ajax({
		url:"wdIndexGoodsController/newAdd",
		data:{orderNum:orderNum},
		success:function(data){
			if(data.code==0){
				$(indexGoods_detailed.dgId).datagrid({url : "wdIndexGoodsController/getIndexGoodsDetail?orderNum="+orderNum})
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
			
		}
	})
}
/**
 * 添加非爆款链接
 */
indexGoods_detailed.addUrl=function(){
	var selectedRow = $(indexGoods_detailed.dgId).datagrid('getSelections');
	// 没选择数据时，显示告警，返回
	if (selectedRow.length != 1) {
		$.messager.show({
			title: '警告',
			msg: '请选择一条记录添加',
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
	var data = $(indexGoods_detailed.dgId).datagrid("getChecked")[0];
	var goodsSPUID=data.goodsSPUID;
	if(goodsSPUID>0){
		$.messager.show({
			title: '警告',
			msg: '请选择非爆款添加链接',
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
	var orderNum=data.orderNum;
	$(indexGoods_detailed.indexGoods_list_detailed_form).hide();
	$(indexGoods_detailed.add_panel).panel({href:"wdIndexGoodsController/openAddUrlWindow?orderNum="+orderNum+"&goodsSPUID="+goodsSPUID});
	$(indexGoods_detailed.add_panel).panel('open');
}
/**
 * 审批
 */
indexGoods_detailed.check=function(){
	var orderNum=$(indexGoods_detailed.orderNum).val();
	$.ajax({
		url:"wdIndexGoodsController/checkImage",
		data:{orderNum:orderNum},
		success:function(data){
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
				$(indexGoodsManage.searchAndAuditing).panel('close');
				$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+orderNum});
				$(indexGoodsManage.searchAndAuditing).panel('open');
			
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
}
/**
 * 审核图片
 */
indexGoods_detailed.checkImage=function(){

	var orderNum=$(indexGoods_detailed.orderNum).val();
	var status=$(indexGoods_detailed.status).val();
	/*var funcId=$(indexGoods_detailed.funcId).val();*/
	if(status=='未审核'){
		$.messager.alert("提示","数据未审核，请审核后再审批","info");
		return;
	}
	/*if(funcId!='3000076'){
		$.messager.alert("提示","你没有操作权限","info");
		return;
	}*/
	var salAgencyCode=$(indexGoods_detailed.salAgencyCode).val();
	if(salAgencyCode==null || salAgencyCode=='undefined' || salAgencyCode==''){
		$(indexGoods_detailed.indexGoods_list_detailed_form).hide();
		$(indexGoods_detailed.choice_salAgencyCode_panel).panel({href:"wdIndexGoodsController/openSalAgencyCodePanel?orderNum="+orderNum});
		$(indexGoods_detailed.choice_salAgencyCode_panel).panel('open');
		/*$('#choice_salAgencyCode_panel').window({
		    width: 450,
		    height: 330,
		    modal: true,
		    method:'post',
		    href: "wdIndexGoodsController/openSalAgencyCodePanel",
		    title: "选择页面"
		});
		$('#choice_salAgencyCode_panel').window('open');*/
	}else{
	$.o2m.showProgressing();
	$.ajax({
		url:'wdIndexGoodsController/check',
		data:{orderNum:orderNum,status:status},
		type:'post',
		success:function(data){
			$.o2m.closeProgressing();
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
				$(indexGoodsManage.searchAndAuditing).panel('close');
				$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+orderNum});
				$(indexGoodsManage.searchAndAuditing).panel('open');
			
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
	}
}
/**
 * 修改商品
 */
indexGoods_detailed.updateDetail=function(){
	var selectedRow = $(indexGoods_detailed.dgId).datagrid('getSelections');
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
	var data = $(indexGoods_detailed.dgId).datagrid("getChecked")[0];
	var goodsSPUID=data.goodsSPUID;
	if(goodsSPUID<=0){
		$.messager.alert("提示","非爆款商品不可修改","info");
		return false;
	}
	var orderNum=data.orderNum;
	var showNum=data.showNum;
	$(indexGoods_detailed.indexGoods_list_detailed_form).hide();
	$(indexGoods_detailed.add_panel).panel({href:"wdIndexGoodsController/openAddIndexGoodsDetailWindow?orderNum="+orderNum+"&goodsSPUID="+goodsSPUID+"&showNum="+showNum});
	$(indexGoods_detailed.add_panel).panel('open');
}
/**
 * 全国统一爆款
 */
indexGoods_detailed.nationalGoods=function(){
	var orderNum=$(indexGoods_detailed.orderNum).val();
	var status=$(indexGoods_detailed.status).val();
	if(status!='图片已审核'){
		$.messager.alert("提示","图片未审核，请审核后再审批","info");
		return;
	}
	var isok=confirm("确认全国统一爆款？");
	if(isok){
	$.o2m.showProgressing();
	$.ajax({
		url:'wdIndexGoodsController/nationalGoods',
		data:{orderNum:orderNum},
		type:'post',
		success:function(data){
			$.o2m.closeProgressing();
			if(data.code==0){
				$.messager.alert("提示",data.msg,"success")
				$(indexGoodsManage.searchAndAuditing).panel('close');
				$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+orderNum});
				$(indexGoodsManage.searchAndAuditing).panel('open');
			
			}else if(data.code==1){
				$.messager.alert("警告",data.msg,"info")
			}
		}
	})
	}
}

indexGoods_detailed.inits();
