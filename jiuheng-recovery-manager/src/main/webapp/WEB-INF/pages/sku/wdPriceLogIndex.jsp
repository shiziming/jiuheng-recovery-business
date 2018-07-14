<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="wdPriceLog_index">
	<div id="list_panel" class="easyui-panel" style="width:100%">
	    <input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
		<div id="list_search_panel" class="easyui-panel" title="查询条件" data-options="collapsible:true"
			style="width: 100%; height: 80px;background: #ffffff;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 2px 1% 0px 1%">
					<tr>
						<td width="80px" align="center">销售组织代码</td>
						<td width="80px"><input  class="easyui-numberbox" name="saleOrgCode"></td>
						<td width="80px" align="center">SKU码</td>
						<td width="80px"><input  class="easyui-numberbox" name="skuId"></td>
						<td width="80px" align="center">价格类型</td>
						<td width="100px"><select id="priceType" name="priceType" class="easyui-combobox" editable="false" style="width:74%;">
								<option value="" selected="selected"></option>
								<option value="ZP47">佣金</option>
								<option value="ZP43">一口价集采</option>
								<option value="ZP44">一口价地采</option>
						</select></td>
					    <td width="80px" align="center">上传状态</td>
						<td width="100px"><select id="scbj" name="scbj" class="easyui-combobox" editable="false" style="width:74%;">
								<option value="" selected="selected"></option>
								<option value="1">成功</option>
								<option value="0">未上传</option>
								<option value="-1">失败</option>
						</select></td>
					
						<td align="left" colspan="2"><a href="#" id="list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
		<c:if test="${FUNC_MAINTAIN}">
		<div id="toolbar">
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-redo" plain="true" onclick="pricelogquery.push()">重新推送</a>
		 </div>
		 </c:if>
		<div data-options="border:false" >
			<table id="dg"></table>
		</div>
	</div>
</div>
    <script type="text/javascript"	src="common/js/sku/wdPriceLogIndex.js"></script>