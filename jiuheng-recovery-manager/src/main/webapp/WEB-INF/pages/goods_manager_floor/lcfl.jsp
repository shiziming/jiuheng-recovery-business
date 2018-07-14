<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 楼层查询放大镜-->
<div id="skuQueryFDJ1" class="content">
	<!-- 列表-->
	<table id='dgtable' style="text-align: center; width: 100%; height: 100%; padding: 15px"></table>
				<div id="tb" style="height: auto">
				<div class="search1">
					<form id="searchForm">
						<table>
							<tr>
								<td class="label">二级类目编码:<input id="spptfldm" name="spptfldm" /></td>
								<td class="label">二级类目名称:<input id="spflmc" name="spflmc" /></td>
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
	$(function(){
		//alert(123);
		$('#dgtable').datagrid({
			striped : true,
			fitColumns : true,
			toolbar : '#skuQueryFDJ1 #tb',
			url : 'wareFloor/queryLcfl',
			onDblClickRow : function(index, row){
 				//alert(row.spptfldm);
 				//alert(row.spflmc);
				$(splc_goods_up.spptfldm).val(row.spptfldm);
				$(splc_goods_up.spptflmc).textbox("setValue",row.spflmc);
				$('#magnifier').window('close');
			},
			onBeforeLoad : function(param){
				if(param.name == undefined && param.spptfldm == undefined){
					return false;
				}
			},
			singleSelect : true,
			rownumbers : true,
			pagination : true,
			pageSize : 20,
			checkbox : true,
			columns : [ [ {
				field : 'spptfldm',
				title : '编码',
				width : 150
			}, {
				field : 'spflmc',
				title : '名称',
				width : 250
			} ] ],
			loadMsg : "数据加载中..."
		});
		
		//查询按钮
		$('#skuQueryFDJ1 #btnSearch').on('click', function(event) {
			//var searchObj = $.o2m.serializeObject($("#skuQueryFDJ #searchForm"));
			//$('#skuQueryFDJ #dgtable').datagrid("reload", searchObj);
			
			var spptfldm=$('#skuQueryFDJ1 #spptfldm').val();
			//alert(spptfldm);
			var spptflmc=$('#skuQueryFDJ1 #spflmc').val();
			//alert(spptflmc);
			$('#skuQueryFDJ1 #dgtable').datagrid("load", {
					spptfldm:spptfldm,
					spflmc:spptflmc
				}
			);
			
			
		});
	})
	
</script>
</div>