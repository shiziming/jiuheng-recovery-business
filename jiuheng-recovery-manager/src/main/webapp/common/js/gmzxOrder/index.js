var gmzxOrderquery = {};

gmzxOrderquery.pageId="#gmzxOrder_index";
gmzxOrderquery.list_panel = gmzxOrderquery.pageId + " #gmzxList_panel";
gmzxOrderquery.viewpanel = gmzxOrderquery.pageId + " #gmzxView_panel";
gmzxOrderquery.creatPositiveOrderPanel = gmzxOrderquery.pageId + " #creatPositiveOrder";
gmzxOrderquery.dgId=gmzxOrderquery.list_panel + " #gmzxDg";
gmzxOrderquery.query = gmzxOrderquery.list_panel + " #gmzxList_query";
gmzxOrderquery.reset = gmzxOrderquery.list_panel + " #gmzxList_reset";
gmzxOrderquery.searchForm = gmzxOrderquery.list_panel + " #gmzxSearchForm";
gmzxOrderquery.tb = gmzxOrderquery.list_panel + " #gmzxTb";
gmzxOrderquery.gmzxExportBtn = gmzxOrderquery.tb + " #gmzxExportBtn";
gmzxOrderquery.gmzxCreatPositiveOrder = gmzxOrderquery.tb + " #gmzxCreatPositiveOrder";
gmzxOrderquery.gmzxCreatReverseKuCunBut = gmzxOrderquery.tb + " #gmzxCreatReverseKuCun";

/**
 * 页面初始化函数
 */
