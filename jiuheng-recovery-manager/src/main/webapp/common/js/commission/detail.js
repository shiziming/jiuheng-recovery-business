var CommissionDetailUtils = {};

//初始化
CommissionDetailUtils.inits = function(){
	var billId = $("#commissionBillId_detail").val();
	$("#commissionDetailPage_selected_dg").datagrid({
		url:'commission/detailList',
		method: 'post',
		queryParams: {'billId' : billId},
		iconCls: 'icon-reload',
		rownumbers:true,
		pagination:true,
		pageSize: 10,
		pageList: [10],
		striped:true,
//		fitColumns : true,
		toolbar : '#commissionDetailPage_tb1',
	    columns:[[
		          	{field:'ck',checkbox:true}
				     ,{field:'orderDetailNo',title:'分单号',width:80,align:'right'}
				     ,{field:'goodsSkuName',title:'商品',width:100,align:'right'}
				     ,{field:'goodsSkuSeq',title:'商品序号',width:80,align:'right'}
				     ,{field:'saleAmount',title:'数量',width:80,align:'right'}
				     ,{field:'tradingAmount',title:'金额',width:80,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); }}
				     ,{field:'goodsCommission',title:'佣金',width:80,align:'right',formatter:function(value, row, index) {return( (value/100).toFixed(2) ); } }
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

	var saleOrgCode = $("#saleOrgCodeDetail").val();
	$("#commissionDetailPage_dg").datagrid({
		method: 'get',
		iconCls: 'icon-reload',
		rownumbers:true,
		pagination:true,
		pageSize: 10,
		pageList: [10],
		striped:true,
		queryParams: {'saleOrgCode' : saleOrgCode},
//		fitColumns : true,
		toolbar : '#commissionDetailPage_tb2',
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
	
	
	//如果已审核，则禁止修改
//	var statusDetailHidden = $("#statusDetailHidden").val();
//	if(statusDetailHidden != 0){
//		$("#href_delete").hide();
//		$("#href_add").hide();
//		$("#href_check").hide();$('#win').window('close');
//	}
};


//返回
CommissionDetailUtils.back = function(){
	$('#commissionPage_detailPanel').panel('close');
	$('#commissionPage_listPanel').show();
	$("#commissionPage_dg").datagrid('reload');

};

//查询
CommissionDetailUtils.search = function(){
	var saleOrgCode = $('#saleOrgCodeUpdate').val();
	var startDay = $("#startDay_detail").datebox('getValue');
	var endDay = $("#endDay_detail").datebox('getValue');
	if(startDay==null || endDay==null || startDay=="" || endDay==""){
		$.messager.confirm('提示', '起止时间必填',
				function(r) {}
		);
		return;
	}
	//提交数据查询
	$("#commissionDetailPage_dg").datagrid({
		queryParams:{
			'saleOrgCode':saleOrgCode,
			'startDay':startDay,
			'endDay':endDay
			},
		url:'commission/detailList'

	});
};


//添加
CommissionDetailUtils.add = function(){
	var selectedRow = $('#commissionDetailPage_dg').datagrid('getSelections');
	if (selectedRow.length > 0) {
		//获取选中行数组对象
    	var data = $("#commissionDetailPage_dg").datagrid("getChecked");
    	addDetails = [];
    	for (var i = 0; i < data.length; i++) {
    		addDetails.push(data[i].orderDetailNo + ";" + data[i].goodsSkuSeq );
    	}
    	var billId = $("#commissionBillId_detail").val();
    	
    	//如果所选数据的saleOrgCode与 已生成发放单的saleOrgCode不一致，则停止
    	var saleOrgCodeBill = $("#saleOrgCodeDetail").val();
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

    	var saleOrgCode = data[0].saleOrgCode;
    	
		// 发送添加请求
		$.post("commission/addDetail", {"detailsStr" : addDetails, "billId":billId,'saleOrgCode':saleOrgCode}, function(result) {
			if(result.code != 0){
				$.o2m.handleActionResult(result);
				return;
			}else{
				var data = result.data;
				//将佣金发返单id填入
				$("#commissionBillId_detail").val(data['billId']);
				$("#commissionDetailPage_billId").textbox('setValue',data['billId']);
				$("#saleOrgCodeDetail").textbox('setValue',data['saleOrgCode']);
				$("#saleOrgNameDetail").textbox('setValue',data['saleOrgName']);
				$("#billOrgDetail").textbox('setValue',data['billOrgCode']);
				$("#createUserDetail").textbox('setValue',data['createUserCode']);
				$("#createNameDetail").textbox('setValue',data['createUserName']);
				$("#createTimeDetail").textbox('setValue',data['createTime']);
				var statusDetail = data['status'];
				if(statusDetail == 0){
					$("#statusDetail").textbox('setValue', "建单中");
				}else if(statusDetail == 1){
					$("#statusDetail").textbox('setValue', "已审核");
				}

				//刷新备选的佣金发放单明细
				$("#commissionDetailPage_dg").datagrid('reload');

				//刷新被选中佣金发放单明细
				$("#commissionDetailPage_selected_dg").datagrid({
					url:'commission/detailList',
					queryParams: {
						'billId': data['billId'],
					}
				});

			}
		}, "JSON");
		
		
	}

};


//移除
CommissionDetailUtils.remove = function(){
	var selectedRow = $('#commissionDetailPage_selected_dg').datagrid('getSelections');
	if (selectedRow.length > 0) {
		//获取选中行数组对象
    	var data = $("#commissionDetailPage_selected_dg").datagrid("getChecked");
    	detailsStr = [];
    	for (var i = 0; i < data.length; i++) {
    		detailsStr.push(data[i].orderDetailNo + ";" + data[i].goodsSkuSeq );
    	}
    	var billId = $("#commissionBillId_detail").val();
		// 发送添加请求
		$.post("commission/removeDetail", {"detailsStr" : detailsStr , "billId": billId }, function(result) {
			if(result.code != 0){
				$.o2m.handleActionResult(result);
			}else{
				var data = result.data;
				//将佣金发返单id填入
				$("#commissionBillId_detail").val(data);

				//刷新备选的佣金发放单明细
				$("#commissionDetailPage_dg").datagrid('reload');

				//刷新被选中佣金发放单明细
				if(data==null){
					$("#commissionBillId_detail").val("");
					$("#commissionDetailPage_billId").textbox('setValue',"");
					$("#saleOrgCodeDetail").textbox('setValue',"");
					$("#saleOrgNameDetail").textbox('setValue',"");
					$("#billOrgDetail").textbox('setValue',"");
					$("#createUserDetail").textbox('setValue',"");
					$("#createNameDetail").textbox('setValue',"");
					$("#createTimeDetail").textbox('setValue',"");
					$("#checkUserCodeDetail").textbox('setValue',"");
					$("#checkUserNameDetail").textbox('setValue',"");
					$("#checkTimeDetail").textbox('setValue',"");
					$("#statusDetail").textbox('setValue',"");
					$("#commissionDetailPage_selected_dg").datagrid({
						url:'commission/detailList',
						queryParams: {
							'billId': -1,
						}
					});

				}else{
					$("#commissionDetailPage_selected_dg").datagrid({
						url:'commission/detailList',
						queryParams: {
							'billId': data,
						}
					});
				}

			}
			
		}, "JSON");
		
		
	}

};

//审核
CommissionDetailUtils.audit = function(){

	$.messager.confirm('确认审核', '确认信息，完成审核？',
			function(r) {
		  		
				if (r) {
					var billId = $("#commissionBillId_detail").val();
			  		$.post("commission/auditBill", { "billId": billId }, function(result){
			  			if($.o2m.handleActionResult(result)){
							$("#commissionDetailPage_href_check").hide();
							$("#to_select_detail").panel('close');
							$("#commissionDetailPage_tb1").hide();

							$("#statusDetail").textbox('setValue',"已审核");
							$("#checkUserCodeDetail").textbox('setValue',result.data.checkUserCode);
							$("#checkUserNameDetail").textbox('setValue',result.data.checkUserName);
							$("#checkTimeDetail").textbox('setValue',result.data.checkTime);
			  			}
			  		});
				}
			});  
},


//导出excel
CommissionDetailUtils.exportExcel = function(){
	var billId = $("#commissionBillId_detail").val();
	window.location.href="commission/exportExcel?billId=" + billId;
	
};


CommissionDetailUtils.inits();