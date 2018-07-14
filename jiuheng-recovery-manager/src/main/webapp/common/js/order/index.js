var orderquery = {};

orderquery.pageId="#order_index";
orderquery.list_panel = orderquery.pageId + " #list_panel";
orderquery.viewpanel = orderquery.pageId + " #view_panel";
orderquery.dgId=orderquery.list_panel + " #dg";
orderquery.query = orderquery.list_panel + " #list_query";
orderquery.reset = orderquery.list_panel + " #list_reset";
orderquery.searchForm = orderquery.list_panel + " #searchForm";
orderquery.tb = orderquery.list_panel + " #tb";
orderquery.exportBtn = orderquery.tb + " #exportBtn";
orderquery.exportWin = orderquery.list_panel + " #exportWin";
/**
 * 页面初始化函数
 */
orderquery.inits = function() {
	//var currentDate = new Date();
	//$(orderquery.list_panel+" #tjsj2").datebox('setValue',currentDate.getFullYear()+"-"+(currentDate.getMonth()+1)+"-"+currentDate.getDate());
	$(orderquery.dgId).datagrid({
		striped : true,
//		height : document.documentElement.clientHeight * 0.76,
		height : $.o2m.centerHeight - 175,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		url : 'order/list',
		columns:[ [{
			field : 'orderId',
			title : '订单号',
			align:'center',
			width:100/*,
			formatter:function(value,row){
				return '<a href="#" onclick="orderquery.view(\'' + value + '\');">'+value+'</a>';
			}*/
		},{
			field : 'orderType',
			title : '订单类型',
			align:'center',
			width:50,
			formatter:function(value){
				return orderquery.changeOrderTypeToName(value);
			}
		},{
				field : 'status',
				title : '状态',
				align:'center',
				width:100
		},{
			field : 'userName',
			title : '用户名',
			align:'center',
			width:50,
		},{
			field : 'userPhone',
			title : '用户电话',
			align:'center',
			width:100,
		},{
			field : 'userAdd',
			title : '用户地址',
			align:'center',
			width:100,
		},{
			field : 'goodsName',
			title : '商品',
			align:'center',
			width:80,
		},{
			field : 'valuationPrice',
			title : '估价金额',
			align:'center',
			width:70,
			formatter:function(value){
				return (value/100).toFixed(2);
			}
		},{
			field : 'dealPrice',
			title : '成交金额',
			align:'center',
			width:70,
			formatter:function(value){
				return (value/100).toFixed(2);
			}
		},{
			field : 'freightPrice',
			title : '运费金额',
			align:'center',
			width:60,
			formatter:function(value,row){
				return (value/100).toFixed(2);
			}
		},{
			field : 'payType',
			title : '支付方式',
			align:'center',
			width:60,
			formatter:function(value,row){
				return orderquery.changeOrderPayMethodId(value);
			}
		},{
			field : 'onDoorTime',
			title : '上门时间',
			align:'center',
			width:135
		},{
			field : 'subTime',
			title : '提交时间',
			align:'center',
			width:135
		},{
			field : 'payTime',
			title : '支付时间',
			align:'center',
			width:135
		},{
			field : 'message',
			title : '留言',
			align:'center',
			width:135
		},{
			field : 'action',
			title : '操作',
			width : 120,
			align:'left',
			formatter : function(value, row, index) {
					return '<a href="#" onclick="indexGoodsManage.view(\'' + row.orderNum + '\');">查看</a>'+
							' <a href="#" onclick="indexGoodsManage.editGoods(\'' + row.orderNum + '\');">修改</a>'+
							' <a href="#" onclick="indexGoodsManage.del(\'' + row.orderNum + '\');">删除</a>';
			}
		}] ],
		toolbar:orderquery.tb,
		onLoadSuccess : function() {
			$('#searchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(orderquery.query).on("click", function() {
		if($(orderquery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(orderquery.searchForm));
			$(orderquery.dgId).datagrid({url:'order/list', queryParams:o});
			$(orderquery.exportBtn).linkbutton('enable');
		}
	});
	$(orderquery.reset).on("click", function() {
		$(orderquery.searchForm).form("clear");
	});
	
	
	orderquery.view = function(xsfdh){
		$(orderquery.list_panel).hide();
		$(orderquery.viewpanel).panel({title:'订单详情查看',href:"order/viewOrderInfo?xsfdh="+xsfdh});
		$(orderquery.viewpanel).panel('open');
	};
	
	orderquery.changeOrderTypeToName= function(value){
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
	orderquery.changeOrderStatusToName= function(xsfdlx,status){
		
		$.post("order/getOrderStatus/"+xsfdlx+"/"+status,{},function(result){
		    return status;
		  });
	};
	/**
	 * 根据支付方式ID置换名称
	 */
	orderquery.changeOrderPayMethodId=function(value){
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
	orderquery.exportExcel=function(version){
		//var o = $.o2m.serializeObject($(orderquery.searchForm));
		//o["version"] = version;
	    window.location.href = 'order/export?version='+version+"&"+ encodeURI($(orderquery.searchForm).serialize());
	    $('#order_index_exportWin').window('close');
	};
	
	
orderquery.inits();
