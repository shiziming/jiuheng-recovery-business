var CommissionNewUtils = {};

//初始化
CommissionNewUtils.inits = function(){

	$("#commissionNewPage_selected_dg").datagrid({
		method: 'get',
		iconCls: 'icon-reload',
		rownumbers:true,
		pagination:true,
		pageSize: 10,
		pageList: [10],
		striped:true,
		toolbar : '#commissionNewPage_tb1',
//		fitColumns : true,
	    columns:[[
		          	{field:'ck',checkbox:true}
				     ,{field:'orderDetailNo',title:'分单号',width:80,align:'right'}
				     ,{field:'goodsSkuName',title:'商品',width:100,align:'right'}
				     ,{field:'goodsSkuSeq',title:'商品序号',width:80,align:'right'}
				     ,{field:'saleAmount',title:'数量',width:80,align:'right'}
				     ,{field:'tradingAmount',title:'金额',width:80,align:'right',formatter:function(value, row, index) {return( value/100 ); }}
				     ,{field:'goodsCommission',title:'佣金',width:80,align:'right',formatter:function(value, row, index) {return( value/100 ); } }
				     ,{field:'saleOrgCode',title:'收入销售组织代码',width:80,align:'right'}
				     ,{field:'saleOrgName',title:'收入销售组织',width:100,align:'right'}
				     ,{field:'saleCompCode',title:'发货公司代码',width:80,align:'right'}
				     ,{field:'payCompCode',title:'支付公司代码',width:100,align:'right'}
				     ,{field:'gomeStaffId',title:'促销员（员工）id',width:100,align:'right'}
				     ,{field:'bankName',title:'开户行',width:100,align:'right'}
				     ,{field:'cardNo',title:'银行卡号',width:100,align:'right'}
				     ,{field:'bankCityName',title:'银行城市名称',width:120,align:'right'}
				     ,{field:'bankSubbranchName',title:'银行支行名称',width:120,align:'right'}
				     ,{field:'saleOrgCodeStore',title:'店主销售组织ID',width:80,align:'right'}
				     ,{field:'saleOrgNameStore',title:'店主销售组织',width:100,align:'right'}
				     ,{field:'saleOrgCompCode',title:'人员公司代码',width:100,align:'right'}
				     ,{field:'shopkeeperName',title:'网店店主',width:100,align:'right'}
				     ,{field:'credentialNo',title:'身份证号',width:100,align:'right'}
				     ,{field:'outFlag',title:'外部发放',width:100,align:'right',formatter:function(value, row, index) {
				    	 if(row.payCompCode != row.saleOrgCompCode){
				    		 return '是';
				    	 }else{
				    		 return '否';
				    	 }
				    	 }}
	    ]]
	});

	$("#commissionNewPage_dg").datagrid({
		method: 'get',
		iconCls: 'icon-reload',
		rownumbers:true,
		pagination:true,
		pageSize: 10,
		pageList: [10],
		striped:true,
//		fitColumns : true,
		toolbar : '#commissionNewPage_tb2',
	    columns:[[
		     {field:'ck',checkbox:true}
		     ,{field:'orderDetailNo',title:'分单号',width:80,align:'right'}
		     ,{field:'goodsSkuName',title:'商品',width:100,align:'right'}
		     ,{field:'goodsSkuSeq',title:'商品序号',width:80,align:'right'}
		     ,{field:'saleAmount',title:'数量',width:80,align:'right'}
		     ,{field:'tradingAmount',title:'金额',width:80,align:'right',formatter:function(value, row, index) {return( value/100 ); }}
		     ,{field:'goodsCommission',title:'佣金',width:80,align:'right',formatter:function(value, row, index) {
		    	 if(row.saleAmount < 0){
			    	 return( -value/100 ); 
		    	 }else{
			    	 return( value/100 ); 
		    	 }
		    	 
		    	 }
		     }
		     ,{field:'saleOrgCode',title:'收入销售组织代码',width:80,align:'right'}
		     ,{field:'saleOrgName',title:'收入销售组织',width:100,align:'right'}
		     ,{field:'saleCompCode',title:'发货公司代码',width:80,align:'right'}
		     ,{field:'payCompCode',title:'支付公司代码',width:100,align:'right'}
		     ,{field:'gomeStaffId',title:'促销员（员工）id',width:100,align:'right'}
		     ,{field:'bankName',title:'开户行',width:100,align:'right'}
		     ,{field:'cardNo',title:'银行卡号',width:100,align:'right'}
		     ,{field:'bankCityName',title:'银行城市名称',width:120,align:'right'}
		     ,{field:'bankSubbranchName',title:'银行支行名称',width:120,align:'right'}
		     ,{field:'saleOrgCodeStore',title:'店主销售组织ID',width:80,align:'right'}
		     ,{field:'saleOrgNameStore',title:'店主销售组织',width:100,align:'right'}
		     ,{field:'saleOrgCompCode',title:'人员公司代码',width:100,align:'right'}
		     ,{field:'shopkeeperName',title:'网店店主',width:100,align:'right'}
		     ,{field:'credentialNo',title:'身份证号',width:100,align:'right'}
		     ,{field:'outFlag',title:'外部发放',width:100,align:'right',formatter:function(value, row, index) {
		    	 if(row.payCompCode != row.saleOrgCompCode){
		    		 return '是';
		    	 }else{
		    		 return '否';
		    	 }
		    	 }}
		     
	    ]]
	});
	
		
};

