var gmplusOrderQuery = {};

gmplusOrderQuery.pageId="#gmplus_order_index";
gmplusOrderQuery.list_panel = gmplusOrderQuery.pageId + " #list_panel";
gmplusOrderQuery.viewpanel = gmplusOrderQuery.pageId + " #view_panel";
gmplusOrderQuery.dgId=gmplusOrderQuery.list_panel + " #dg";
gmplusOrderQuery.query = gmplusOrderQuery.list_panel + " #list_query";
gmplusOrderQuery.reset = gmplusOrderQuery.list_panel + " #list_reset";
gmplusOrderQuery.searchForm = gmplusOrderQuery.list_panel + " #searchForm";
gmplusOrderQuery.tb = gmplusOrderQuery.list_panel + " #tb";
gmplusOrderQuery.exportBtn = gmplusOrderQuery.tb + " #order_index_exportBtn";
gmplusOrderQuery.exportWin = gmplusOrderQuery.list_panel + " #gmplusExportBtn";
gmplusOrderQuery.gmplusCreatReverseOrderBut = gmplusOrderQuery.tb + " #gmplusCreatReverseOrder";
gmplusOrderQuery.gmplusCreatReverseOrder = gmplusOrderQuery.list_panel+" #gmplusOrder_index_creatReverseOrder";

/**
 * 页面初始化函数
 */
gmplusOrderQuery.inits = function() {
	//var currentDate = new Date();
	//$(gmplusOrderQuery.list_panel+" #tjsj2").datebox('setValue',currentDate.getFullYear()+"-"+(currentDate.getMonth()+1)+"-"+currentDate.getDate());
	$(gmplusOrderQuery.dgId).datagrid({
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
				return '<a href="#" onclick="gmplusOrderQuery.view(\'' + value+'\',\''+row.xsddh + '\');">'+value+'</a>';
				
				//return value;
			}
		},{
			field : 'xsfdlx',
			title : '类型',
			align:'center',
			width:50,
			formatter:function(value){
				return gmplusOrderQuery.changeOrderTypeToName(value);
			}
		},{
				field : 'status',
				title : '状态',
				align:'center',
				width:50
		},{
			field : 'fstatus',
			title : '状态-隐藏域',
			align:'center',
			width:50,
			hidden:true
		}]],
		columns:[ [{
			field : 'xsddh',
			title : '主单号',
			align:'center',
			width:100,
		},
		/*{
			field : 'bstatus',
			title : '主单状态',
			align:'center',
			width:100,
		},*/
		{
			field : 'yxsfdh',
			title : '原分单号',
			align:'center',
			width:80,
			formatter:function(value,row){
				if(value<=0)
					return "";
				else
					return '<a href="#" onclick="gmplusOrderQuery.view(\'' + value+'\',\''+((value-value%1000)/1000) + '\');">'+value+'</a>';
			}
		},{
			field : 'skuid',
			title : '商品SKUID',
			align:'center',
			width:100,
		},{
			field : 'spjg',
			title : '商品价格',
			align:'center',
			width:60,
			formatter:function(value){
				return (value/100).toFixed(2);
			}
		},{
			field : 'wlpslx',
			title : '是否3C',
			align:'center',
			width:80,
			formatter:function(value){
				if(value=='2'){
					return "是";
				}else if(value=='1'||value=='0'){
					return "否";
				}
			}
		},{
			field : 'wbxsddh',
			title : '订单编号',
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
			field : 'ddttsj',
			title : '妥投时间',
			align:'center',
			width:100,
		},{
			field : 'shrmc',
			title : '收货人',
			align:'center',
			width:50,
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
		toolbar:gmplusOrderQuery.tb,
		onLoadSuccess : function() {
			$('#searchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(gmplusOrderQuery.query).on("click", function() {
		if($(gmplusOrderQuery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(gmplusOrderQuery.searchForm));
			$(gmplusOrderQuery.dgId).datagrid({url:'gmplusOrder/list', queryParams:o});
			$(gmplusOrderQuery.exportWin).linkbutton('enable');
			$(gmplusOrderQuery.exportBtn).linkbutton('enable');
			$(gmplusOrderQuery.gmplusCreatReverseOrderBut).linkbutton('enable');
		}
	});
	$(gmplusOrderQuery.reset).on("click", function() {
		$(gmplusOrderQuery.searchForm).form("clear");
	});
	
	
	gmplusOrderQuery.view = function(xsfdh,xsddh){
		$(gmplusOrderQuery.list_panel).hide();
		$(gmplusOrderQuery.viewpanel).panel({title:'订单详情查看',href:"gmplusOrder/viewOrderInfo?xsfdh="+xsfdh+"&xsddh="+xsddh});
		$(gmplusOrderQuery.viewpanel).panel('open');
	};
	
	gmplusOrderQuery.changeOrderTypeToName= function(value){
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
	gmplusOrderQuery.changeOrderStatusToName= function(xsfdlx,status){
		
		$.post("order/getOrderStatus/"+xsfdlx+"/"+status,{},function(result){
		    return status;
		  });
	};
	/**
	 * 根据支付方式ID置换名称
	 */
	gmplusOrderQuery.changeOrderPayMethodId=function(value){
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
	gmplusOrderQuery.exportExcel=function(version){
		//var o = $.o2m.serializeObject($(gmplusOrderQuery.searchForm));
		//o["version"] = version;
	    window.open ( 'gmplusOrder/export?version='+version+"&"+ encodeURI($(gmplusOrderQuery.searchForm).serialize())  );
	    $('#order_index_exportWin').window('close');
	};
	
	/**
	 * 创建逆向单
	 */
	gmplusOrderQuery.creatReverseOrder=function(){
		var selectedRow = $(gmplusOrderQuery.dgId).datagrid('getSelections');
		// 没选择数据时，显示告警，返回
		if (selectedRow.length != 1) {
			$.messager.show({
				title: '警告',
				msg: '请选择一条记录创建订单',
				showType: 'slide',
				timeout: 2000,
				style:{
					right:'',
					top:document.body.scrollTop+document.documentElement.scrollTop,
					bottom:''
				}
			});		
			return false;
		}
		var data = $(gmplusOrderQuery.dgId).datagrid("getChecked")[0];
		$('#gmplusOrder_index_creatReverseOrder').window({
            width: 350,
            height: 220,
            modal: true,
            method:'post',
            href: "gmplusOrder/openCreatReverseOrderWindow?xsddh="+data.xsddh+"&xsfdh="+data.xsfdh+"&xsfdlx="+data.xsfdlx+"&fstatus="+data.fstatus,
            title: "创建逆向订单确认"
        });
		$('#gmplusOrder_index_creatReverseOrder').window('open');
	}
	
	
gmplusOrderQuery.inits();
