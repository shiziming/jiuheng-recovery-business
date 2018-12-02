<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="user_index">
	<div id="list_panel" class="easyui-panel" style="width:100%">
		<div id="list_search_panel" class="easyui-panel" title="查询条件" data-options="collapsible:true"
			style="width: 100%; height: 150px;background: #ffffff;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 2px 1% 0px 1%">
					<tr>
						<%--<td width="80px" align="center">订单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="orderId"></td>
					    <td width="80px" align="center">订单状态</td>
						<td width="100px"><select id="orderStatus" name="orderStatus" class="easyui-combobox" editable="false" style="width:74%;">
								<option value="" selected="selected"></option>
								<option value="0">邮寄中</option>
								<option value="1">已完成</option>
								<option value="2">已下单</option>
								<option value="3">已退货</option>
						</select></td>--%>
						<td width="80px" align="center">客户名称</td>
						<td width="80px"><input name="name" type="text"></td>
						<td width="80px" align="center">客户手机号</td>
						<td width="80px"><input  class="easyui-numberbox" name="phone"></td>
						<td width="80px" align="center">订单提交日期</td>
						<td width="80px" colspan="2"><input id="createStartTime" style="width:100px"
															placeholder="起始日期" class="easyui-datebox" name="createStartTime" type="text" />至
							<input id="createEndTime" style="width: 100px" placeholder="结束日期" class="easyui-datebox" name="createEndTime" type="text" /></td>
						<td width="80px" align="center"></td>
						<td align="left" colspan="2"><a href="#" id="list_query"
														class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="list_reset"
							   class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
					<%--<tr>
						<td width="80px" align="center">支付方式</td>
						<td width="80px"><select id="payType" name="payType" class="easyui-combobox" style="width:74%;">
							<option value="" selected="selected"></option>
							<option value="11">支付宝</option>
							<option value="12">微信</option>
							<option value="13">银联</option>
							<option value="99">线下付款</option>
						</select></td>
						<td width="80px" align="center">订单提交日期</td>
						<td width="80px" colspan="2"><input id="subStartTime" style="width:100px"
							placeholder="起始日期" class="easyui-datebox" name="subStartTime" type="text" />至
							<input id="subEndTime" style="width: 100px" placeholder="结束日期" class="easyui-datebox" name="subEndTime" type="text" /></td>
						<td width="80px" align="center"></td>
						<td align="left" colspan="2"><a href="#" id="list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
						<td></td>
						<td></td>
					</tr>--%>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false" >
			<table id="dg"></table>
		</div>
		<div id="tb">
				<a href="#" id="exportBtn" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-save" plain="true" onclick="$('#order_index_exportWin').window('open');">导出当前查询的所有结果</a>
		</div>
		<div id="order_index_exportWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-excel'" title="导出向导" style="width:300px;height:180px;">
		    <form style="padding:10px 20px 10px 40px;" style="width:250px;">
		        <select id="exportType" name="exportType"  class="easyui-combobox"  type="text" style="width:200px;">
		        	<option value="excel2003">Excel 2003格式</option>   
    				<option value="excel2007">Excel 2007格式</option>   
		        </select>
		        <div style="padding:20px;text-align:center;">
		            <a href="#" class="easyui-linkbutton" id="order_index_exportBtn" icon="icon-ok" onclick="orderquery.exportExcel($('#order_index_exportWin #exportType').combobox('getValue'))">Ok</a>
		            <a href="#" class="easyui-linkbutton" icon="icon-cancel" onclick="$('#order_index_exportWin').window('close');">Cancel</a>
		        </div>
    		</form>
		</div>
    </div>
	<div class="easyui-panel" id="view_panel" data-options=" closed:true, cache:false" style="display:block;width:99%">
	
	</div>
</div>
    <script type="text/javascript"	src="common/js/user/index.js"></script>
