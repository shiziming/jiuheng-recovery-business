var userquery = {};

userquery.pageId="#user_index";
userquery.list_panel = userquery.pageId + " #list_panel";
userquery.viewpanel = userquery.pageId + " #view_panel";
userquery.dgId=userquery.list_panel + " #dg";
userquery.query = userquery.list_panel + " #list_query";
userquery.reset = userquery.list_panel + " #list_reset";
userquery.searchForm = userquery.list_panel + " #searchForm";
userquery.tb = userquery.list_panel + " #tb";
userquery.exportBtn = userquery.tb + " #exportBtn";
userquery.exportWin = userquery.list_panel + " #exportWin";
/**
 * 页面初始化函数
 */
userquery.inits = function() {
	//var currentDate = new Date();
	//$(userquery.list_panel+" #tjsj2").datebox('setValue',currentDate.getFullYear()+"-"+(currentDate.getMonth()+1)+"-"+currentDate.getDate());
	$(userquery.dgId).datagrid({
		striped : true,
//		height : document.documentElement.clientHeight * 0.76,
		height : $.o2m.centerHeight - 175,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		url : 'user/list',
		columns:[ [{
			field : 'userId',
			title : '用户id',
			align:'center',
		},{
			field : 'userName',
			title : '用户名称',
			align:'center',
		},{
			field : 'name',
			title : '昵称',
			align:'center',
		},{
			field : 'phone',
			title : '手机号',
			align:'center',
		},{
			field : 'bankCard',
			title : '银行卡号',
			align:'center',
		},{
			field : 'createTime',
			title : '注册时间',
			align:'center',
		}/*,{
			field : 'action',
			title : '操作',
			align:'left',
			formatter : function(value, row, index) {
					return '<a href="#" onclick="indexGoodsManage.view(\'' + row.userId + '\');">查看</a>'+
							' <a href="#" onclick="indexGoodsManage.editGoods(\'' + row.userId + '\');">修改</a>'+
							' <a href="#" onclick="indexGoodsManage.del(\'' + row.userId + '\');">删除</a>';
			}
		}*/] ],
		toolbar:userquery.tb,
		onLoadSuccess : function() {
			$('#searchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(userquery.query).on("click", function() {
		if($(userquery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(userquery.searchForm));
			$(userquery.dgId).datagrid({url:'user/list', queryParams:o});
			$(userquery.exportBtn).linkbutton('enable');
		}
	});
	$(userquery.reset).on("click", function() {
		$(userquery.searchForm).form("clear");
	});
	
	
	userquery.view = function(xsfdh){
		$(userquery.list_panel).hide();
		$(userquery.viewpanel).panel({title:'订单详情查看',href:"order/viewOrderInfo?xsfdh="+xsfdh});
		$(userquery.viewpanel).panel('open');
	};
	
	userquery.changeOrderTypeToName= function(value){
		if(value==0){
			return "销售";
		}else if(value==1){
			return "退款";
		}else if(value==2){
			return "冲红";
		}else if(value==3){
			return "拒收";
		}else if(value==4){
			return "退货";
		}else if(value==5){
			return "换货";
		} 
	};
	userquery.changeOrderStatusToName= function(xsfdlx,status){
		
		$.post("order/getOrderStatus/"+xsfdlx+"/"+status,{},function(result){
		    return status;
		  });
	};
	/**
	 * 根据支付方式ID置换名称
	 */
	userquery.changeOrderPayMethodId=function(value){
		if(value==11){
			return "支付宝";
		}else if(value==12){
			return "微信";
		}else  if(value==13){
			return "银联";
		}else  if(value==99){
			return "线下退款";
		}
	};
	userquery.exportExcel=function(version){
		//var o = $.o2m.serializeObject($(userquery.searchForm));
		//o["version"] = version;
	    window.location.href = 'order/export?version='+version+"&"+ encodeURI($(userquery.searchForm).serialize());
	    $('#order_index_exportWin').window('close');
	};
	
	
userquery.inits();
