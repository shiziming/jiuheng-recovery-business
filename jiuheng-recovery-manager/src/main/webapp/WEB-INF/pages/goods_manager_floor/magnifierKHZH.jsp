<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#indexGoodSpuNameMagnifierWindow{
	padding-left: 50px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="indexGoodSpuNameMagnifierWindow11">
<input type="hidden" value="${i}" id="i">
<input type="hidden" value="${salAgencyCode}" id="salAgencyCodeId">
<input type="hidden" value="${xszzdm}" id="xszzdm">
<input type="hidden" value="${xsqddm}" id="xsqddm">
	<table style="margin:10px,10px;border: 1px,solid,#2894FF;">
		<tr>
			<td width="100px"></td>
			<td></td>
			<td>SKUID</td>
			<td>
				<input id="spuCodeId" name="spuCode" type="text" class="inputbox inputTxtByName" placeholder="请输入SKUID" />
			</td>
			<td>SKU名称</td>
			<td>
				<input id="spuNameId" name="spuName" type="text" class="inputbox inputTxtByName" placeholder="请输入SKU名称" />
			</td>
		</tr>
		<tr>
			<td></td>
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
				onclick="splc_indexGoodSpuName.returnToListPage();">返 回</a>
</div>
<script type="text/javascript" src="common/js/goods_manager_floor/magnifierKHZH.js"></script>
