<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="spu2PiPage">
	<div id="listPanel">
		<table id="dg" title="SPU发送PI"></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table style="width: 600px">
						<tr>
							<td class="label">spu码:<input name="code" /></td>
							<td class="label">spu名称:<input name="name" /></td>
							<td class="label"><a id="btnSearch"
								class="easyui-linkbutton"
								data-options="iconCls:'icon-search',plain:true">查 询</a></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
				<p style="margin-left: 50px"><input id="kssj" placeholder="起始时间"
								class="easyui-datetimebox" style="width: 150px"/>至<input id="jssj"
								placeholder="结束时间" class="easyui-datetimebox" style="width: 150px"/>
								<a id="sendByTime"
								class="easyui-linkbutton"
								data-options="iconCls:'icon-save',plain:true">发送</a> </p>
			</div>
		</div>
	</div>
	<div id="editPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
</div>

<script type="text/javascript">
	var spu2pi = {};
	spu2pi.pageId = '#spu2PiPage';
	spu2pi.dgId = spu2pi.pageId + ' #dg';
	spu2pi.toolBar = spu2pi.pageId + ' #tb';
	spu2pi.listId = spu2pi.pageId + ' #listPanel';

	/**
	 * 页面初始化函数
	 */
	spu2pi.inits = function() {
		$(spu2pi.dgId).datagrid({
			rownumbers : true,
			striped : true,
			fitColumns : true,
			singleSelect : true,
			height : $.o2m.centerHeight - 20,
			toolbar : spu2pi.toolBar,
			pagination : true,
			pageSize : 20,
			checkbox : true,
			idField : 'id',
			url : 'spu/allList',
			columns : [ [ {
				field : 'id',
				checkbox : true
			}, {
				field : 'code',
				title : '编码',
				width : 50,
				align : "center"
			}, {
				field : 'name',
				title : '名称',
				align : "center",
				width : 100
			}, {
				field : 'updateAt',
				title : '更新时间',
				align : "center",
				width : 50
			},{
				field : 'status',
				title : '状态',
				align : "center",
				width : 50,
				formatter : function(value,row) {
					if(value < 0 ){
						return "<span stayle = 'color:red'>注销<span>";
					}
					return "<span>正常<span>";
				}
			},{
				field : 'handler',
				title : '操作',
				align : "center",
				width : 50,
				formatter : function(value,row) {
					return "<a href='#' onClick='spu2pi.sendByCode(\""+row.code+"\")'>发送</a>";
				}
			} ] ],
			loadMsg : "数据加载中..."
		});
	};
	//查询
	$(spu2pi.pageId + ' #btnSearch').on(
			"click",
			function() {
				$(spu2pi.dgId).datagrid("clearChecked");
				$(spu2pi.dgId).datagrid(
						"load",
						$.o2m
								.serializeObject($(spu2pi.pageId
										+ " #searchForm")));
			});
	$(spu2pi.pageId + ' #sendByTime').on("click", function() {
		$.ajax({
			type : "POST",
			url : "spu/sendSpuToPi",
			dataType : "json",
			data : {
				startTime : $(spu2pi.pageId +' #kssj').datetimebox('getValue'),
				endTime : $(spu2pi.pageId +' #jssj').datetimebox('getValue')
			},
			success : function(msg) {
				if ($.o2m.handleActionResult(msg)) {
				}
			}
		});
	});
	
	spu2pi.sendByCode = function(code){
		$.ajax({
			type : "POST",
			url : "spu/sendSpuToPi",
			dataType : "json",
			data : {
				code : code
			},
			success : function(msg) {
				if ($.o2m.handleActionResult(msg)) {
				}
			}
		});
		
	}
	//发送
	$(spu2pi.pageId + ' #btnSendToPi').on("click", function() {
		var rows = $(spu2pi.dgId).datagrid('getChecked');
		if (!rows || rows.length == 0) {
			$.messager.alert('提示', '请选择SPU记录。', 'info');
		} else if (rows.length > 1) {
			$.messager.alert('提示', '您只能选择一个SPU!', 'info');
		} else {
			$.ajax({
				type : "POST",
				url : "spu/sendSpuToPi",
				dataType : "json",
				data : {
					code : rows[0].code
				},
				success : function(msg) {
					if ($.o2m.handleActionResult(msg)) {
					}
				}
			});
		}
	});
	spu2pi.inits();
</script>