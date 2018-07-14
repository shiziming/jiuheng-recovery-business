<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">

</style>
<div id="gmzxSettleBillCheckPage">

	<div style="padding:15px" id="gmzxSettleBillCheckPage_addBill">
		<form action="" id="gmzxSettleBillCheckPage_form">
		<table>
					<tr >
						<td style="text-align: right; width: 150px">
							平台店铺ID：
						</td>
						<td>
							<select id="gmzxSettleBillNew_popShopId" class="easyui-combobox" name="" editable="true" data-options="required:true " style="width:100px;">
							    <option value="">请选择</option>
							    <option value="80011302">国美电器</option>
							    <option value="80011384">大中电器</option>
							    <option value="80011385">永乐电器</option>
							</select>
						</td>
					</tr>
					<tr>
                        <td style="text-align: right; width: 170px">
							结算起止时间：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillNew_time1" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
							- <input type="text" id="gmzxSettleBillNew_time2" name="" value="" class="easyui-datebox" data-options="required:true"   editable="false"/>
						</td>
						<td style="text-align: right; width: 100px">
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="GmzxSettleBillNewUtils.addBill(this)">添加</a>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="GmzxSettleBillNewUtils.back()">返回</a>
						</td>
					</tr>
		</table>
		</form>
	</div>

</div>

<script type="text/javascript" src="common/js/gmzxSettle/billNew.js"></script>
