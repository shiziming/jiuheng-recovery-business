<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#spuPage #editPanel td:first-child {
	width: 150px;
}
#spuPage #editPanel .input-content {
	width: 150px;
}
</style>
<div id="edit_dastorsgeDetail">
<div style="width: 100%; background-color: #eff5ff;" id="dastorsgeDetail_form">
<form>
	<fieldset>
		<legend>带安库存设置单明细修改</legend>
		<table>
			<tr>	
				<td width="80px" align="center">单据编号:</td>
				<td width="120px" ><input id="billId" name="billId" class="easyui-textbox" editable="false" disabled="disabled" style="width: 100%" value="${detail.billId}" readonly="readonly"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">库存地点代码:</td>
				<td width="120px"><input id="storagePlaceCode" name="storagePlaceCode" class="easyui-textbox" disabled="disabled" style="width: 100%;" value="${detail.storagePlaceCode}" readonly="readonly"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">商品内码:</td>
				<td width="120px"><input id="skuId" name="skuId" class="easyui-textbox"   style="width: 100%;" disabled="disabled" value="${detail.skuId}" readonly="readonly"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">渠道代码</td>
				<td width="120px"><input id="channelCode" name="channelCode" class="easyui-textbox"   disabled="disabled" style="width: 100%;" value="${detail.channelCode}" readonly="readonly"/></td>
			</tr>
			<tr>
			    <td width="80px" align="center">业务机型</td>
				<td width="120px"><input id="serviceType" name="serviceType" class="easyui-textbox"   disabled="disabled" style="width: 100%;" value="${detail.serviceType}" readonly="readonly"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">供应商代码</td>
				<td width="120px"><input id="supplierCode" name="supplierCode" class="easyui-textbox"   disabled="disabled" style="width: 100%;" value="${detail.supplierCode}" readonly="readonly"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">原库存数量:</td>
				<td width="120px"><input id="oldStorageNum" name="oldStorageNum" class="easyui-textbox"   disabled="disabled" style="width: 100%;" value="${detail.oldStorageNum}" readonly="readonly"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">销售数量</td>
				<td width="120px"><input id="saleNum" name="saleNum" class="easyui-textbox"   disabled="disabled" style="width: 100%;" value="${detail.saleNum}"readonly="readonly"/></td>
			</tr>
			<tr>
			    <td width="80px" align="center">新库存数量</td>
				<td width="120px"><input id="newStorageNum" name="newStorageNum" class="easyui-textbox"   style="width: 100%;" value="${detail.newStorageNum}"/></td>
				
			</tr>
		</table>
		<div style="padding: 10px 20px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;" onclick="dastorage_view.save();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="dastorage_view.back_view();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>

	</fieldset>
</form>
</div>
<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier_SkuName_window"></div>
</div>
<script type="text/javascript" src="common/js/zeroBuy/zeroBuy_AddZeroBuyDetail_Window.js"></script>
