<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#applyCouponMagnifierWindow{
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="applyCouponMagnifierWindow">
<input type="hidden" value="${i}" id="i">
	<table style="margin:10px,10px;border: 1px,solid,#2894FF;">
		<tr>
			<td width="100px"></td>
			<td></td>
			<td>优惠券类型</td>
			<td>
				<input id="couponType" name="couponType" type="text" class="inputbox inputTxtByName" placeholder="请输入优惠券类型" />
			</td>
			<td>优惠券名称</td>
			<td>
				<input id="couponName" name="couponName" type="text" class="inputbox inputTxtByName" placeholder="请输入优惠券名称" />
			</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="serchCoupon()">搜索</a>
			</td>
			<td></td>
			<td></td>
		</tr>
	</table>
<div>
	<table id="applyCoupondg"></table>
</div>
<div><a href="javascript:void(0);" id="backbtn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="applyCouponMagnifier.returnToListPage();">返 回</a>
</div>
</div>
<script type="text/javascript" src="common/js/applyCoupon/applyCoupon_Magnifier_Window.js"></script>
