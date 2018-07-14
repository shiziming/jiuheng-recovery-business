<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>

#newCouponMagnifierWindow{
	padding-left: 50px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="newCouponMagnifierWindow">
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
</div>

<div>
	<table id="newCoupon"></table>
</div>
<div><a href="javascript:void(0);" id="backbtn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="newCoupon.returnToListPage();">返 回</a>
</div>
<script type="text/javascript" src="common/js/applyCoupon/newCoupon_Magnifier_Window.js"></script>
