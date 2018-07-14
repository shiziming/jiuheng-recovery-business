<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#spuPage #editPanel td:first-child {
	width: 150px;
}
#spuPage #editPanel .input-content {
	width: 150px;
}
</style>
<div id="indexGood_AddIndexGoodsDetail">
<div style="width: 100%; background-color: #eff5ff;" id="indexGood_AddIndexGoodsDetail_form">
<input type="hidden" value="${indexGoods.orderNum}" id="orderNumId">
<input type="hidden" value="${indexGoods.goodsSPUID}" id="goodsSPUIDId">
<form>
	<fieldset>
		<legend>首页商品操作</legend>
		<table>
			<tr>
				<td width="80px" align="center">商品SPUID:</td>
				<td width="120px" ><input id="spuIdID" name="spuId" class="easyui-searchbox" data-options="required:true" editable="false" style="width: 100%" value="${indexGoods.goodsSPUID}"/></td>
				<td width="20px"></td>
				<td width="80px" align="center">商品SPU代码:</td>
				<td width="120px"><input class="easyui-textbox" id="spuCodeID" name="spuCode"  disabled="disabled" style="width: 100%;" value="${indexGoods.spuCode}"/></td>
			</tr>
			<tr>
				<td width="80px" align="center">商品名称:</td>
				<td width="120px"><input id="spuNameID" name="spuName" class="easyui-textbox"  disabled="disabled" style="width: 100%;" value="${indexGoods.spuName}"/></td>
				<td width="20px"></td>
				<td width="80px">图片显示位置</td>
				<td width="120px">
					<select id="showNumid" class="easyui-combobox" name="showNum" style="width: 100%;" editable="false" data-options="panelHeight: 'auto'">   
					    <option value="0">--请选择--</option>   
					    <option ${1==indexGoods.showNum?"selected='selected'":""} value="1">1</option>   
					    <option ${2==indexGoods.showNum?"selected='selected'":""} value="2">2</option>   
					    <option ${3==indexGoods.showNum?"selected='selected'":""} value="3">3</option>   
					    <option ${4==indexGoods.showNum?"selected='selected'":""} value="4">4</option>
					    <option ${5==indexGoods.showNum?"selected='selected'":""} value="5">5</option>
					    <option ${6==indexGoods.showNum?"selected='selected'":""} value="6">6</option> 
					</select>
				</td>
			</tr>
		</table>
		<div style="padding: 10px 20px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;" onclick="indexGoodAddDetail.createIndexGoods();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="indexGoodAddDetail.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>

	</fieldset>
</form>
</div>
<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier_SpuName_window"></div>
</div>
<script type="text/javascript" src="common/js/wdIndexGoods/indexGood_AddIndexGoodsDetail_Window.js"></script>
