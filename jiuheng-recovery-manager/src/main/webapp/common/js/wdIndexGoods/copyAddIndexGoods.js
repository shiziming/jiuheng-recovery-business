var copyIndexGoodsAdd={};
copyAddPage="#copy_Add_page";
copyIndexGoodsAdd.salAgencyCodeId=copyAddPage+" #salAgencyCodeId";
copyIndexGoodsAdd.orderAgencyCodeIdID=copyAddPage+" #orderAgencyCodeIdID";


copyIndexGoodsAdd.submit=function(){
	$('#indexGoodsAddForm').form('submit', {
		url: "wdIndexGoodsController/updateHavingIndexGoods",
		onSubmit: function(){
			var salAgencyCodeId=$(copyIndexGoodsAdd.salAgencyCodeId).combobox('getValue');
		    if(null==salAgencyCodeId||""==salAgencyCodeId){
		    	$.messager.alert('提示','请选择销售组织','info');
		    	return false;
		    }
			var publishDate=$('#publishDateId').datebox('getValue');
			if(null==publishDate||""==publishDate){
				$.messager.alert('提示','请选择计划发布时间','info');
				return false;
			}
			 var date = new Date();
			    var seperator1 = "-";
			    var month = date.getMonth() + 1;
			    var strDate = date.getDate();
			    if (month >= 1 && month <= 9) {
			        month = "0" + month;
			    }
			    if (strDate >= 0 && strDate <= 9) {
			        strDate = "0" + strDate;
			    }
			    var newDate = date.getFullYear() + seperator1 + month + seperator1 + strDate
			var arys1= new Array();     
		    var arys2= new Array();
		    arys1=newDate.split('-');
		    arys2=publishDate.split('-');
		    var now=arys1[0]+arys1[1]+arys1[2];
		    var publish=arys2[0]+arys2[1]+arys2[2];
		    if(publish-now<0){
		    	$.messager.alert("警告","计划发布时间不能早于当前日期","info");
		    	return false;
		    }
			var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交
		},
		success:function(data){
			var data=eval('('+data+')');
			if (data.code==0) {
				$.messager.alert('提示',data.msg,'success');
	    	}else if(data.code== 1){
	    		$.messager.alert('警告',data.msg,'info');
	    	}
		}
	});
}

copyIndexGoodsAdd.returnToList=function(){
	$(indexGoodsManage.add).panel('close');
	$(indexGoodsManage.indexGoods_list_list_panel).show();
	$('#indexGoods_list_dg').datagrid('reload')
}
