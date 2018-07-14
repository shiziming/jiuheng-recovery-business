var coupontype = {};

coupontype.pageId="#list_coupontype";
coupontype.list_panel = coupontype.pageId + " #coupontype_list_panel";
coupontype.edit_panel = coupontype.pageId + " #edit_panel";
coupontype.dgId=coupontype.list_panel + " #dg";
coupontype.toolBar = coupontype.pageId + ' #toolbar';
coupontype.query = coupontype.list_panel + " #coupon_list_query";
coupontype.reset = coupontype.list_panel + " #coupon_list_reset";
coupontype.add=coupontype.list_panel+" #coupon_list_btnAdd";
coupontype.Edit=coupontype.list_panel+" #coupon_list_btnEdit";
coupontype.searchForm = coupontype.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
coupontype.inits = function() {
	$(coupontype.dgId).datagrid({
		url:'coupontype/listloadData',
		striped : true,
		height : document.documentElement.clientHeight * 0.86,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		toolbar : coupontype.toolBar,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		columns : [ [{
			field : 'couponTypeId',
			title : '优惠券类型',
			align:'center',
			width:80,
		},{
			field : 'couponName',
			title : '优惠券名称',
			align:'center',
			width:100,
		},{
			field : 'virCoupon',
			title : '虚拟券标记',
			align:'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.virCoupon==0)
					{
					return "否";
					}else if(row.virCoupon==1){
						return "是";
					}
			}
		},{
			field : 'numCoupon',
			title : '编号券标记',
			align:'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.numCoupon==0)
					{
					return "否";
					}else if(row.numCoupon==1){
						return "是";
					}
			}
		},{
			field : 'sceneType',
			title : '使用场景类型',
			align:'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.sceneType==1)
					{
					return "支付";
					}else if(row.sceneType==2){
						return "折扣";
					}
			}
		},{
			field : 'usedlimit',
			title : '使用限制标记',
			align:'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.usedlimit==0)
					{
					return "否";
					}else if(row.usedlimit==1){
						return "是";
					}
			}
		},{
			field : 'accountType',
			title : '财务记账类型',
			align:'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.accountType==1)
					{
					return "记折扣";
					}else if(row.accountType==2){
						return "记费用";
					}
			}
		},{
			field : 'startDate',
			title : '开始日期',
			align:'center',
			width:100,
		},{
			field : 'endDate',
			title : '结束日期',
			align:'center',
			width:100,
		},{
			field : 'orgCode',
			title : '维护机构代码',
			align:'center',
			width:80,
		},{
			field : 'handlerId',
			title : '最后维护人ID',
			align :'center',
			width:80,
		},{
			field : 'handlerName',
			title : '最后维护人名称',
			align : 'center',
			width:100,
		},{
			field : 'status',
			title : '状态',
			align : 'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.status==0)
					{
					return "无效";
					}else if(row.status==1){
						return "有效";
					}
			}
		}] ],
		loadMsg : "数据加载中...",
		onLoadSuccess : function() {
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
		}
	});
};
    //条件查询
	$(coupontype.query).on("click", function() {
		$(coupontype.dgId).datagrid("load", $.o2m.serializeObject($(coupontype.searchForm)));
	});
	//重置
	$(coupontype.reset).on("click", function() {
		$(coupontype.searchForm).form("clear");
	});
	// 添加
	$(coupontype.add).on("click", function() {
		$(coupontype.list_panel).hide();
		$(coupontype.edit_panel).panel({title:'添加',href:"coupontype/toAdd",height : $.o2m.centerHeight - 20});
		$(coupontype.edit_panel).panel('open');
	});
	
	// 修改
	$(coupontype.Edit).on("click", function() {
		var row=$(coupontype.dgId).datagrid("getSelected");
		if(row){
			$(coupontype.list_panel).hide();
			$(coupontype.edit_panel).panel({title:'修改',href:"coupontype/toEdit?couponTypeId="+row.couponTypeId,height : $.o2m.centerHeight - 20});
			$(coupontype.edit_panel).panel('open');
		}else{
			$.messager.alert('警告', '请选择一条记录!', 'warning');
		}
	});
	//保存
	coupontype.save=function(){
		if(!$(coupontype.edit_panel).find('form').form('enableValidation').form('validate')){
			 return false;
			}
		   var coupon={};
		   coupon.couponTypeId=$(coupontype.edit_panel+" #couponTypeId").val();
		   coupon.couponName=$(coupontype.edit_panel+" #couponName").val();
		   coupon.virCoupon=$(coupontype.edit_panel+ " #virCoupon:checked").val();
		   coupon.numCoupon=$(coupontype.edit_panel+ " #numCoupon:checked").val();
		   coupon.sceneType=$(coupontype.edit_panel+ " #sceneType").combobox('getValue');
		   coupon.usedlimit=$(coupontype.edit_panel+ " #usedlimit:checked").val();
		   coupon.accountType=$(coupontype.edit_panel+ " #accountType").combobox('getValue');
		   coupon.startDate=$(coupontype.edit_panel+" #startDate").datebox('getValue'); 
		   coupon.endDate=$(coupontype.edit_panel+" #endDate").datebox('getValue'); 
		   coupon.status=$(coupontype.edit_panel+ " #status:checked").val();
		   if(coupon.virCoupon==null){
			   $.messager.alert('警告', '虚拟券标记不能为空!', 'warning');
			   return;
		   }
		   if(coupon.numCoupon==null){
			   $.messager.alert('警告', '编号券标记不能为空!', 'warning');
			   return;
		   }
		   if(coupon.usedlimit==null){
			   $.messager.alert('警告', '使用限制标记不能为空!', 'warning');
			   return;
		   }
		   if(coupon.status==null){
			   $.messager.alert('警告', '状态不能为空!', 'warning');
			   return;
		   }
		   
		    var arys1= new Array();     
			var arys3= new Array();     
		    arys1=coupon.startDate.split('-');
		    arys3=coupon.endDate.split('-');
		    var startTime=arys1[0]+arys1[1]+arys1[2];
		    var endTime=arys3[0]+arys3[1]+arys3[2];
		    if(startTime-endTime>0){
		    	$.messager.alert('提示','优惠券开始时间不能大于结束时间','info');
		    	return false;
		    }
		   
		 $.ajax({
				type : "POST",
				url : "coupontype/save",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(coupon),
				success : function(result) {
					if($.o2m.handleActionResult(result)){
						$(coupontype.edit_panel).panel('close');
						$(coupontype.dgId).datagrid("reload");
						$(coupontype.list_panel).show();
					}
				}
			 }); 
	};

	/**
	 * 从Panel页面返回到列表页面
	 */
	coupontype.returnToListPage = function() {
		$(coupontype.edit_panel).panel('close');
		$(coupontype.dgId).datagrid("reload");
		$(coupontype.list_panel).show();
	};
coupontype.inits();
