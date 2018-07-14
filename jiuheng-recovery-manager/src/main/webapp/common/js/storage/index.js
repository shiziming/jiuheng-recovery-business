var storagequery = {};

storagequery.pageId="#storage_index";
storagequery.list_panel = storagequery.pageId + " #list_panel";
storagequery.dgId=storagequery.list_panel + " #dg";
storagequery.query = storagequery.list_panel + " #list_query";
storagequery.searchForm = storagequery.list_panel + " #searchForm";
storagequery.tb = storagequery.list_panel + " #tb";
/**
 * 页面初始化函数
 */
storagequery.inits = function() {// 对Date的扩展，将 Date 转化为指定格式的String   
	
	$(storagequery.dgId).datagrid({
		striped : true,
		height : $.o2m.centerHeight - 120,
		autoRowHeight:true,
		rownumbers : true,
		checkOnSelect : true,
		singleSelect : true,
		columns:[[{
			field : 'shopCode',
			title : '门店代码',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePriceKey.shopCode;
			}
		},{
			field : 'skuId',
			title : 'SKUID',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePrice.skuId;
			}
		},{
			field : 'deliverWarehouseCode',
			title : '仓库送货DC',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if($.trim(rec.skuStoragePriceKey.deliverWarehouseCode) == $.trim(rec.skuStoragePriceKey.addressWarehouseCode) 
						|| rec.skuStoragePriceKey.canExchangeBetweenStorageOrNot)
					return rec.skuStoragePriceKey.deliverWarehouseCode;
				else
					return "<font color='red'>"+rec.skuStoragePriceKey.deliverWarehouseCode+"</font>";
			}
		},{
			field : 'ck01',
			title : '仓库代码',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePriceKey.ck01;
			}
		},{
			field : 'selfDelivery',
			title : '国美配送',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if(rec.skuStoragePrice.selfDelivery)
					return "是";
				else return "否";
			}
		},{
			field : 'expressFlag',
			title : '地址仓库非3C标记',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if(rec.skuStoragePriceKey.expressFlag)
					return "否";
				else return "是";
			}
		},{
			field : 'addressWarehouseCode',
			title : '地址DC',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if($.trim(rec.skuStoragePriceKey.addressWarehouseCode) == $.trim(rec.skuStoragePriceKey.deliverWarehouseCode)
						|| rec.skuStoragePriceKey.canExchangeBetweenStorageOrNot)
					return rec.skuStoragePriceKey.addressWarehouseCode;
				else
					return "<font color='red'>"+rec.skuStoragePriceKey.addressWarehouseCode+"</font>";
			}
		},{
			field : 'isGome',
			title : '地址国美标记',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if(rec.skuStoragePriceKey.isGome)
					return "是";
				else return "否";
			}
		},{
			field:'canExchangeBetweenGomeOrNot',
			title:'转品牌销售',
			align:'center',
			width:40,
			formatter:function(value,rec){
				if(rec.skuStoragePriceKey.canExchangeBetweenGomeOrNot)
					return "是";
				else return "否";
			}
		},{
			field : 'canExchangeBetweenStorageOrNot',
			title : '一二级仓库互卖标记',
			align:'center',
			width:120,
			formatter:function(value,rec){
				if($.trim(rec.skuStoragePriceKey.deliverWarehouseCode) == $.trim(rec.skuStoragePriceKey.addressWarehouseCode))
					return "";
				else{
					if(rec.skuStoragePriceKey.canExchangeBetweenStorageOrNot){
						return "是";
					}else
						return "<font color='red'>"+'否'+"</font>";
				}
			}
		},{
			field : 'numSaleable',
			title : '可卖数',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if(rec.skuStoragePrice.numSaleable+rec.skuStoragePrice.numOnWay>rec.skuStoragePrice.numSold){
					return rec.skuStoragePrice.numSaleable;
				}else{
					return "<font color='red' >"+rec.skuStoragePrice.numSaleable+"</font>";
				}
			}
		},{
			field : 'numOnWay',
			title : '在途数',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePrice.numOnWay;
			}
		},{
			field : 'numSold',
			title : '已卖数',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePrice.numSold;
			}
		},{
			field : 'upperFlag',
			title : '上架标记',
			align:'center',
			width:80,
			formatter:function(value,rec){
				if(rec.skuStoragePrice.upperFlag==1){
					return "已上架";
				}else if(rec.skuStoragePrice.upperFlag==0){
					return "<font color='red' >未上架</font>";
				}
			}
		},{
			field : 'price',
			title : '价格',
			align:'center',
			width:80,
			formatter:function(value,rec){
				//-1
				//return rec.skuStoragePrice.price;
				if(rec.skuStoragePrice.price > -1){
					return rec.skuStoragePrice.price;
				}else{
					return "<font color='red' >"+rec.skuStoragePrice.price+"</font>";
				}
			}
		},{
			field : 'priceKSRQ',
			title : '价格开始日期',
			align:'center',
			width:90,
			formatter:function(value,rec){
				var today = rec.skuStoragePrice.currDay;
				if(rec.skuStoragePrice.priceKSRQ<=today && rec.skuStoragePrice.priceJSRQ>=today)
					return rec.skuStoragePrice.priceKSRQ;
				else return "<font color='red'>"+rec.skuStoragePrice.priceKSRQ+"</font>";
					
			}
		},{
			field : 'priceJSRQ',
			title : '价格结束日期',
			align:'center',
			width:90,
			formatter:function(value,rec){
				var today = rec.skuStoragePrice.currDay;
				if(rec.skuStoragePrice.priceKSRQ<=today && rec.skuStoragePrice.priceJSRQ>=today)
					return rec.skuStoragePrice.priceJSRQ;
				else return "<font color='red'>"+rec.skuStoragePrice.priceJSRQ+"</font>";
			}
		},{
			field : 'jlzxbj1',
			title : '销售策略注销标记',
			align:'center',
			width:90,
			formatter:function(value,rec){
				if(rec.skuStoragePrice.jlzxbj1 == 0)
					return rec.skuStoragePrice.jlzxbj1;
				else return "<font color='red'>"+rec.skuStoragePrice.jlzxbj1+"</font>";
			}
		},{
			field : 'jlzxbj2',
			title : '策略组注销标记',
			align:'center',
			width:90,
			formatter:function(value,rec){
				if(rec.skuStoragePrice.jlzxbj2 == 0)
					return rec.skuStoragePrice.jlzxbj2;
				else return "<font color='red'>"+rec.skuStoragePrice.jlzxbj2+"</font>";
			}
		},{
			field : 'jlzxbj1Start',
			title : '销售策略开始日期',
			align:'center',
			width:90,
			formatter:function(valu,rec){
				var today = rec.skuStoragePrice.currDay;
				if(rec.skuStoragePrice.jlzxbj1Start<=today && rec.skuStoragePrice.jlzxbj1End>=today)
					return rec.skuStoragePrice.jlzxbj1Start;
				else return "<font color='red'>"+rec.skuStoragePrice.jlzxbj1Start+"</font>";
					
			}
		},{
			field : 'jlzxbj1End',
			title : '策略组注销结束日期',
			align:'center',
			width:90,
			formatter:function(value,rec){
				var today = rec.skuStoragePrice.currDay;
				if(rec.skuStoragePrice.jlzxbj1Start<=today && rec.skuStoragePrice.jlzxbj1End>=today)
					return rec.skuStoragePrice.jlzxbj1End;
				else return "<font color='red'>"+rec.skuStoragePrice.jlzxbj1End+"</font>";
			}
		},{
			field : 'saleCompanyCode',
			title : '销售公司',
			align:'center',
			width:60,
			formatter:function(value,rec){
				return rec.skuStoragePriceKey.saleCompanyCode;
			}
		},{
			field : 'saleOrgCode',
			title : '销售组织',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePrice.saleOrgCode;
			}
		},{
			field : 'deliverAreaCode',
			title : '配送区域',
			align:'center',
			width:80,
			formatter:function(value,rec){
				return rec.skuStoragePriceKey.deliverAreaCode;
			}
		},{
			field : 'installAreaCode',
			title : '安装区域',
			align:'center',
			width:60,
			formatter:function(value,rec){
				return rec.skuStoragePriceKey.installAreaCode;
			}
		}] ],
		onLoadSuccess : function(data ) {
			if(!$.o2m.isEmpty(data.errors)){
				alert(data.errors);
			}else{
				$('#searchForm table').show();
				$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
				parent.$.messager.progress('close');
			}
		},
		loadMsg : "数据加载中..."
	});
};

	$(storagequery.query).on("click", function() {
		if($(storagequery.searchForm).form('validate')){
			var o = $.o2m.serializeObject($(storagequery.searchForm));
			$(storagequery.dgId).datagrid({url:'storage/list', queryParams:o});
		}
	});
	
	
	
	
storagequery.inits();
