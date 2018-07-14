var indexGoodEdit={};
indexGoodEdit.indexGoods_Edit_page='#indexGoods_Edit_page';
indexGoodEdit.win = '#indexGood_EditWindow_show';
indexGoodEdit.salAgencyCodeId=indexGoodEdit.indexGoods_Edit_page+' #salAgencyCodeId1';
indexGoodEdit.publicDateId=indexGoodEdit.indexGoods_Edit_page+" #publicDateId";
indexGoodEdit.submit=function(){
	var orderNum=$('#orderNumidId').val();
	$('#indexGoodsEditForm').form('submit', {
		url: "wdIndexGoodsController/updateIndexGoods",
		onSubmit: function(param){
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
		var publishDate=$('#publicDateId').datebox('getValue');
		var arys1= new Array();     
	    var arys2= new Array();
	    arys1=newDate.split('-');
	    arys2=publishDate.split('-');
	    var now=arys1[0]+arys1[1]+arys1[2];
	    var publish=arys2[0]+arys2[1]+arys2[2];
	    if(publish-now<0){
	    	$.messager.alert('警告','计划发布时间不能早于当前日期','info');
	    	return false;
	    }
			param.orderNum=orderNum;
			var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交
		},
		success: function(data){
			var data =eval('('+data+')')
			if (data.code==0) {
				$.messager.alert('提示',data.msg,'success');
	    	}else if(data.code== 1){
	    		$.messager.alert('警告',data.msg,'info');
	    	}
			
		}
	});
}

indexGoodEdit.returnToList=function(){
	$(indexGoodsManage.update).panel('close');
	$(indexGoodsManage.indexGoods_list_list_panel).show();
	$('#indexGoods_list_dg').datagrid('reload');
}
