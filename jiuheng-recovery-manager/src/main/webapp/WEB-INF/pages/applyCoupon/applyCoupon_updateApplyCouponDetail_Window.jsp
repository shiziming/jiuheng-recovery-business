<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="applyCoupon_Update_Page">
	<form id="updateForm">
	<table id="applyCouponAdd">
		<tr height="50px">
			<td width="10%" align="center" colspan="2">
							<input type="hidden" value="${applyCoupon.orderNum}" id="orderNum" name="orderNum">
							<input type="hidden" value="${applyCoupon.ordinal}" id="ordinal" name="ordinal">
							<a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="applyCoupon_update.queryActivity()">查询活动</a></td>
			<td width="8%" align="right">优惠券类型：</td>
			<td width="8%" align="left"	><input style="width: 99%"
							class="easyui-textbox" name="couponType"  id="couponType" editable="false" data-options="required:true" value="${applyCoupon.couponType}" /></td>
			<td width="8%" align="right">优惠券名称：</td>
			<td width="8%" align="left"	><input style="width: 99%"
							class="easyui-textbox" name="couponName"  id="couponName" editable="false" data-options="required:true" value="${applyCoupon.couponName}" /></td>
			<td width="10%" align="right">有效期开始：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="havefunBegin" type="text" id="havefunBegin" editable="false" value="${applyCoupon.havefunBegin}"/>
							<input  type="hidden" name="havefunBeginId"  id="havefunBeginId" editable="false" value="${applyCoupon.havefunBegin}"/>
							</td>
			<td width="10%" align="right">有效期结束：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="havefunEnd" type="text" id="havefunEnd" editable="false" value="${applyCoupon.havefunEnd}"/>
							<input  type="hidden" name="havefunEndId"  id="havefunEndId" editable="false" value="${applyCoupon.havefunEnd}"/>
							</td>
		</tr>
		<tr height="50px">
			<td width="7%" align="right">分组号：</td>
			<td width="8%" align="left">
					<input style="width: 99%" 
							class="easyui-textbox" name="groupNo" id="groupNo" data-options="required:true" value="${applyCoupon.groupNo}">
			</td>
			<td width="8%" align="right">优惠券数量：</td>
			<td width="8%" align="left"	><input style="width: 99%"
							class="easyui-textbox" name="couponNum"  id="couponNum"  data-options="required:true" value="${applyCoupon.couponNum}"/></td>
			<td width="10%" align="right">优惠券面值：</td>
			<td width="10%" align="left"><input style="width: 99%"
							class="easyui-textbox" name="couponPar"  id="couponPar"  data-options="required:true" value="${applyCoupon.couponPar}"/></td>
			<td width="10%" align="right">个人总限制值：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-textbox" name="pertitleLimits" id="pertitleLimits"  data-options="required:true" value="${applyCoupon.pertitleLimits}"/>
							</td>
			<td width="10%" align="right">总限制值：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-textbox" name="titleLimits" id="titleLimits"  data-options="required:true" value="${applyCoupon.titleLimits}"/>
							</td>			
			
		</tr>
	</table>
	</form>
		<table class="table table-hover table-condensed"
			style="width: 100%; padding: 7px 80px 0px 80px">
			<tr>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%" align="center">
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					 onclick="applyCoupon_update.save();">保存</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="applyCoupon_update.back();">返回</a></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	<div class="easyui-window" data-options="closed:true,cache:false" id="applyCouponMagnifier"></div>
</div>

<script type="text/javascript"	src="common/js/applyCoupon/applyCoupon_updateApplyCouponDetail_Window.js"></script>