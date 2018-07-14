var mdsmOrderQuery = {};

mdsmOrderQuery.pageId="#mdsm_order_index";
mdsmOrderQuery.list_panel = mdsmOrderQuery.pageId + " #list_panel";
mdsmOrderQuery.viewpanel = mdsmOrderQuery.pageId + " #view_panel";
mdsmOrderQuery.dgId=mdsmOrderQuery.list_panel + " #dg";
mdsmOrderQuery.query = mdsmOrderQuery.list_panel + " #list_query";
mdsmOrderQuery.reset = mdsmOrderQuery.list_panel + " #list_reset";
mdsmOrderQuery.searchForm = mdsmOrderQuery.list_panel + " #searchForm";
mdsmOrderQuery.tb = mdsmOrderQuery.list_panel + " #tb";
mdsmOrderQuery.exportBtn = mdsmOrderQuery.tb + " #mdsmExportBtn";
mdsmOrderQuery.exportWin = mdsmOrderQuery.list_panel + " #exportWin";
/**
 * 页面初始化函数
 */
mdsmOrderQuery.inits = function() {
	//var currentDate = new Date();
	//$(mdsmOrderQuery.list_panel+" #tjsj2").datebox('setValue',currentDate.getFullYear()+"-"+(currentDate.getMonth()+1)+"-"+currentDate.getDate());
	$(mdsmOrderQuery.dgId).datagrid({
		striped : true,
//		height : document.documentElement.clientHeight * 0.76,
		height : $.o2m.centerHeight - 205,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		frozenColumns:[[{
			field : 'xsfdh',
			title : '分单号',
			align:'center',
			width:100,
			formatter:function(value,row){
				return '<a href="#" onclick="mdsmOrderQuery.view(\'' + value+'\',\''+row.xsddh + '\');">'+value+'</a>';
				
				//return value;
			}
		},{
			field : 'xsfdlx',
			title : '类型',
			align:'center',
			width:50,
			formatter:function(value){
				return mdsmOrderQuery.changeOrderTypeToName(value);
			}
		},{
				field : 'status',
				title : '状态',
				align:'center',
				width:100
		}]],
		columns:[ [{
			field : 'xsddh',
			title : '主单号',
			align:'center',
			width:100,
		},{
			field : 'mddm',
			title : '门店代码',
			align:'center',
			width:80,
		},{
			field : 'wlpslx',
			title : '是否3C',
			align:'center',
			width:80,
			formatter:function(value){
				if(value=='2'){
					return "是";
				}else {
					return "否";
				}
			}
		},{
			field : 'sapddh',
			title : '金力销售编号',
			align:'center',
			width:100,
		},{
			field : 'spkclx1',
			title : '库存类型',
			align:'center',
			width:100,
		},{
			field : 'ddcjje',
			title : '成交金额',
			align:'center',
			width:60,
			formatter:function(value){
				return (value/100).toFixed(2);
			}
		},{
			field : 'ddpsf',
			title : '运费',
			align:'center',
			width:60,
			formatter:function(value,row){
				return (value/100).toFixed(2);
			}
		},{
			field : 'ddfhsj',
			title : '发货时间',
			align:'center',
			width:100,
		},{
			field : 'shrmc',
			title : '收货人',
			align:'center',
			width:80,
		},{
			field : 'shrdh1',
			title : '电话',
			align:'center',
			width:100,
		},{
			field : 'tjsj',
			title : '提交时间',
			align:'center',
			width:150
		},{
			field : 'zfsj',
			title : '支付时间',
			align:'center',
			width:150
		}] ],
		toolbar:mdsmOrderQuery.tb,
		onLoadSuccess : function() {
			$('#searchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(mdsmOrderQuery.query).on("click", function() {
		if($(mdsmOrderQuery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(mdsmOrderQuery.searchForm));
			$(mdsmOrderQuery.dgId).datagrid({url:'mdsmQueryOrder/queryList', queryParams:o});
			$(mdsmOrderQuery.exportBtn).linkbutton('enable');
		}
	});
	$(mdsmOrderQuery.reset).on("click", function() {
		$(mdsmOrderQuery.searchForm).form("clear");
	});
	
	
	mdsmOrderQuery.view = function(xsfdh,xsddh){
		$(mdsmOrderQuery.list_panel).hide();
		$(mdsmOrderQuery.viewpanel).panel({title:'订单详情查看',href:"mdsmQueryOrder/viewOrderInfo?xsfdh="+xsfdh+"&xsddh="+xsddh});
		$(mdsmOrderQuery.viewpanel).panel('open');
	};
	
	mdsmOrderQuery.changeOrderTypeToName= function(value){
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
	mdsmOrderQuery.changeOrderStatusToName= function(xsfdlx,status){
		
		$.post("order/getOrderStatus/"+xsfdlx+"/"+status,{},function(result){
		    return status;
		  });
	};
	/**
	 * 根据支付方式ID置换名称
	 */
	mdsmOrderQuery.changeOrderPayMethodId=function(value){
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
	mdsmOrderQuery.exportExcel=function(version){
		//var o = $.o2m.serializeObject($(mdsmOrderQuery.searchForm));
		//o["version"] = version;
	    window.location.href = 'mdsmQueryOrder/export?version='+version+"&"+ encodeURI($(mdsmOrderQuery.searchForm).serialize());
	    $('#mdsm_order_index_exportWin').window('close');
	};
	
	
mdsmOrderQuery.inits();
