<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#indexGoodSpuNameMagnifierWindow1{
	padding-left: 50px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="indexGoodSpuNameMagnifierWindow1">
<input type="hidden" value="${orderNum}" id="orderNumId">
	<table style="margin:10px,10px;border: 1px,solid,#2894FF;">
		<tr>
			<td width="100px"></td>
			<td></td>
			<td>SPU编码</td>
			<td>
				<input id="spuCodeId" name="spuCode" type="text" class="inputbox inputTxtByName" placeholder="请输入SPU编码" />
			</td>
			<td>商品名称</td>
			<td>
				<input id="spuNameId" name="spuName" type="text" class="inputbox inputTxtByName" placeholder="请输入商品名称" />
			</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="serchSpuName1()">搜索</a>
			</td>
			<td></td>
			<td></td>
		</tr>
	</table>
</div>

<div>
	<table id="spuName1"></table>
</div>
<div><a href="javascript:void(0);" id="backbtn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="indexGoodSpuName1.returnToListPage();">返 回</a>
</div>
<script type="text/javascript" src="common/js/wdIndexGoods/indexGood_SpuName_Magnifier_Window1.js"></script>