//查询
CommissionNewUtils.search = function(){
	var saleOrgCode = $('#saleOrgCode').val();
	var startDay = $("#startDay_new").datebox('getValue');
	var endDay = $("#endDay_new").datebox('getValue');
	if(startDay==null || endDay==null || startDay=="" || endDay==""){
		$.messager.confirm('提示', '起止时间必填',
				function(r) {}
		);
		return;

	}
	//提交数据查询
	$("#commissionNewPage_dg").datagrid({
		queryParams:{
			'saleOrgCode':saleOrgCode,
			'startDay':startDay,
			'endDay':endDay
			},
		url:'commission/detailList'
	});
};

//返回
CommissionNewUtils.back = function(){
	$('#commissionPage_newPanel').panel('close');
	$('#commissionPage_listPanel').show();
	$("#commissionPage_dg").datagrid('reload');

};

//添加
CommissionNewUtils.add = function(){
	var selectedRow = $('#commissionNewPage_dg').datagrid('getSelections');
	if (selectedRow.length > 0) {
		//获取选中行数组对象
    	var data = $("#commissionNewPage_dg").datagrid("getChecked");
    	addDetails = [];
    	var saleOrgCode = data[0].saleOrgCode;
    	
    	//如果所选数据的saleOrgCode与 已生成发放单的saleOrgCode不一致，则停止
    	var saleOrgCodeBill = $("#saleOrgCodeNew").val();
    	if(   saleOrgCodeBill != null && saleOrgCodeBill != ""  ){
    		for (var i=0;i<data.length;i++)
        	{
        		if(data[i].saleOrgCode != saleOrgCodeBill){
            		$.messager.confirm('提示', '所选明细 与 已选明细的 销售组织代码 不一致',
            				function(r) {}
            		);
            		return;
        		}
        	}
    	}

    	//如果所选数据的saleOrgCode与 已生成发放单的saleOrgCode不一致，则停止
		for (var i=0;i<data.length;i++)
    	{			
    		if(data[i].saleOrgCode != saleOrgCode){
        		$.messager.confirm('提示', '所选明细的 销售组织代码 互相不一致',
        				function(r) {}
        		);
        		return;
    		}
    	}
   	
    	for (var i = 0; i < data.length; i++) {
    		addDetails.push(data[i].orderDetailNo + ";" + data[i].goodsSkuSeq );
    	}
    	var billId = $("#commissionBillId").val();
		// 发送添加请求
		$.post("commission/addDetail", {"detailsStr" : addDetails, "billId":billId,"saleOrgCode":saleOrgCode}, function(result) {
			if(result.code != 0){
				$.o2m.handleActionResult(result);
				return;
			}
			var data = result.data;
			//将佣金发返单id填入
			$("#commissionBillId").val(data['billId']);
			$("#commissionNewPage_billId").textbox('setValue',data['billId']);
			$("#saleOrgCodeNew").textbox('setValue',data['saleOrgCode']);
			$("#saleOrgNameNew").textbox('setValue',data['saleOrgName']);
			$("#billOrgNew").textbox('setValue',data['billOrgCode']);
			$("#createUserNew").textbox('setValue',data['createUserCode']);
			$("#createNameNew").textbox('setValue',data['createUserName']);
			$("#createTimeNew").textbox('setValue',data['createTime']);
			var statusNew = data['status'];
			if(statusNew == 0){
				$("#commissionNewPage_status").textbox('setValue', "建单中");
			}else if(statusNew == 1){
				$("#commissionNewPage_status").textbox('setValue', "已审核");
			}


			//刷新备选的佣金发放单明细
			$("#commissionNewPage_dg").datagrid('reload');

			//刷新被选中佣金发放单明细
			$("#commissionNewPage_selected_dg").datagrid({
				url:'commission/detailList',
				queryParams: {
					'billId': data['billId'],
				}
			});
		}, "JSON");
		
		
	}

};


//移除
CommissionNewUtils.remove = function(){
	var selectedRow = $('#commissionNewPage_selected_dg').datagrid('getSelections');
	if (selectedRow.length > 0) {
		//获取选中行数组对象
    	var data = $("#commissionNewPage_selected_dg").datagrid("getChecked");
    	detailsStr = [];
    	for (var i = 0; i < data.length; i++) {
    		detailsStr.push(data[i].orderDetailNo + ";" + data[i].goodsSkuSeq );
    	}
    	var billId = $("#commissionBillId").val();
		// 发送添加请求
		$.post("commission/removeDetail", {"detailsStr" : detailsStr , "billId": billId }, function(result) {
			if(result.code != 0){
				$.o2m.handleActionResult(result);
				return;
			}
			var data = result.data;
			//将佣金发返单id填入
			$("#commissionBillId").val(data);

			//刷新备选的佣金发放单明细
			$("#commissionNewPage_dg").datagrid('reload');

			//刷新被选中佣金发放单明细
			if(data==null){//如果 佣金发放单 已被删除
				$("#commissionNewPage_billId").textbox('setValue',"");
				$("#saleOrgCodeNew").textbox('setValue',"");
				$("#saleOrgNameNew").textbox('setValue',"");
				$("#billOrgNew").textbox('setValue',"");
				$("#createUserNew").textbox('setValue',"");
				$("#createNameNew").textbox('setValue',"");
				$("#createTimeNew").textbox('setValue',"");
				$("#commissionNewPage_status").textbox('setValue',"");
				$("#commissionNewPage_selected_dg").datagrid({
					url:'commission/detailList',
					queryParams: {
						'billId': -1,
					}
				});

			}else{
				$("#commissionNewPage_selected_dg").datagrid({
					url:'commission/detailList',
					queryParams: {
						'billId': data,
					}
				});
			}
		}, "JSON");
		
		
	}

};





CommissionNewUtils.inits();