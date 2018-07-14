<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="cdnErrorPage">
	<div id="listPanel">
			<table id="dg" title="CDN失败图片"></table>
			<div id="tb" style="height: auto">
				<div class="search">
					<form id="searchForm">
						<table style="width: 400px">
							<tr>
								<td class="label">spuId:<input name="id" /></td>
								<td class="label"><a id="btnSearch"
									class="easyui-linkbutton"
									data-options="iconCls:'icon-search',plain:true">查 询</a></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="toolbar">
					<a id="handleErrors" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-save',plain:true">重新上传CDN</a>
				</div>
			</div>
	</div>
</div>

<script type="text/javascript">
var cdnError = {};

cdnError.pageId = '#cdnErrorPage';
cdnError.dgId = cdnError.pageId + ' #dg';
cdnError.toolBar = cdnError.pageId + ' #tb';

/**
 * 页面初始化函数
 */
cdnError.inits = function() {
	$(cdnError.dgId).datagrid({
		rownumbers : true,
		striped : true,
		fitColumns : true,
		height : $.o2m.centerHeight-20,
		toolbar : cdnError.toolBar,
		pagination : true,
		pageSize : 20,
		checkbox : true,
		idField : 'id',
		url : 'spic/cdnErrorPicList',
		columns : [ [ {
			field : 'id',
			checkbox:true
		}, {
			field : 'spuId',
			title : 'spuId',
			width : 30,
			align : "center"
		}, {
			field : 'location',
			title : '位置',
			align : "center",
			width : 20,
			formatter : function(value,row) {
				if(value == 1){
					return "主体";
				}
				return "详情";
			}
		} , {
			field : 'inx',
			title : '下标',
			align : "center",
			width : 20
		}, {
			field : 'url',
			title : '图片',
			align : "center",
			width : 100,
			formatter : function(value,row) {
				return "<img src = "+picUrl + value+" style='height:50px'></img>";
			}
		}] ],
		loadMsg : "数据加载中..."
	});
};
//查询
$(cdnError.pageId + ' #btnSearch').on("click", function() {
	$(cdnError.dgId).datagrid("clearChecked");
	$(cdnError.dgId).datagrid("load", $.o2m.serializeObject($(cdnError.pageId + " #searchForm")));
});
//单张处理
$(cdnError.pageId + ' #handleErrors').on("click", function() {
	var rows = $(cdnError.dgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择图片记录。', 'info');
	}else{
		$.o2m.showProgressing();
		var ids = [];
		$.each(rows,function(i,n){
			ids.push(n.id);
		});
		$.ajax({ 
            type:"POST", 
            url:"spic/handleErrors", 
            dataType:"json",      
            contentType:"application/json",
            data:JSON.stringify(ids), 
            async : false,
            success:function(msg){
				$.o2m.closeProgressing();
            	if($.o2m.handleActionResult(msg)){
            		$(cdnError.dgId).datagrid('reload');
            	}
            }
        }); 
	}
});
cdnError.inits();
</script>

