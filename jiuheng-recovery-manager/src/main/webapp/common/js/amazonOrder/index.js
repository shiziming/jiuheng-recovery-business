var amazonOrderquery = {};

amazonOrderquery.pageId="#amazonOrder_index";
amazonOrderquery.list_panel = amazonOrderquery.pageId + " #amazonList_panel";
amazonOrderquery.viewpanel = amazonOrderquery.pageId + " #amazonView_panel";
amazonOrderquery.creatPositiveOrderPanel = amazonOrderquery.pageId + " #creatPositiveOrder";
amazonOrderquery.dgId=amazonOrderquery.list_panel + " #amazonDg";
amazonOrderquery.query = amazonOrderquery.list_panel + " #amazonList_query";
amazonOrderquery.reset = amazonOrderquery.list_panel + " #amazonList_reset";
amazonOrderquery.searchForm = amazonOrderquery.list_panel + " #amazonSearchForm";
amazonOrderquery.tb = amazonOrderquery.list_panel + " #amazonTb";
amazonOrderquery.amazonExportBtn = amazonOrderquery.tb + " #amazonExportBtn";
amazonOrderquery.amazonCreatReverseOrderBut = amazonOrderquery.tb + " #amazonCreatReverseOrder";
amazonOrderquery.amazonCreatReverseKuCunBut = amazonOrderquery.tb + " #amazonCreatReverseKuCun";
amazonOrderquery.amazonCreatPositiveOrder = amazonOrderquery.tb + " #amazonCreatPositiveOrder";
amazonOrderquery.amazonCreatReverseOrder = amazonOrderquery.list_panel+" #amazonOrder_index_creatReverseOrder";
/**
 * 页面初始化函数
 */
