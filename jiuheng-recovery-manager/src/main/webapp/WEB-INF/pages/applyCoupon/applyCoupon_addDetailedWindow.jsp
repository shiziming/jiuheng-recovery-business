<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="applyCoupon_Add">
<input type="hidden" value="${applyCoupon.orderNum}" id="orderNum1">
	<table id="applyCoupondg"></table>
	<form id="searchForm1">
		<table class="table table-hover table-condensed"
			style="width: 100%; padding: 7px 80px 0px 80px">
			<tr>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%" align="center">
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					id="but" onclick="applyCoupon_addss.saveNew();">保存</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="applyCoupon_addss.back();">返回</a></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	</form>
	<div id="tb1" style="display: none;">
		<a href="javascript:void(0);"	class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="applyCoupon_addss.addRow();">增加</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true" onclick="applyCoupon_addss.delRow();">删除</a>
	</div>
	<div class="easyui-window" data-options="closed:true,cache:false" id="couponMagnifier"></div>
</div>

<script type="text/javascript"	src="common/js/applyCoupon/applyCoupon_addDetailedWindow.js"></script>