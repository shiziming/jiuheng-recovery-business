var indexGoodsSalAgencyCode = {};

/**
 * 页面初始化函数
 */

indexGoodsSalAgencyCode.back=function(){
	var orderNum= $("#orderNum").val();
	$(indexGoods_detailed.choice_salAgencyCode_panel).panel("close");
	$(indexGoodsManage.searchAndAuditing).panel({href:"wdIndexGoodsController/toSearcherDetailedWomdow?orderNum="+orderNum});
	$(indexGoods_detailed.dgId).datagrid('reload')
}
indexGoodsSalAgencyCode.downloadTemplate=function(){
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("首页爆款销售组织导入模板");
}
indexGoodsSalAgencyCode.add=function(){
	var curForm = $('#checkSalAgencyCode_form');
	$.o2m.showProgressing();
	curForm.form('submit',{
		url:'wdIndexGoodsController/maintainSaleOrgCode',
		onSubmit: function () {
		},
	    success:function(data) {
	    	$.o2m.closeProgressing();
	    	var result = $.parseJSON(data);
	    	if(result.code==0){
				$.messager.alert("提示",result.msg,"success")
			}else if(result.code==1){
				$.messager.alert("警告",result.msg,"info")
			}
	    }
	});
	
}

indexGoodsSalAgencyCode.checkAll=function(){
	$('input[name=saleOrgCode]').each(function(){
		var main = $(this);
		main.is(':checked')?main.attr('checked',false):main.attr('checked',true);
	})
}



indexGoodsSalAgencyCode.uploadSalAgencyCode=function(obj){
	var fileaa = $('input[name=fileimport]').val();
	if (fileaa.lastIndexOf('.xls') == "-1") {
		$.messager.alert("操作提示","请选择excel格式文件","warning");
		return;
	}
	var curForm = $('#checkSalAgencyCode_form');
	curForm.form('submit',{
		url:'common/import/uploadSalAgencyCode',
		onSubmit: function () {
			$(obj).linkbutton('disable');
		},
	    success:function(data) {
	    	var result = $.parseJSON(data);
	    	if(result.code==1){
	    		$.messager.alert("警告",result.msg,"info")
	    		return false;
	    	}
	    	var arys1=[];
	    	arys1=result.data;
	    	$('input[name=saleOrgCode]').each(function(){
	    		var main=$(this);
	    		var saleOrgCode=($(this).val());
	    		$.map(arys1, function(d) {
	    			if(d==saleOrgCode){
	    			main.attr("checked",'true');
	    			}
	    		});
	    		});
	    }
	});
}