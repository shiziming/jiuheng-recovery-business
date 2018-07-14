<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="fail_return_money">
<!-- 退款失败查询列表 -->
	<div id="return_fail_panel" class="easyui-panel" >
		<div id="check_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="overflow:auto;width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 7px 1% 0px 1%">
					<tr>
						<td width="100px" align="center">支付方式</td>
						<td width="100px"><select id="payMethod" name="payMethod" class="easyui-combobox" data-options="editable:false" style="width: 132px;">
								<option value="11" selected="selected">支付宝</option>
								<option value="12">微信</option>
								<option value="13">银联</option>
						</select></td>
						<td width="100px" align="center">退款重试状态</td>
						<td width="100px"><select id="status" name="status" class="easyui-combobox" style="width: 132px;">
								<option value="1">尝试中</option>
								<option value="2">结束</option>
						</select></td>
						<td width="100px" align="center">尝试日期</td>
						<td width="200px"><input id="start" style="width: 132px"
							placeholder="起始日期" class="easyui-datebox" name="start" type="text" />至
							<input id="end" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="end" type="text" /></td>
						<td align="left" colspan="2"><a href="#" id="return_list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
       </div>
</div>
    <script type="text/javascript"	src="common/js/return_money/fail.js"></script>