gmzxOrderquery.inits = function() {
	//var currentDate = new Date();
	//$(orderquery.list_panel+" #tjsj2").datebox('setValue',currentDate.getFullYear()+"-"+(currentDate.getMonth()+1)+"-"+currentDate.getDate());
	$(gmzxOrderquery.dgId).datagrid({
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
				return '<a href="#" onclick="gmzxOrderquery.view(\'' + row.xsfdh+'\',\''+ row.xsddh + '\');">'+value+'</a>';
			}
		},{
			field : 'xsfdlx',
			title : '分单类型',
			align:'center',
			width:50,
			formatter:function(value){
				return gmzxOrderquery.changeOrderTypeToName(value);
			}
		},{
			field : 'status1',
			title : '分单状态',
			align:'center',
			width:100
		},{
			field : 'fstatus',
			title : '状态',
			align:'center',
			width:100,
			hidden:true
		},{
			field : 'isDo',
			title : '是否可到国美在线平台操作分单状态',
			align:'center',
			width:100
		}]],
		columns:[ [{
			field : 'xsddh',
			title : '主单号',
			align:'center',
			width:50
		},{
			field : 'status2',
			title : '主单状态',
			align:'center',
			width:100
		},{
			field : 'wlpslx',
			title : '是否3C',
			align:'center',
			width:80,
			formatter:function(value){
				if(value=='2'){
					return "是";
				}else{
					return "否";
				}
			}
		},{
			field : 'wbxsddh',
			title : '国美在线订单编码',
			align:'center',
			width:80
		},{
			field : 'skuwm',
			title : '商品国美在线识别号',
			align:'center',
			width:80
		},{
			field : 'fyxsfdh',
			title : '原分单号',
			align:'center',
			width:80,
			formatter:function(value){
				if(value=='0'){
					return '';
				}else{
					return value;
				}
			}
		},{
			field : 'shrmc',
			title : '收货人名称',
			align:'center',
			width:80
		},{
			field : 'shrdh1',
			title : '电话',
			align:'center',
			width:50,
			formatter:function(value,row){
				if(row.shrdh1!=null && row.shrdh1!=''){
					return row.shrdh1;
				}else{
					return row.shrdh2;
				}
			}
		},{
			field : 'skuId',
			title : '商品SKU',
			align:'center',
			width:60
		},{
			field : 'spjg',
			title : '商品售价',
			align:'center',
			width:60,
			formatter:function(value,row){
				return (value/100).toFixed(2);
			}
		},{
			field : 'fddpsf',
			title : '运费',
			align:'center',
			width:80,
			formatter:function(value,row){
				return ((row.psycf+row.pslqf)/100).toFixed(2);
			}
		},{
			field : 'fddcjje',
			title : '订单成交金额',
			align:'center',
			width:80,
			formatter:function(value,row){
				return (value/100).toFixed(2);
			}
		},{
			field : 'zfsj',
			title : '支付时间',
			align:'center',
			width:80
		},{
			field : 'ddfhsj',
			title : '发货时间',
			align:'center',
			width:100
		},{
			field : 'ddttsj',
			title : '妥投时间',
			align:'center',
			width:50
		},{
			field : 'tjsj',
			title : '创建时间',
			align:'center',
			width:80
		}] ],
		toolbar:gmzxOrderquery.tb,
		onLoadSuccess : function() {
			$('#gmzxSearchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};

	$(gmzxOrderquery.query).on("click", function() {
		if($(gmzxOrderquery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(gmzxOrderquery.searchForm));
			$(gmzxOrderquery.dgId).datagrid({url:'gmzxOrder/list', queryParams:o});
			$(gmzxOrderquery.gmzxExportBtn).linkbutton('enable');
			$(gmzxOrderquery.gmzxCreatPositiveOrder).linkbutton('enable');
			$(gmzxOrderquery.gmzxCreatReverseKuCunBut).linkbutton('enable');
		}
	});
	
	$(gmzxOrderquery.reset).on("click", function() {
		$(gmzxOrderquery.searchForm).form("clear");
	});
	/**
	 * 创建正向单
	 */
	gmzxOrderquery.creatPositiveOrder=function(){
		var selectedRow = $(gmzxOrderquery.dgId).datagrid('getSelections');
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
		var data = $(gmzxOrderquery.dgId).datagrid("getChecked")[0];
		if(0!=data.xsfdlx||10!=data.fstatus){
			$.messager.alert("提示","销售订单已付款后才能创建正向订单","info");		
			return false;
		}
		$(gmzxOrderquery.list_panel).hide();
		$(gmzxOrderquery.creatPositiveOrderPanel).panel({href:"gmzxOrder/openCreatPositiveOrderWindow?xsfdh="+data.xsfdh+"&xsddh="+data.xsddh,title: "创建正向订单确认"});
		$(gmzxOrderquery.creatPositiveOrderPanel).panel('open');
	}
	gmzxOrderquery.creatReverseKuCun=function(){  
	    $.messager.confirm("确认", "确认重新查询库存信息？", function (r) {  
	        if (r) { 
				var selectedRow = $(gmzxOrderquery.dgId).datagrid('getSelections');
				// 没选择数据时，显示告警，返回
				if (selectedRow.length != 1) {
					$.messager.show({
						title: '警告',
						msg: '请选择一条记录重新确认库存',
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
				var data = $(gmzxOrderquery.dgId).datagrid("getChecked")[0];
				if(0!=data.xsfdlx||9!=data.fstatus){
					$.messager.alert("提示","此订单不能重新查询库存","info");		
					return false;
				}
	        	$.ajax({
	                type:"POST", 
	                url:"gmzxOrder/creatReverseKuCun",
	                data:{"xsddh":data.xsddh},
	                success:function(data){
	                	if(data.code==0){
	        	        	parent.$.messager.alert('提示',data.msg,'info');
	                	}else if(data.code==1){
	                		parent.$.messager.alert('警告',data.msg,'worm');
	                	}
	                }
	            });
	        }  
	    });  
	    return false;  
	}  

	
	gmzxOrderquery.view = function(xsfdh,xsddh){
		$(gmzxOrderquery.list_panel).hide();
		$(gmzxOrderquery.viewpanel).panel({title:'订单详情查看',href:"gmzxOrder/viewOrderInfo?xsfdh="+xsfdh+"&xsddh="+xsddh});
		$(gmzxOrderquery.viewpanel).panel('open');
	};
	
	gmzxOrderquery.changeOrderTypeToName= function(value){
		if(value==0){
			return "销售";
		}else if(value==1){
			return "退款";
		}else if(value==3){
			return "拒收";
		}else if(value==4){
			return "退货";
		}
	};
	
	gmzxOrderquery.exportExcel=function(version){
	    window.location.href = 'gmzxOrder/export?version='+version+"&"+ encodeURI($(gmzxOrderquery.searchForm).serialize());
	    $('#gmzxOrder_index_exportWin').window('close');
	};
	
	
	gmzxOrderquery.inits();
