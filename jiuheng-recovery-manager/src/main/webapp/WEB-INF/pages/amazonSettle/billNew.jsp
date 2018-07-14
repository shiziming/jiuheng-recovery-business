<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">

</style>
<div id="settleBillCheckPage">

	<div style="padding:15px" id="settleBillCheckPage_addBill">
		<form action="" id="settleBillCheckPage_form">
		<table>
					<tr >
						<td style="text-align: right; width: 150px">
							公司代码：
						</td>
						<td>
							<input type="text" id="settleBillNew_companyId" name="companyId"  class="easyui-validatebox" data-options="required:true " />
<%-- 							value="${companyId}"  disabled="disabled" --%>
						</td>
					</tr>
					<tr >
						<td style="text-align: right; width: 150px">
							销售组织代码：
						</td>
						<td>
						   	<input type="text" id="settleBillNew_saleOrgId" name="saleOrgId"  class="easyui-validatebox" data-options="required:true " />
						</td>
					</tr>
					<tr>
					    <td style="text-align: right; width: 170px">
							结算出账日期：
						</td>
						<td>
							<input type="text" id="settleBillNew_time3" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
						</td>
					</tr>
					<tr>
                        <td style="text-align: right; width: 170px">
							结算起止时间：
						</td>
						<td>
							<input type="text" id="settleBillNew_time1" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
							- <input type="text" id="settleBillNew_time2" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
						</td>
						<td style="text-align: right; width: 100px">
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="SettleBillNewUtils.addBill(this)">添加</a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="SettleBillNewUtils.back()">返回</a>
						</td>
					</tr>
		</table>
		</form>
	</div>

</div>

<script type="text/javascript" src="common/js/amazonSettle/billNew.js"></script>
