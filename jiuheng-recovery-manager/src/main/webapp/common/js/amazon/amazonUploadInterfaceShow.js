var amazonUploadInterfaceShow = {};

amazonUploadInterfaceShow.pageId = '#pageId';
amazonUploadInterfaceShow.dgId=amazonUploadInterfaceShow.pageId+" #dgId";
amazonUploadInterfaceShow.uploadMessage="#uploadMessage";
amazonUploadInterfaceShow.downMessage="#downMessage";
amazonUploadInterfaceShow.error=amazonUploadInterfaceShow.pageId+" #error";
/**
 * 页面初始化函数
 */
amazonUploadInterfaceShow.inits = function() {
	$(amazonUploadInterfaceShow.dgId).datagrid(
			{
				title : "亚马逊上传接口展示",
				url : "amazonInterface/interfaceShow",
				height : $.o2m.centerHeight - 20,
				fitColumns : true,
				pagination : true,
				pageSize : 20,
				checkOnSelect : true,
				singleSelect : false,
				columns : [ [
						{
							field : 'feedId',
							title : '编码',
							width : 50,
							align : 'center',
							formatter : function(value, row, index) {
								return '<a href="#" onclick="amazonUploadInterfaceShow.upFilePath(\'' + value +'\');">'+value+'</a>';
							}
						},
						{
							field : 'feedType',
							title : '数据类型',
							width : 50,
							align : 'center'
						},
						{
							field : 'upTime',
							title : '上传时间',
							width : 50,
							align : 'center',
						}, {
							field : 'feedStatus',
							title : '数据处理状态',
							width : 50,
							align : 'center',
						}, {
							field : 'startTime',
							title : '开始上传时间',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'endTime',
							title : '结束上传时间',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'requestId',
							title : '请求标识',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'timeTemp',
							title : '时间标识',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'fileName',
							title : '上传文件名称',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'upFilePath',
							title : '上传文件路径',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'downFilePath',
							title : '下载文件路径',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'updateTime',
							title : '最后维护时间',
							width : 50,
							align : 'center',
							sortable : true,
						},{
							field : 'action',
							title : '操作',
							width : 50,
							align : 'center',
							sortable : true,
							formatter : function(value, row, index) {
								return '<a href="#" onclick="amazonUploadInterfaceShow.downFilePath(\'' +row.feedId+ '\');">查看返回信息</a>';
							}
						}] ],
				loadMsg : "数据加载中..."
			});
};

amazonUploadInterfaceShow.upFilePath=function(feedId){
	$(amazonUploadInterfaceShow.pageId).hide();
	$(amazonUploadInterfaceShow.uploadMessage).panel({title:"上传信息",href:"amazonInterface/openUploadMessage?feedId="+feedId});
	$(amazonUploadInterfaceShow.uploadMessage).show();
}
amazonUploadInterfaceShow.downFilePath=function(feedId){
	$.ajax({
        type:"POST", 
        url:"amazonInterface/checkDownMessage",
        data:"feedId="+feedId,
        success:function(data){
        	if(data.code==0){
        		$(amazonUploadInterfaceShow.pageId).hide();
        		$(amazonUploadInterfaceShow.downMessage).panel({title:"返回信息",href:"amazonInterface/openDownMessage?feedId="+feedId});
        		$(amazonUploadInterfaceShow.downMessage).show();
        	}else if(data.code==1){
        		$.messager.alert("提示",data.msg,'info');
        	}
        }
    }); 
	
}
amazonUploadInterfaceShow.inits();
