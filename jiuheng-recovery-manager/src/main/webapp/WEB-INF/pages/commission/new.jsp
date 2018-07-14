<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">

</style>
<div id="commissionNewPage">
<div id="msg"></div>
	<!-- toolbar -->
	<div id="commissionNewPage_tb" class="easyui-panel">
		<table>
			<tr>
				<td>
					<a href="javascript:void(0)" id="commissionNewPage_href_back" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="CommissionNewUtils.back()">返回</a>
				</td>
			</tr>
		</table>
	</div>

	<div style="padding:15px" id="commissionNewPage_panel" class="easyui-panel" title="单头信息" >
				<table id="commissionNewPage_table_head">
					<tr>
						<td style="text-align: right; width: 100px">
							单据编号：
						</td>
						<td>
							<input type="text" id="commissionNewPage_billId" value="" class="easyui-textbox" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							状态：
						</td>
						<td>
							<input type="text" id="commissionNewPage_status" value="" class="easyui-textbox" disabled="true"/>
						</td>
					</tr>
					<tr >
						<td style="text-align: right; width: 100px">
							销售组织代码：
						</td>
						<td>
							<input type="text" id="saleOrgCodeNew" value="" class="easyui-textbox"  disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							销售组织名称：
						</td>
						<td>
							<input type="text" id="saleOrgNameNew" value="" class="easyui-textbox" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							单据机构代码：
						</td>
						<td>
							<input type="text" id="billOrgNew" value="" class="easyui-textbox" disabled="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 100px">
							制单人ID：
						</td>
						<td>
							<input type="text" id="createUserNew" value="" class="easyui-textbox" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							制单人：
						</td>
						<td>
							<input type="text" id="createNameNew" value="" class="easyui-textbox" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							制单时间：
						</td>
						<td>
							<input type="text" id="createTimeNew" value="" class="easyui-textbox" disabled="true"/>
						</td>
					</tr>
				</table>
	</div>
	<div title="已选中订单分单" style="overflow:auto;padding:10px;" class="easyui-panel" >
			<!-- 已选中数据列表 -->
			<div>
				<input type="hidden" id="commissionBillId"/>
			</div>
			<div id="commissionNewPage_selected_dg" style="height: 300px"></div>
				
	</div>
	
	<div title="备选订单分单" data-options="selected:true"  style="overflow:auto;padding:10px;"  class="easyui-panel">
			<div id="commissionNewPage_function">
			</div>
			
			<!-- 备选数据列表 -->
			<div id="commissionNewPage_dg" style="height: 300px"></div>
		
		
	</div>
	
	
	
	<!-- toolbar -->
	<div id="commissionNewPage_tb1" class="easyui-panel">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="CommissionNewUtils.remove()">移除</a>
	</div>

	<div id="commissionNewPage_tb2" class="easyui-panel">
			<form id="commissionNewPage_search" >
				<table id="commissionNewPage_table_search">
					<tr >
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="CommissionNewUtils.add()">添加</a>
						</td>
						<td style="width: 100px"> </td>
						<td style="text-align: right; width: 80px">
							销售组织：
						</td>
						<td>
							<input type="text" id="saleOrgCode" value="" class="easyui-textbox" style="width: 70px"/>
						</td>
						<td style="text-align: right; width: 80px">
							起止日期：
						</td>
						<td>
							<input type="text" id="startDay_new" value="" class="easyui-datebox" style="width: 100px"/>
							- <input type="text" id="endDay_new" value="" class="easyui-datebox" style="width: 100px"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CommissionNewUtils.search()">查询</a>
						</td>
					</tr>
				</table>
			</form>
	</div>
	

</div>

<script type="text/javascript" src="common/js/commission/new.js"></script>
