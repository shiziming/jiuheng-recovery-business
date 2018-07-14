var returnmoney = {};

returnmoney.pageId="#check_return_money";
returnmoney.list_panel = returnmoney.pageId + " #return_list_panel";
returnmoney.checkpanel = returnmoney.pageId + " #check_panel";
returnmoney.viewpanel = returnmoney.pageId + " #view_panel";
returnmoney.underlinepanel = returnmoney.pageId + " #underline_panel";
returnmoney.underlineindex = '#underline_index';
returnmoney.dgId=returnmoney.list_panel + " #dg";
returnmoney.query = returnmoney.list_panel + " #return_list_query";
returnmoney.reset = returnmoney.list_panel + " #check_list_reset";
returnmoney.searchForm = returnmoney.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
returnmoney.inits = function() {
	$(returnmoney.dgId).datagrid({
		striped : true,
//		height : document.documentElement.clientHeight * 0.86,
		height : $.o2m.centerHeight - 165,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		columns : [ [{
			field : 'action',
			title : '操作',
			align :'center',
			width:80,
			formatter : function(value, row, index) {
				/*if(row.retStatus==8||row.retStatus==11)*/
				if(row.retStatus==8&&row.moneyCheckFlag==0)
					{
					    return '<a href="#" onclick="returnmoney.actCheck(\'' + row.returnId + '\');">配送会计审核</a>';
					}else if(row.retStatus==8&&row.moneyCheckFlag==1){
						return '<a href="#" onclick="returnmoney.dirCheck(\'' + row.returnId + '\');">资金主管审核</a>';
					}else if(row.retStatus==11){
						return '<a href="#" onclick="returnmoney.underline(\'' + row.returnId + '\');">线下退款</a>';
					}else{
						return '<a href="#" onclick="returnmoney.view(\'' + row.returnId + '\');">查看</a>';
					}
			}
		},{
			field : 'returnId',
			title : '退款单号',
			align:'center',
			width:100
		},{
			field : 'saleCompanyId',
			title : '销售公司代码',
			align:'center',
			width:100
		},{
			field : 'shopId',
			title : '门店编码',
			align:'center',
			width:100
		},{
			field : 'shopName',
			title : '门店名称',
			align:'center',
			width:150/*,
			formatter : function(value, row, index) {
				return returnmoney.shopName(row.shopId);
			}*/
		},{
			field : 'oldParOrderid',
			title : '原主订单号',
			align:'center',
			width:100
		},{
			field : 'oldChidOrderid',
			title : '原子订单号',
			align:'center',
			width:100
		},{
			field : 'retStatus1',
			title : '退款单状态',
			align:'center',
			width:150
		},{
			field : 'payName',
			title : '支付方式',
			align:'center',
			width:130
		},{
			field : 'applyDate',
			title : '申请日期',
			align:'center',
			width:180
		},{
			field : 'checkDate',
			title : '审核日期',
			align :'center',
			width:180
		},{
			field : 'checkpeople',
			title : '审核人',
			align : 'center',
			width:100
		}] ],
		loadMsg : "数据加载中..."
	});
};
	$(returnmoney.query).on("click", function() {
		var o = $.o2m.serializeObject($(returnmoney.searchForm));
		$(returnmoney.dgId).datagrid({url:'returnmoney/listloadData', queryParams:o});
	});
	$(returnmoney.reset).on("click", function() {
		$(returnmoney.searchForm).form("clear");
	});
	//配送会计审核
	returnmoney.actCheck = function(returnId){
		$(returnmoney.list_panel).hide();
		$(returnmoney.checkpanel).panel({title:'配送会计审核',href:"returnmoney/toCheck1?returnId="+returnId});
		$(returnmoney.checkpanel).panel('open');
	};
	//资金主管审核
	returnmoney.dirCheck = function(returnId){
		$(returnmoney.list_panel).hide();
		$(returnmoney.checkpanel).panel({title:'资金主管审核',href:"returnmoney/toCheck2?returnId="+returnId});
		$(returnmoney.checkpanel).panel('open');
	};
	returnmoney.view = function(returnId){
		$(returnmoney.list_panel).hide();
		$(returnmoney.viewpanel).panel({title:'微店退款审核查看',href:"returnmoney/toView?returnId="+returnId});
		$(returnmoney.viewpanel).panel('open');
	};
	returnmoney.underline = function(returnId){
		$(returnmoney.list_panel).hide();
		$(returnmoney.underlinepanel).panel({title:'线下已退款',href:"returnmoney/toUnderLine?returnId="+returnId});
		 $(returnmoney.underlinepanel).panel('open');
	};
	
	returnmoney.shopName = function(shopId){
		var result="";
		$.ajax({url:"returnmoney/shopName?shopId="+shopId,
				async:false,
	            success:function(msg){
	            	result=msg.msg;
	            }
				}
		);
		return result;
	};
	returnmoney.payCompanyName = function(payCompanyId){
		var result="";
		$.ajax({url:"returnmoney/payCompanyName?payCompanyId="+payCompanyId,
			async:false,
			success:function(msg){
				result=msg.msg;
			}
		}
		);
		return result;
	};
	returnmoney.saleCompanyName = function(saleCompanyId){
		var result="";
		$.ajax({url:"returnmoney/saleCompanyName?saleCompanyId="+saleCompanyId,
			async:false,
			success:function(msg){
				result=msg.msg;
			}
		}
		);
		return result;
	};
	returnmoney.goodName = function(goodId){
		var result="";
		$.ajax({url:"returnmoney/goodName?goodId="+goodId,
			async:false,
			success:function(msg){
				result=msg.msg;
			}
		}
		);
		return result;
	};
	
	
returnmoney.inits();
