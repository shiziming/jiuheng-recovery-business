<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#applyCouponActivityMagnifierPage{
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="applyCouponActivityMagnifierPage">
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
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="applyCouponActivityMagnifier.serchApplyCoupon()">搜索</a>
			</td>
			<td></td>
			<td></td>
		</tr>
	</table>
<div>
	<a href="javascript:void(0);" id="backbtn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="applyCouponActivityMagnifier.returnToListPage();">返 回</a>
	<table id="applyCouponActivityMagnifier"></table>
</div>
</div>
<script type="text/javascript" src="common/js/applyCoupon/applyCouponActivity_Magnifier_Window.js"></script>