amazonOrderquery.inits = function() {
	//var currentDate = new Date();
	//$(orderquery.list_panel+" #tjsj2").datebox('setValue',currentDate.getFullYear()+"-"+(currentDate.getMonth()+1)+"-"+currentDate.getDate());
	$(amazonOrderquery.dgId).datagrid({
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
				return '<a href="#" onclick="amazonOrderquery.view(\'' + row.xsfdh+'\',\''+ row.xsddh + '\');">'+value+'</a>';
			}
		},{
			field : 'xsfdlx',
			title : '分单类型',
			align:'center',
			width:50,
			formatter:function(value){
				return amazonOrderquery.changeOrderTypeToName(value);
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
			title : '是否可到亚马逊平台操作分单状态',
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
			field : 'xszzdm',
			title : '销售组织代码',
			align:'center',
			width:100
		},{
			field : 'wbxsddh',
			title : '亚马逊订单编码',
			align:'center',
			width:80
		},{
			field : 'skuwm',
			title : '商品亚马逊识别号',
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
			field : 'ddpsf',
			title : '运费',
			align:'center',
			width:80,
			formatter:function(value,row){
				return (value/100).toFixed(2);
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
		},{
			field : 'spkclx',
			title : '预售在途标记',
			align:'center',
			width:80,
			formatter:function(value,row){
				var str="";
				if(row.spkclx=='3'){//spkclx 商品库存类型 3表示在途订单   fstatus 25预售在途商品已到货
					return '是';
				}else{
					return '否';
				}
				
			}
		},{
			field : 'popjsbj',
			title : '结算标记',
			align:'center',
			width:80,
			formatter:function(value){
				if(value==0){
					return "0 未结算";
				}else if(value==1){
					return "1 待结算";
				}else if(value==2){
					return "2 已生成结算中间数据";
				}else if(value==3){
					return "3 结算已审核";
				}
			}
		},{
			field : 'caozuo',
			title : '操作',
			align:'center',
			width:80,
			formatter:function(value,row){
				var str="";
				if(row.spkclx=='3' &&  row.fstatus=='25'){//spkclx 商品库存类型 3表示在途订单   fstatus 25预售在途商品已到货
					str='<a href="#" onclick="openUpdateDate(\'' + row.xsfdh+'\');">修改配送时间</a>'
				}
				return str;
			}
		}]],
		toolbar:amazonOrderquery.tb,
		onLoadSuccess : function() {
			$('#amazonSearchForm table').show();
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
			parent.$.messager.progress('close');
		},
		loadMsg : "数据加载中..."
	});
};
  var xsfdhid;
  function openUpdateDate(xsfdh){
	  xsfdhid=xsfdh;
	  $.ajax({
	        type:"POST", 
	        url:"amazonOrder/openmodPSDateWindow",
	        data:{},
	        success:function(data){
	        	//alert(data.code);
	        	if(data.code=='0'){
	        		 $('#win').window('open'); 
	        	}else{
	        		alert("对不起，您暂无权限");
	        		return false;
	        	}
	        	
	        	
	        }
	    }); 
	 
  }
  
  function modpssj(){
	  var ddhid=xsfdhid;
	  var psrq=$('#psrq').datebox('getValue'); 
	  var startDate=$('#psrqstart').datebox('getValue').substring(10, 19);
	  var endDate=$('#psrqend').datebox('getValue').substring(10, 19);
	  
	  $.ajax({
	        type:"POST", 
	        url:"amazonOrder/modPSDate",
	        data:{"xsfdh":ddhid,"modDate":psrq,"startDateTime":startDate,"endDateTime":endDate},
	        success:function(data){
	        		$.messager.alert("提示",data.msg,'info');
	        		$("#win").window('close');
	        	
	        }
	    }); 
  }

	$(amazonOrderquery.query).on("click", function() {
		if($(amazonOrderquery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(amazonOrderquery.searchForm));
			$(amazonOrderquery.dgId).datagrid({url:'amazonOrder/list', queryParams:o});
			$(amazonOrderquery.amazonExportBtn).linkbutton('enable');
			$(amazonOrderquery.amazonCreatPositiveOrder).linkbutton('enable');
			$(amazonOrderquery.amazonCreatReverseOrderBut).linkbutton('enable');
			$(amazonOrderquery.amazonCreatReverseKuCunBut).linkbutton('enable');
		}
	});
	
	$(amazonOrderquery.reset).on("click", function() {
		$(amazonOrderquery.searchForm).form("clear");
	});
	/**
	 * 创建正向单
	 */
	amazonOrderquery.creatPositiveOrder=function(){
		var selectedRow = $(amazonOrderquery.dgId).datagrid('getSelections');
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
		var data = $(amazonOrderquery.dgId).datagrid("getChecked")[0];
		if(0!=data.xsfdlx||10!=data.fstatus){
			$.messager.alert("提示","销售订单已付款后才能创建正向订单","info");		
			return false;
		}
		$(amazonOrderquery.list_panel).hide();
		$(amazonOrderquery.creatPositiveOrderPanel).panel({href:"amazonOrder/openCreatPositiveOrderWindow?xsfdh="+data.xsfdh+"&xsddh="+data.xsddh,title: "创建正向订单确认"});
		$(amazonOrderquery.creatPositiveOrderPanel).panel('open');
	}
	/**
	 * 创建逆向单
	 */
		amazonOrderquery.creatReverseOrder=function(){
			var selectedRow = $(amazonOrderquery.dgId).datagrid('getSelections');
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
			var data = $(amazonOrderquery.dgId).datagrid("getChecked")[0];
			$('#amazonOrder_index_creatReverseOrder').window({
	            width: 350,
	            height: 220,
	            modal: true,
	            method:'post',
	            href: "amazonOrder/openCreatReverseOrderWindow?xsddh="+data.xsddh+"&xsfdh="+data.xsfdh+"&xsfdlx="+data.xsfdlx+"&fstatus="+data.fstatus,
	            title: "创建逆向订单确认"
	        });
			$('#amazonOrder_index_creatReverseOrder').window('open');
		}
		
	amazonOrderquery.creatReverseKuCun=function(){  
		    $.messager.confirm("确认", "确认重新查询库存信息？", function (r) {  
		        if (r) { 
					var selectedRow = $(amazonOrderquery.dgId).datagrid('getSelections');
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
					var data = $(amazonOrderquery.dgId).datagrid("getChecked")[0];
					if(0!=data.xsfdlx||9!=data.fstatus){
						$.messager.alert("提示","此订单不能重新查询库存","info");		
						return false;
					}
		        	$.ajax({
		                type:"POST", 
		                url:"amazonOrder/creatReverseKuCun",
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

	
	amazonOrderquery.view = function(xsfdh,xsddh){
		$(amazonOrderquery.list_panel).hide();
		$(amazonOrderquery.viewpanel).panel({title:'订单详情查看',href:"amazonOrder/viewOrderInfo?xsfdh="+xsfdh+"&xsddh="+xsddh});
		$(amazonOrderquery.viewpanel).panel('open');
	};
	
	amazonOrderquery.changeOrderTypeToName= function(value){
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
	
	amazonOrderquery.exportExcel=function(version){
	    window.location.href = 'amazonOrder/export?version='+version+"&"+ encodeURI($(amazonOrderquery.searchForm).serialize());
	    $('#amazonOrder_index_exportWin').window('close');
	};
	
	
	amazonOrderquery.inits();
