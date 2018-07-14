<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#activityMagnifierWindow{
	padding-left: 50px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="activityMagnifierWindow">
<input type="hidden" value="${salAgencyCode}" id="salAgencyCode">
	<table style="margin:10px,10px;border: 1px,solid,#2894FF;">
		<tr>
			<td width="100px"></td>
			<td></td>
			<td>活动号</td>
			<td>
				<input id="activityId" name="activityId" type="text" />
			</td>
			<td>活动名称</td>
			<td>
				<input id="activityName" name="activityName" type="text"/>
			</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="serchSkuName()">搜索</a>
			</td>
			<td></td>
			<td></td>
		</tr>
	</table>
</div>

<div>
	<a href="javascript:void(0);" id="backbtn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="zeroBuyMagnifierManage.returnToListPage();">返 回</a>
	<table id="activity"></table>
</div>


<script type="text/javascript" src="common/js/zeroBuy/zeroBuy_Magnifier_Window.js"></script>
