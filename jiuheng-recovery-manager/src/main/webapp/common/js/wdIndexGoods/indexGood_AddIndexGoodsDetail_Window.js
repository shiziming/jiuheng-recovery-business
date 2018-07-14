var indexGoodAddDetail = {};
indexGoodAddDetail.pageId="#indexGood_AddIndexGoodsDetail";
indexGoodAddDetail.spuIdID=indexGoodAddDetail.pageId+" #spuIdID";
indexGoodAddDetail.spuCodeID=indexGoodAddDetail.pageId+" #spuCodeID";
indexGoodAddDetail.spuNameID=indexGoodAddDetail.pageId+" #spuNameID";
indexGoodAddDetail.spuModelId=indexGoodAddDetail.pageId+" #spuModelId";
indexGoodAddDetail.orderNumId=indexGoodAddDetail.pageId+" #orderNumId";
indexGoodAddDetail.showNumId=indexGoodAddDetail.pageId+" #showNumid";
indexGoodAddDetail.goodsSPUIDId=indexGoodAddDetail.pageId+" #goodsSPUIDId";
var orderNum=$(indexGoodAddDetail.orderNumId).val();
	$(indexGoodAddDetail.spuIdID).searchbox({
	    searcher:function(value,name){
	    	async:false,
	    	$('#magnifier_SpuName_window').window({
	            width: 700,
	            height: 450,
	            modal: true,
	            method:'post',
	            href: "wdIndexGoodsController/openSpuNameMagnifierWindow?orderNum="+orderNum,
	            title: "全部SPU代码"
	        });
	    	$('#magnifier_SpuName_window').window('open');
	     },   
	    prompt:''  
	});

/**
 * 返回列表页面
 */
indexGoodAddDetail.returnToListPage=function(){
	$(indexGoods_detailed.add_panel).panel('close');
	//$(indexGoods_detailed.indexGoods_list_detailed_form).show();
	$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+orderNum});
	$(indexGoods_detailed.dgId).datagrid('reload')
	
}

/**
 * 添加/修改数据
 */
indexGoodAddDetail.createIndexGoods=function(){
	 var goodsSPUID=$(indexGoodAddDetail.spuIdID).searchbox('getValue');
	var orderNum=$(indexGoodAddDetail.orderNumId).val();
	var showNum=$(indexGoodAddDetail.showNumId).combobox('getValue');
	var goodsSPUIDId=$(indexGoodAddDetail.goodsSPUIDId).val();
	if(null==goodsSPUID||''==goodsSPUID){
		$.messager.alert('提示','商品SPUID不能为空','info');
		return false;
	}
	if(0==showNum){
		$.messager.alert('提示','请选择图片显示位置','info');
		return false;
	}
	if(null==goodsSPUIDId||""==goodsSPUIDId){
		$.ajax({
			url:'wdIndexGoodsController/addIndexGoodsDetail',
			data:{goodsSPUID:goodsSPUID,orderNum:orderNum,showNum:showNum},
			type:'post',
			success:function(data){
				if(data.code==0){
					$.messager.alert('提示',data.msg,'info');
				}else if(data.code==1){
					$.messager.alert('警告',data.msg,'info');
				}
				
			}
			
		});
	}else{
		$.ajax({
			url:'wdIndexGoodsController/updateIndexGoodsDetail',
			data:{goodsSPUID:goodsSPUID,orderNum:orderNum,showNum:showNum,goodsSPUIDId:goodsSPUIDId},
			type:'post',
			success:function(data){
				if(data.code==0){
					$(indexGoodAddDetail.goodsSPUIDId).val(goodsSPUID);
					$.messager.alert('提示',data.msg,'info');
				}else if(data.code==1){
					$.messager.alert('警告',data.msg,'info');
				}
				
			}
			
		});
	}
	
}
