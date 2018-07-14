var saleactivity = {};

saleactivity.pageId="#list_sale_activity";
saleactivity.list_panel = saleactivity.pageId + " #activity_list_panel";
saleactivity.edit_panel = saleactivity.pageId + " #edit_panel";
saleactivity.check_panel = saleactivity.pageId + " #check_panel";
saleactivity.dgId=saleactivity.list_panel + " #dg";
saleactivity.toolBar = saleactivity.pageId + ' #toolbar';
saleactivity.query = saleactivity.list_panel + " #activity_list_query";
saleactivity.reset = saleactivity.list_panel + " #activity_list_reset";
saleactivity.add=saleactivity.list_panel+" #activity_list_btnAdd";
saleactivity.Edit=saleactivity.list_panel+" #activity_list_btnEdit";
saleactivity.Del=saleactivity.list_panel+" #activity_list_btnDel";
saleactivity.searchForm = saleactivity.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
saleactivity.inits = function() {
	$(saleactivity.dgId).datagrid({
		url:'saleactivity/listloadData',
		striped : true,
		height : document.documentElement.clientHeight * 0.86,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		toolbar : saleactivity.toolBar,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		columns : [ [{
			field : 'action',
			title : '操作',
			align :'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.status==0)
					{
					return '<a href="#" onclick="saleactivity.check(\'' + row.activityId + '\');">审核</a>';
					}else if(row.status==1){
						return '<a href="#" onclick="saleactivity.stop(\'' + row.activityId + '\');">终止活动</a>';
					}else{
						return '<a href="#" onclick="saleactivity.view(\'' + row.activityId + '\');">查看</a>';
					}
			}
		},{
			field : 'activityId',
			title : '促销活动号',
			align:'center',
			width:80,
		},{
			field : 'activityName',
			title : '促销活动名称',
			align:'center',
			width:100,
		},{
			field : 'channelCode',
			title : '渠道代码',
			align:'center',
			width:80,
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
			field : 'billOrgCode',
			title : '单据机构代码',
			align:'center',
			width:100,
		},{
			field : 'createId',
			title : '制单人ID',
			align:'center',
			width:100,
		},{
			field : 'createName',
			title : '制单人名称',
			align:'center',
			width:100,
		},{
			field : 'createTime',
			title : '制单时间',
			align:'center',
			width:180,
		},{
			field : 'checkId',
			title : '审核人ID',
			align :'center',
			width:80,
		},{
			field : 'checkName',
			title : '审核人名称',
			align : 'center',
			width:100,
		},{
			field : 'checkTime',
			title : '审核时间',
			align : 'center',
			width:180,
		},{
			field : 'endId',
			title : '终止人ID',
			align : 'center',
			width:80,
		},{
			field : 'endName',
			title : '终止人名称',
			align : 'center',
			width:100,
		},{
			field : 'endTime',
			title : '终止时间',
			align : 'center',
			width:180,
		},{
			field : 'status',
			title : '状态',
			align : 'center',
			width:100,
			formatter : function(value, row, index) {
				if(row.status==0)
					{
					return "已录入";
					}else if(row.status==1){
						return "审核通过";
					}else{
						return "活动已终止";
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
	$(saleactivity.query).on("click", function() {
		$(saleactivity.dgId).datagrid("load", $.o2m.serializeObject($(saleactivity.searchForm)));
	});
	//重置
	$(saleactivity.reset).on("click", function() {
		$(saleactivity.searchForm).form("clear");
	});
	// 添加
	$(saleactivity.add).on("click", function() {
		$(saleactivity.list_panel).hide();
		$(saleactivity.edit_panel).panel({title:'添加',href:"saleactivity/toAdd",height : $.o2m.centerHeight - 20});
		$(saleactivity.edit_panel).panel('open');
	});
	
	// 修改
	$(saleactivity.Edit).on("click", function() {
		var row=$(saleactivity.dgId).datagrid("getSelected");
		if(row){
			if(row.status==0){
			$(saleactivity.list_panel).hide();
			$(saleactivity.edit_panel).panel({title:'修改',href:"saleactivity/toEdit?activityId="+row.activityId,height : $.o2m.centerHeight - 20});
			$(saleactivity.edit_panel).panel('open');}
			else{
				$.messager.alert('警告', '已通过审核不能修改!', 'warning');
			}
		}else{
			$.messager.alert('警告', '请选择一条记录!', 'warning');
		}
	});
	//保存
	saleactivity.save=function(){
		if(!$(saleactivity.edit_panel).find('form').form('enableValidation').form('validate')){
			 return false;
			}
		   var activity={};
		   activity.activityId=$(saleactivity.edit_panel+" #activityId").val();
		   activity.activityName=$(saleactivity.edit_panel+" #activityName").val();
		   activity.startDate=$(saleactivity.edit_panel+" #startDate").datebox('getValue'); 
		   activity.endDate=$(saleactivity.edit_panel+" #endDate").datebox('getValue'); 
		   activity.billOrgCode =$(saleactivity.edit_panel+" #billOrgCode").val();
		 $.ajax({
				type : "POST",
				url : "saleactivity/save",
				dataType : "json",
				contentType : "application/json",
				data : JSON.stringify(activity),
				success : function(result) {
					if($.o2m.handleActionResult(result)){
						$(saleactivity.edit_panel).panel('close');
						$(saleactivity.dgId).datagrid("reload");
						$(saleactivity.list_panel).show();
					}
				}
			 }); 
	};
	// 删除
	$(saleactivity.Del).on("click", function() {
		var row = $(saleactivity.dgId).datagrid("getSelected");
		if (row) {
			$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
				if (r) {
					$.ajax({
						type : "POST",
						url : "saleactivity/delete",
						data : "activityId=" + row.activityId,
						success : function(result) {
							if($.o2m.handleActionResult(result)){
								$(saleactivity.dgId).datagrid("reload");
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('警告', '请选择一条记录!', 'warning');
		}
	});

	/**
	 * 从Panel页面返回到列表页面
	 */
	saleactivity.returnToListPage = function() {
		$(saleactivity.edit_panel).panel('close');
		$(saleactivity.check_panel).panel('close');
		$(saleactivity.dgId).datagrid("reload");
		$(saleactivity.list_panel).show();
	};
	//审核
	saleactivity.check = function(activityId){
		$(saleactivity.list_panel).hide();
		$(saleactivity.check_panel).panel({title:'审核',href:"saleactivity/toCheck?activityId="+activityId,height : $.o2m.centerHeight - 20});
		$(saleactivity.check_panel).panel('open');
	};
	//审核通过
	saleactivity.checkPass= function(activityId){
		var activityId=$(saleactivity.check_panel+" #activityId").val();
		$.ajax({
			type : "POST",
			url : "saleactivity/checkPass?activityId="+activityId,
			dataType : "json",
			contentType : "application/json",
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(saleactivity.check_panel).panel('close');
					$(saleactivity.dgId).datagrid("reload");
					$(saleactivity.list_panel).show();
				}
			}
		}); 
	};
	//去终止活动页面
	saleactivity.stop = function(activityId){
		$(saleactivity.list_panel).hide();
		$(saleactivity.check_panel).panel({title:'终止活动',href:"saleactivity/toCheck?activityId="+activityId,height : $.o2m.centerHeight - 20});
		$(saleactivity.check_panel).panel('open');
	};
	//终止
	saleactivity.Stop= function(activityId){
		var activityId=$(saleactivity.check_panel+" #activityId").val();
		$.ajax({
			type : "POST",
			url : "saleactivity/checkPass?activityId="+activityId,
			dataType : "json",
			contentType : "application/json",
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(saleactivity.check_panel).panel('close');
					$(saleactivity.dgId).datagrid("reload");
					$(saleactivity.list_panel).show();
				}
			}
		}); 
	};
	saleactivity.view = function(activityId){
		$(saleactivity.list_panel).hide();
		$(saleactivity.edit_panel).panel({title:'查看',href:"saleactivity/toCheck?activityId="+activityId,height : $.o2m.centerHeight - 20});
		$(saleactivity.edit_panel).panel('open');
	};
	
	
	
saleactivity.inits();
