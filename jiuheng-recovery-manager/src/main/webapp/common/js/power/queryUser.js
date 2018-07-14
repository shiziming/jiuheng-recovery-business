var goodsManage = {};


/**
 * 页面初始化函数
 */
goodsManage.inits = function() {
	$('#user_list_dg').datagrid({
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination : true,
		pageSize : 20,
		striped : true,
		url : 'power/queryUserList?currtime='+ new Date(),
		columns : [ [{
			field : 'userAccount',
			title : '用户账号',
			align:'left',
			width : 100
		},{
			field : 'userName',
			title : '用户名称',
			align:'left',
			width : 80
		},{
			field : 'iszg',
			title : '主岗/兼职',
			align:'left',
			width : 80
		},{
			field : 'postCode',
			title : '岗位编码',
			align:'left',
			width : 160
		},{
			field : 'postName',
			title : '岗位名称',
			align:'left',
			width : 350
		},{
			field : 'roleCode',
			title : '角色编码',
			align:'left',
			width : 100
		},{
			field : 'roleName',
			title : '角色名称',
			align:'left',
			width : 350
		},{
			field : 'status',
			title : '用户状态',
			align:'left',
			width : 40
		},{
			field : 'datafrom',
			title : '数据来源（手工/同步）',
			align :'center',
			width : 140
		},{
			field : 'startTime',
			title : '起始日期',
			align :'center',
			width :150
		},{
			field : 'endTime',
			title : '截止日期',
			align :'center',
			width : 150
		}/*,{
			field : 'action',
			title : '操作',
			formatter : function(value, row, index) {
				if(row.status==0){
					return '<a href="#" onclick="goods_list_view(\'' + row.billId + '\');">查看</a> <a href="#" onclick="goods_list_update(\'' + row.billId + '\');">修改</a>'+
						' <a href="#" onclick="goods_list_view(\'' + row.billId + '\');">删除</a>  <a href="#" onclick="goods_list_view(\'' + row.billId + '\');">审核</a>';
				}else if(row.status==1){
					return '<a href="#" onclick="goods_list_view(\'' + row.billId + '\')">查看</a>';
				}
			}
		}*/] ],
		
	});
	
};
	function queryByCondition(){
		
		var userAccount=$('#userAccountid').val();
		var userName =$('#userNameid').val();
		var roleCode =$('#roleCodeid').val();
		var status = $('#statusid').combobox("getValue");
		$("#user_list_dg").datagrid({
			queryParams: {
				userAccount:userAccount,
			    userName :userName,
				roleCode :roleCode,
				status :status
			},
			url:'power/queryUserList?currtime='+ new Date()
			});
		
	}
	
	
	
goodsManage.inits();
