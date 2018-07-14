var zeroBuy_Import = {};

zeroBuy_Import_PageId = "#zeroBuy_Import_Page";
zeroBuy_Import.salAgencyCodeId=zeroBuy_Import_PageId+" #salAgencyCode";
zeroBuy_Import.promotionCode=zeroBuy_Import_PageId+" #promotionCode";
zeroBuy_Import.activityName=zeroBuy_Import_PageId+" #activityName";
zeroBuy_Import.beginDate=zeroBuy_Import_PageId+" #beginDate";
zeroBuy_Import.endDate=zeroBuy_Import_PageId+" #endDate";
zeroBuy_Import.beginDateId=zeroBuy_Import_PageId+" #beginDateId";
zeroBuy_Import.endDateId=zeroBuy_Import_PageId+" #endDateId";
zeroBuy_Import.searchForm=zeroBuy_Import_PageId+" #searchForm";
zeroBuy_Import.channelCode=zeroBuy_Import_PageId+" #channelCode";

/**
 * 查询有效活动
 */
zeroBuy_Import.queryActivity=function(){
	$("#importMagnifier").window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        href: "zeroBuy/openImportMagnifier",
        title: "活动查询"
    });
	$('#importMagnifier').window('open');
}



zeroBuy_Import.back=function(){
	$(zeroBuyManage.add).panel('close');
	$(zeroBuyManage.zeroBuy_list_list_panel).show();
	$(zeroBuyManage.zeroBuy_list_dg).datagrid('reload')
	
}

zeroBuy_Import.save=function(obj){
	//判断上传文件是否为excel
	var file = $('input[name=fileimport]').val();
	if (file.lastIndexOf('.xls') == "-1") {
		$.messager.alert('警告','上传的不是Excle文件,请重新选择！',"warning");
		return;
	}
	$(zeroBuy_Import.searchForm).form("submit",{
		url:"common/import/uploadZeroBuyExcel",
		onSubmit: function () {
			var beValidate = $(zeroBuy_Import.searchForm).form('validate');
			if(!beValidate){
				return false;
			}
			var salAgencyCodeId=$(zeroBuy_Import.salAgencyCodeId).val();
			if(null==salAgencyCodeId||""==salAgencyCodeId){
				$.messager.alert('警告','销售组织不能为空！',"info");
				return false;
			}
			var channelCode=$(zeroBuy_Import.channelCode).val();
			if(null==channelCode||""==channelCode){
				$.messager.alert('警告','渠道代码不能为空！',"info");
				return false;
			}
			var beginDate=$(zeroBuy_Import.beginDate).datebox('getValue');
			var endDate=$(zeroBuy_Import.endDate).datebox('getValue');
			var beginDateId=$(zeroBuy_Import.beginDateId).val();
			var endDateId=$(zeroBuy_Import.endDateId).val();
			var arys1= new Array();     
		    var arys2= new Array();
			var arys3= new Array();     
		    var arys4= new Array();
		    arys1=beginDate.split('-');
		    arys2=beginDateId.split('-');
		    arys3=endDate.split('-');
		    arys4=endDateId.split('-');
		    var newTime=arys1[0]+arys1[1]+arys1[2];
		    var oldTime=arys2[0]+arys2[1]+arys2[2];
		    var newTime1=arys3[0]+arys3[1]+arys3[2];
		    var oldTime1=arys4[0]+arys4[1]+arys4[2];
		    if(newTime-newTime1>0){
		    	$.messager.alert('提示','活动开始时间不能大于活动结束时间','info');
		    	return false;
		    }
		    if(newTime-oldTime1>0){
		    	$.messager.alert('提示','活动开始时间不能大于预计活动结束时间','info');
		    	return false;
		    }
		    if(newTime1-newTime<0){
		    	$.messager.alert('提示','活动结束时间不能小于活动开始时间','info');
		    	return false;
		    }
		    if(newTime1-oldTime<0){
		    	$.messager.alert('提示','活动结束时间不能小于预计活动开始时间','info');
		    	return false;
		    }
		    if(oldTime-newTime>0){
		    	$.messager.alert('提示','活动开始时间不能小于活动预计开始时间','info');
		    	return false;
		    }
		    if(oldTime1-newTime1<0){
		    	$.messager.alert('提示','活动结束时间不能大于活动预计结束时间','info');
		    	return false;
		    }
		    $(obj).linkbutton('disable');
		},
		success:function(data){
			var data =eval('('+data+')');
	    	if (data.code== 0) {
	    		alert(data.msg);
	    		$(obj).linkbutton('enable');
	    	}else if(data.code== 1){
	    		alert(data.msg);
	    		$(obj).linkbutton('enable');
	    	}
		}
	});
}
