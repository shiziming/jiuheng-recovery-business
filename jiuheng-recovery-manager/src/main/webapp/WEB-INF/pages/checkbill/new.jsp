<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">

</style>
<div id="checkBillCheckPage">

	<div style="padding:15px" id="checkBillCheckPage_addBill">
		<form action="" id="checkBillCheckPage_form">
		<table>
					<tr >
						<td style="text-align: right; width: 150px">
							支付公司代码：
						</td>
						<td>
							<input type="text" id="checkBillNew_payCompCode" name="payCompanyCode" value="${companyId}" class="easyui-validatebox" data-options="required:true " disabled="disabled" />
						</td>
					</tr>
					<tr >
						<td style="text-align: right; width: 150px">
							支付方式：
						</td>
						<td>
							<select id="checkBillNew_payType" class="easyui-combobox" name="payType" style="width:150px;" data-options="required:true">
							    <option value="12">微信</option>
							    <option value="13">银联</option>
							    <option value="11">支付宝</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 170px">
							线上订单支付明细起止时间：
						</td>
						<td>
							<input type="text" id="checkBillNew_time1" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
							- <input type="text" id="checkBillNew_time2" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 170px">
							资金到账日期：
						</td>
						<td>
							<input type="text" id="checkBillNew_time3" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
						</td>
						<td style="text-align: right; width: 100px">
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="CheckBillNewUtils.addBill(this)">添加</a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="CheckBillNewUtils.back()">返回</a>
						</td>
					</tr>
		</table>
		</form>
	</div>

</div>

<script type="text/javascript" src="common/js/checkbill/new.js"></script>
