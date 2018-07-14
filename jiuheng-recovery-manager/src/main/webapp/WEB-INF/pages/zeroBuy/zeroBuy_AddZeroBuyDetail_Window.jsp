<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#spuPage #editPanel td:first-child {
	width: 150px;
}
#spuPage #editPanel .input-content {
	width: 150px;
}
</style>
<div id="zeroBuy_AddZeroBuyDetail">
<div style="width: 100%; background-color: #eff5ff;" id="zeroBuy_AddzeroBuyDetail_form">
<input type="hidden" value="${zeroBuy.orderNum}" id="orderNumId">
<input type="hidden" value="${zeroBuy.skuID}" id="skuIdID">
<form>
	<fieldset>
		<legend>促销商品修改</legend>
		<table>
			<tr>	
				<td width="80px" align="center">商品SkuID:</td>
				<td width="120px" ><input id="skuID" name="skuID" class="easyui-textbox" editable="false"  style="width: 100%" value="${zeroBuy.skuID}"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">商品名称:</td>
				<td width="120px"><input id="skuName" name="skuName" class="easyui-textbox" disabled="disabled" style="width: 100%;" value="${zeroBuy.skuName}"/></td>
			</tr>
			<tr>
				<td width="80px" align="center">限制数量:</td>
				<td width="120px"><input id="limitNum" name="limitNum" class="easyui-textbox"   style="width: 100%;" value="${zeroBuy.limitNum}"/></td>
				<td width="20px"></td>
				<td width="80px">配送费用</td>
				<td width="120px"><input id="distributionFee" name="distributionFee" class="easyui-textbox"   style="width: 100%;" value="${zeroBuy.distributionFee}"/></td>
			</tr>
		</table>
		<div style="padding: 10px 20px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;" onclick="zeroBuyAddDetail.createzeroBuy();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="zeroBuyAddDetail.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>

	</fieldset>
</form>
</div>
<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier_SkuName_window"></div>
</div>
<script type="text/javascript" src="common/js/zeroBuy/zeroBuy_AddZeroBuyDetail_Window.js"></script>
