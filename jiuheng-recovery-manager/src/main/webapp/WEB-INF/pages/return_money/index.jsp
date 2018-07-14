<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="check_return_money">
<!-- 财务审核退款查询列表 -->
	<div id="return_list_panel" class="easyui-panel">
		<div id="check_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 1% 0px 1%">
					<tr>
						<td width="100px" align="center">退款单号</td>
						<td width="100px"><input  class="easyui-textbox" name="returnId" type="text"></td>
						<td width="100px" align="center">退款单状态</td>
						<td width="100px"><select id="retStatus" name="retStatus" class="easyui-combobox" style="width: 132px;">
								<option value="" selected="selected"></option>
								<option value="8">财务审核退款中</option>
								<option value="9">已通知微店退款</option>
								<!-- <option value="-3">财务审核未通过</option> -->
								<option value="10">微店已退款</option>
								<option value="11">微店退款不成功</option>
								<option value="12">线下退款成功</option>
						</select></td>
						<!-- <td width="100px" align="center">支付公司代码</td>
						<td width="100px"><input class="easyui-textbox" name="payCompanyId" type="text"></td>
			 			<td width="100px" align="center">销售公司代码</td>
						<td width="100px"><input class="easyui-textbox" name="saleCompanyId" type="text"></td> -->
					</tr>
					<tr>
						<td width="100px" align="center">申请日期</td>
						<td width="200px"><input id="start" style="width:132px"
							placeholder="起始日期" class="easyui-datebox" name="applyDate1" type="text" />至
							<input id="jsrq" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="applyDate2" type="text" /></td>
						<td width="100px" align="center">审核日期</td>
						<td width="200px"><input id="end" style="width: 132px"
							placeholder="起始日期" class="easyui-datebox" name="checkDate1" type="text" />至
							<input id="jsrq" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="checkDate2" type="text" /></td>
						<td align="left" colspan="2"><a href="#" id="return_list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="check_list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
       </div>
	<!-- 微店退款审核界面 -->
	<div class="easyui-panel" id="check_panel" data-options=" closed:true, cache:false" style="display:block">
	
	</div>
		<!-- 微店退款查看界面 -->
	<div class="easyui-panel" id="view_panel" data-options=" closed:true, cache:false" style="display:block">
	
	</div>
		<!-- 线下退款界面 -->
	<div class="easyui-panel" id="underline_panel" data-options=" closed:true, cache:false" style="background-color:#eff5ff;">
	
	</div>
</div>
    <script type="text/javascript"	src="common/js/return_money/return_money.js"></script>


