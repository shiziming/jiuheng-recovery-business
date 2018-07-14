<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="applyCoupon_Add_Page">
	<table id="applyCouponAdd">
		<tr height="50px">
			<td width="10%"></td>
			<td width="10%" align="right"><a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="applyCoupon_add.queryActivity()">查询活动</a></td>
			<td width="8%" align="right">活动号：</td>
			<td width="8%" align="left"	><input style="width: 85%"
							class="easyui-textbox" name="activityId" id="activityId" editable="false" data-options="required:true" /></td>
			<td width="10%" align="right">活动名称：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-textbox" name="activityName"  id="activityName" editable="false" data-options="required:true" /></td>
			<td width="10%" align="right">活动开始时间：</td>
			<td width="10%" align="left"><input style="width: 85%"
						class="easyui-datebox" name="startDate" type="text" id="startDate" editable="false" data-options="required:true"/>
						<input  type="hidden" name="startDate"  id="startDateId" editable="false" />
						</td>
			<td width="10%" align="right">活动结束时间：</td>
			<td width="10%" align="left"><input style="width: 85%"
						class="easyui-datebox" name="endDate" type="text" id="endDate" editable="false" data-options="required:true"/>
						<input  type="hidden" name="endDate"  id="endDateId" editable="false" />
						</td>
		</tr>
		<tr height="50px">
			<td></td>
			<td></td>
			<td width="8%" align="right">渠道代码：</td>
			<td width="8%" align="left"	><input style="width: 85%"
							class="easyui-textbox" name="channelCode"  id="channelCode" data-options="required:true" /></td>
			<!-- <td width="10%" align="right">每月日集合：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-textbox" name="monthDayList"  id="monthDayList" data-options="required:true" /></td>
			<td width="10%" align="right">每周日集合：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-textbox" name=weekDayList id="weekDayList" data-options="required:true"/>
							</td>
			<td width="15%" align="right">每天时段集合：</td>
			<td width="10%" align="left"><input style="width: 85%"
						class="easyui-textbox" name="dayTimeList" id="dayTimeList" data-options="required:true"/>
						</td> -->
			<td width="10%" align="right">使用场景：</td>
			<td width="10%"><select id="sceneType" name="sceneType" class="easyui-combobox" editable="false" data-options="required:true" style='width: 85%;'>
					<option value="">--请选择--</option>
					<option value="1">购物</option>
					<option value="2">首次购物</option>
					<option value="3">注册送券</option>
					<option value="4">申领优惠券</option>
					</select></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>				
		</tr>
	</table>
	<table id="dg"></table>
	<form id="searchForm">
		<table class="table table-hover table-condensed"
			style="width: 100%; padding: 7px 80px 0px 80px">
			<tr>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%" align="center">
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					 onclick="applyCoupon_add.save();">保存</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="applyCoupon_add.back();">返回</a></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	</form>
	<div id="tb" style="display: none;">
		<a href="javascript:void(0);" id="but" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="applyCoupon_add.addRow();">增加</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true" onclick="applyCoupon_add.delRow();">删除</a>
	</div>
	<div class="easyui-window" data-options="closed:true,cache:false" id="addApplyCouponMagnifier"></div>
</div>

<script type="text/javascript"	src="common/js/applyCoupon/applyCoupon_addApplyCouponWindow.js"></script>