var splc_goods_up_view = {};

splc_goods_up_view.pageId="#goods_up_view_page11";
splc_goods_up_view.dgId=splc_goods_up_view.pageId+" #dg";
splc_goods_up_view.djbh=splc_goods_up_view.pageId+" #djbh";
splc_goods_up_view.up_panel   = splc_goods_up_view.pageId + " #up_panel";
/**
 * 页面初始化函数
 */
splc_goods_up_view.inits = function() {

		$(splc_goods_up_view.dgId).datagrid({
			title : "单据明细",
			url : "wareFloor/getLcflInfo",
			striped : true,
			rownumbers : true,
			fitColumns : true,
			columns : [ [ {
				field : 'DJBH',
				title : '单据编号',
				align:'center',
				width : 50 
			}, {
				field : 'SPFLMC',
				title : '楼层分类',
				align : 'center',
				width : 40
			}, {
				field : 'XSXH',
				title : '排序',
				align : 'center',
				width : 120
			}, {
				field : 'LCWZLX',
				title : '类型',
				align : 'center',
				width : 30
			}, {
				field : 'XSZZDM',
				title : '销售组织',
				align : 'center',
				width : 20
			}, {
				field : 'SKUID',
				title : 'SKUID',
				align : 'center',
				width : 50
			},
			{
				field : 'SPPTFLDM',
				title : '楼层CODE',
				align : 'center',
				width : 0,
				hidden : "true"
			}
			] ],
			onBeforeLoad :function(param) {
				param.billId=$(splc_goods_up_view.djbh).val();
			}
		});
};
	
splc_goods_up_view.check = function(flag){
	//alert($(splc_goods_up_view.dgId).datagrid('getRows').length);
	if($(splc_goods_up_view.dgId).datagrid('getRows').length<3){
		$.messager.alert('消息提示','楼层没有添满，不能少于三个','inof');
		return false;
	}
	if($(splc_goods_up_view.dgId).datagrid('getRows').length>8){
		$.messager.alert('消息提示','楼层已加满，不能超过8个','inof');
		return false;
	}
	
	var billId = $(splc_goods_up_view.djbh).val();
	$.ajax({ 
        type:"POST", 
        url:"wareFloor/checkUp",
        data:{
        	billId : billId,
        	flag : flag
        },
        success:function(msg){
        	if(msg=='success'){
	        	parent.$.messager.alert('','审核成功！',null,function(){
	        		splc_goods_up_view.back_list();
	        	});
        	}else if(msg=='error'){
        		parent.$.messager.alert('','审核失败！', msg, function(){
        			
        		});
        	}
        }
    }); 
}

splc_goods_up_view.update=function(){
	
	
	var rows = $(splc_goods_up_view.dgId).datagrid("getSelections");	
	if (rows.length==0) {
		$.messager.alert('警告', '请至少选择一条记录!', 'warning');
	} else if (rows.length>1) {
		$.messager.alert('警告', '请选择一条记录!', 'warning');
	} else {
	 var djbh= rows[0].DJBH;
	 var spptfldm = rows[0].SPPTFLDM;
	 //alert(djbh);
	 // alert(spptfldm);
		$(splc_goods_up_view.pageId).hide();
		$(splc_goods_up_list.up_panel).panel({href:"wareFloor/getLcflDetail?djbh="+djbh+"&spptfldm="+spptfldm});
		$(splc_goods_up_list.up_panel).show();
	}
	
		
}
splc_goods_up_view.back_list=function(){
	$(splc_goods_up_view.pageId).hide();
	$(splc_goods_up_list.list_panel).show();
	$(splc_goods_up_list.dgId).datagrid('reload');
}

splc_goods_up_view.back=function(){
	$(splc_goods_up_view.pageId).hide();
	$(splc_goods_up_list.list_panel).show();
}

splc_goods_up_view.go_up = function(){
	//alert($(splc_goods_up_view.dgId).datagrid('getRows').length);
	if($(splc_goods_up_view.dgId).datagrid('getRows').length>7){
		$.messager.alert('消息提示','楼层已经添满8个，不能再继续添加','inof');
		return false;
	}
	//alert("3333");
		//$(splc_goods_up_view.pageId).hide();
	var billId = $(splc_goods_up_view.djbh).val();
		$(splc_goods_up_list.up_panel).panel({title:'新增楼层信息',href:"wareFloor/getLcflDetailByAdd?djbh="+billId});
		$(splc_goods_up_list.up_panel).panel('open');
		
		
	};


splc_goods_up_view.inits();

