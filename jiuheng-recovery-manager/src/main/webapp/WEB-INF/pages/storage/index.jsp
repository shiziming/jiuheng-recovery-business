<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div id="storage_index">
	<div id="list_panel" class="easyui-panel" style="width:100%">
		<div id="list_search_panel" class="easyui-panel" title="查询条件" data-options="collapsible:true"
			style="width: 100%; height: 80px;background: #ffffff;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 2px 1% 0px 1%">
					<tr>
						<td width="80px" align="center">地址区域代码</td>
						<td width="80px"><input class="easyui-numberbox" name="addressAreaCode"  data-options="required:true"></td>
						<td width="80px" align="center">SKUID</td>
						<td width="80px"><input  class="easyui-numberbox" name="skuId" data-options="required:true"></td>
					    <td width="80px" align="center">国美品牌标记</td>
						<td width="100px"><select id="isGome" name="isGome" class="easyui-combobox" style="width:100px;"
						 data-options="editable:false">
								<option value=1 selected="selected">国美</option>
								<option value=0>非国美</option>
						</select></td>
						<td width="80px" align="center"></td>
						<td align="left" colspan="2"><a href="#" id="list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false" >
			<table id="dg"></table>
		</div>
    </div>
</div>
    <script type="text/javascript"	src="common/js/storage/index.js"></script>
