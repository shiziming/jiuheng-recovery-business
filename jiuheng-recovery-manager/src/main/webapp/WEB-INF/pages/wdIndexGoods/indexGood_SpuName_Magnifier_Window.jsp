<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#indexGoodSpuNameMagnifierWindow{
	padding-left: 50px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="indexGoodSpuNameMagnifierWindow">
<input type="hidden" value="${i}" id="i">
<input type="hidden" value="${salAgencyCode}" id="salAgencyCodeId">
	<table style="margin:10px,10px;border: 1px,solid,#2894FF;">
		<tr>
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
			<td>关键词</td>
			<td>
				<input id="keyWord" name="keyWord" type="text" class="inputbox inputTxtByName" placeholder="请输入品牌搜索关键词" />
			</td>
			<td></td>
			<td></td>
			<td align="center">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="serchSpuName()">搜索</a>
			</td>
			<td></td>
			<td></td>
		</tr>
	</table>
</div>

<div>
	<table id="spuName"></table>
</div>
<div><a href="javascript:void(0);" id="backbtn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="indexGoodSpuName.returnToListPage();">返 回</a>
</div>
<script type="text/javascript" src="common/js/wdIndexGoods/indexGood_SpuName_Magnifier_Window.js"></script>
