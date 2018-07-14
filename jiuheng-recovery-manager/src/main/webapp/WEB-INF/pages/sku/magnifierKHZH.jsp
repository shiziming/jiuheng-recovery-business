<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- SKU查询放大镜-->
<div id="skuQueryFDJ" class="content">

	<!-- 列表-->
	<table id='dgtable'
		style="text-align: center; width: 100%; height: 100%; padding: 15px"></table>
				<div id="tb" style="height: auto">
				<div class="search1">
					<form id="searchForm">
						<table>
							<tr>
								<td class="label">sku码:<input name="skuCode" /></td>
								<td class="label">sku名称:<input name="name" /></td>
								<td class="label"><a id="btnSearch"
									class="easyui-linkbutton"
									data-options="iconCls:'icon-search',plain:true">查 询</a></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		<input type="hidden" id="type" value="${type}">
<script type="text/javascript">
	var type = "${type}";
	$('#skuQueryFDJ #dgtable').datagrid({
		striped : true,
		fitColumns : true,
		toolbar : '#skuQueryFDJ #tb',
		url : 'sku/list',
		onDblClickRow : function(index, row){
			if(type == '1'){
				$('#spuPage #spuName').searchbox('setValue', row.name);
			}else if(type == '2'){
				$(spu.panelId + " #skuTable").datagrid('updateRow',{
					index: parseInt(spu.bindSkuTempIndex),
					row: {
						id : row.id,
						skuCode: row.skuCode,
						skuName: row.name,
						isNew : true
					}
				});
			}
			$('#magnifier_window').window('close');
		},
		onBeforeLoad : function(param){
			if(param.name == undefined && param.skuCode == undefined){
				return false;
			}
		},
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		checkbox : true,
		columns : [ [ {
			field : 'skuCode',
			title : '编码',
			width : 150
		}, {
			field : 'name',
			title : '名称',
			width : 250
		} ] ],
		loadMsg : "数据加载中..."
	});
	if(type == '1'){
		var skuName = $('#spuPage #spuName').searchbox('getValue')
		if(skuName != ''){
			$('#skuQueryFDJ #dgtable').datagrid('load',{name : skuName});
		}
	}else if(type == '2'){
		if(spu.bindSkuTempCode != ''){
			$('#skuQueryFDJ #dgtable').datagrid('load',{skuCode : spu.bindSkuTempCode});
		}
	}
	//查询按钮
	$('#skuQueryFDJ #btnSearch').on('click', function(event) {
		var searchObj = $.o2m.serializeObject($("#skuQueryFDJ #searchForm"));
		$('#skuQueryFDJ #dgtable').datagrid("reload", searchObj);
	});
</script>
</div>