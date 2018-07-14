var zeroBuyAddDetail = {};
zeroBuyAddDetail.pageId="#zeroBuy_AddZeroBuyDetail";
zeroBuyAddDetail.skuID=zeroBuyAddDetail.pageId+" #skuID";
zeroBuyAddDetail.limitNum=zeroBuyAddDetail.pageId+" #limitNum";
zeroBuyAddDetail.distributionFee=zeroBuyAddDetail.pageId+" #distributionFee";
zeroBuyAddDetail.orderNum=zeroBuyAddDetail.pageId+" #orderNumId";
zeroBuyAddDetail.skuId=zeroBuyAddDetail.pageId+" #skuId";
zeroBuyAddDetail.skuIdID=zeroBuyAddDetail.pageId+" #skuIdID";
zeroBuyAddDetail.salAgencyCode=zeroBuyAddDetail.pageId+" #salAgencyCode";
var orderNum=$(zeroBuyAddDetail.orderNum).val();
var salAgencyCode=$(zeroBuyAddDetail.salAgencyCode).val();
	/*$(zeroBuyAddDetail.skuID).searchbox({
	    searcher:function(value,name){
	    	async:false,
	    	$('#magnifier_SkuName_window').window({
	            width: 700,
	            height: 450,
	            modal: true,
	            method:'post',
	            href: "zeroBuy/openSkuNameMagnifierWindow?orderNum="+orderNum+"&salAgencyCode="+salAgencyCode,
	            title: "SKU商品信息"
	        });
	    	$('#magnifier_SkuName_window').window('open');
	     },   
	    prompt:''  
	});*/

/**
 * 返回列表页面
 */
zeroBuyAddDetail.returnToListPage=function(){
	$(zeroBuy_detailed.add_panel).panel('close');
	$(zeroBuyManage.searchAndAuditing).panel({href:"zeroBuy/toSearcherDetailedWomdow?orderNum="+orderNum});
	$(zeroBuy_detailed.dgId).datagrid('reload')
	
}

/**
 * 修改数据
 */
zeroBuyAddDetail.createzeroBuy=function(){
	 var skuID=$(zeroBuyAddDetail.skuID).val();
	 var limitNum=$(zeroBuyAddDetail.limitNum).val();
	 var distributionFee=$(zeroBuyAddDetail.distributionFee).val();
	if(null==limitNum||''==limitNum){
		$.messager.alert('提示','商品限制数量不能为空','info');
		return false;
	}
	if(null==distributionFee||''==distributionFee){
		$.messager.alert('提示','商品配送费用量不能为空','info');
		return false;
	}
		$.ajax({
			url:'zeroBuy/updatezeroBuyDetail',
			data:{skuID:skuID,orderNum:orderNum,limitNum:limitNum,distributionFee:distributionFee},
			type:'post',
			success:function(data){
				if(data.code==0){
					$(zeroBuyAddDetail.skuIdID).val(skuID);
					$.messager.alert('提示',data.msg,'info');
				}else if(data.code==1){
					$.messager.alert('警告',data.msg,'info');
				}
				
			}
			
		});
	
}
