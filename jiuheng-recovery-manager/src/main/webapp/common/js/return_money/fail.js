var fail = {};

fail.pageId="#fail_return_money";
fail.list_panel = fail.pageId + " #return_fail_panel";
fail.dgId=fail.list_panel + " #dg";
fail.query = fail.list_panel + " #return_list_query";
fail.reset = fail.list_panel + " #check_list_reset";
fail.searchForm = fail.list_panel + " #searchForm";
/**
 * 页面初始化函数
 */
fail.inits = function() {
	$(fail.dgId).datagrid({
		striped : true,
		height : document.documentElement.clientHeight * 0.66,
		autoRowHeight:true,
		pagination : true,
		pageSize : 20,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		columns : [ [/*{
			field : 'action',
			title : '操作',
			align :'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.retStatus==8)
					{
					return '<a href="#" onclick="fail.check(\'' + row.returnId + '\');">审核</a>';
					}else if(row.retStatus==11){
						return '<a href="#" onclick="fail.underline(\'' + row.returnId + '\');">线下退款</a>';
					}else{
						return '<a href="#" onclick="fail.view(\'' + row.returnId + '\');">查看</a>';
					}
			}
		},{
			field : 'returnId',
			title : '退款单号',
			align:'center',
			width:100,
		},{
			field : 'saleCompanyId',
			title : '销售公司代码',
			align:'center',
			width:100,
		},{
			field : 'shopId',
			title : '门店编码',
			align:'center',
			width:100,
		},{
			field : 'shopName',
			title : '门店名称',
			align:'center',
			width:150,
			formatter : function(value, row, index) {
				return fail.shopName(row.shopId);
			}
		},{
			field : 'oldParOrderid',
			title : '原主订单号',
			align:'center',
			width:100,
		},*/{
			field : 'subOrderId',
			title : '订单号',
			align:'center',
			width:100,
		},{
			field : 'payMethod',
			title : '支付方式',
			align:'center',
			width:80,
			formatter : function(value, row, index) {
				if(row.payMethod==1){
				  return "支付宝";
				}else if(row.payMethod==2){
					return "微信";
				}else if(row.payMethod==3){
					return "银联";
				}
			}
		},{
			field : 'payCompCode',
			title : '支付公司代码',
			align:'center',
			width:100
		},{
			field : 'payAccount',
			title : '收付账户号',
			align:'center',
			width:150
		},{
			field : 'payAmount',
			title : '退款金额',
			align:'center',
			width:100,
			formatter : function(value, row, index) {
				return (value/100).toFixed(2);
			}
		},{
			field : 'tries',
			title : '剩余尝试次数',
			align:'center',
			width:80,
		},{
			field : 'result',
			title : '最终状态',
			align:'center',
			width:60,
			formatter : function(value, row, index) {
				if(value==-1){
				  return "退款失败";
				}else if(value==1){
					return "退款成功";
				}else{
					return "初始化";
				}
			}
		},{
			field : 'errors',
			title : '错误信息',
			align :'center',
			width:400,
		},{
			field : 'created',
			title : '开始时间',
			align:'center',
			width:140,
		},{
			field : 'updated',
			title : '更新时间',
			align:'center',
			width:140,
		}] ],
		loadMsg : "数据加载中...",
		onLoadSuccess : function(data) {
			$(this).datagrid('doCellTip', {'max-width' : '1000px','delay' : 500});
		}
	});
};

$(fail.query).on("click", function() {
	var o = $.o2m.serializeObject($(fail.searchForm));
	$(fail.dgId).datagrid({url:'returnmoney/failList', queryParams:o});
});
	
	
fail.inits();
