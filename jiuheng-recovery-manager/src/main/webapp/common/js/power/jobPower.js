var jobPower={};
jobPower.inits=function(){
	$('#dg2').datagrid({
		url:'power/queryAllMenu?userId='+1+'&currtime='+ new Date(),
			striped : true,
			collapsible : true,
			autoRowHeight : true,
			remoteSort : false,
			rownumbers : true,
			fitColumns : true,
			nowrap : true,
			checkOnSelect : false,
			selectOnCheck : false,
		toolbar:'#but',
		columns : [ [ {
			field : 'menuId',
			title : '菜单编码',
			width : 100,
			align : 'center'
		},{
			field : 'menuName',
			title : '菜单名称',
			width : 100,
			align : 'center'
		},{
			field : 'action',
			title : '操作',
			width : 40,
			align : 'center',
			formatter : function(value, row, index) {
				return '<a href="#" onclick="jobPower.delPower(\'' + row.menuId+'\', \''+row.userId +'\');">删除</a>';
			}
		}
		] ]

});
}
jobPower.downloadTemplate=function(){
	window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("岗位权限模板");
}
jobPower.downloadPowerTemplate=function(){
	window.location.href="power/downloadPowerTemplate";
}
jobPower.delPower = function(menuId,userId){
	if(menuId.length == 1){
		$.messager.confirm("提示", "确认删除此功能权限？\删除当前主菜单权限后，子菜单权限将全部删除！", function (r) {
			if (r) {
				type = 1;
				$.ajax({
					url: 'power/delPower?menuId=' + menuId + '&userId=' + userId + '&type=' + type
					+ '&currtime=' + new Date(),
					type: 'get',
					success: function (data) {
						if (data.result == true) {
							$('#dg2').datagrid('load');
							$.messager.alert("提示", "删除成功", "info");
						} else {
							$.messager.alert("提示", "删除失败", "info");
						}
					}
				});
			}
		});
	}else{
		$.messager.confirm("提示", "确认删除此功能权限？", function (r) {
			if (r) {
				type = 2;
				$.ajax({
					url: 'power/delPower?menuId=' + menuId + '&userId=' + userId + '&type=' + type
					+ '&currtime=' + new Date(),
					type: 'get',
					success: function (data) {
						if (data.result == true) {
							$('#dg2').datagrid('load');
							$.messager.alert("提示", "删除成功", "info");
						} else {
							$.messager.alert("提示", "删除失败", "info");
						}
					}
				});
			}
		});
	}
}
jobPower.inits();