<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#spuPage #editPanel td:first-child {
	width: 150px;
}
#spuPage #editPanel .input-content {
	width: 150px;
}
</style>
<div>
<div style="width: 100%; background-color: #eff5ff;" id="applyCoupon_updateApplyCoupon">

<form id="updateApplyCouponForm">
<input type="hidden" value="${applyCoupon.orderNum}" id="orderNumId" name="orderNum">
	<fieldset>
		<legend></legend>
		<table>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td width="10%" align="right"><a href="#" 
								class="easyui-linkbutton" iconCls="icon-search" onclick="applyUpdate.queryActivity()">查询活动</a></td>
				<td width="10%" align="right">活动号：</td>
				<td width="10%" align="left"	><input style="width: 99%"
								class="easyui-textbox" name="promotionCode"  id="activityId" editable="false" value="${saleActivity.activityId}" data-options="required:true" /></td>
				<td width="10%" align="right">活动名称：</td>
				<td width="10%" align="left"><input style="width: 99%"
								class="easyui-textbox" name="activityName"  id="activityName" editable="false" value="${saleActivity.activityName}" data-options="required:true" /></td>
				<td width="10%" align="right">开始时间：</td>
				<td width="10%" align="left"><input style="width: 99%"
							class="easyui-datebox" name="beginTime" type="text" id="beginTime" editable="false" value="${applyCoupon.beginTime}"/>
							<input type="hidden" value="${saleActivity.startDate}" id="beginTimeId">
							</td>
				<td width="10%" align="right">结束时间：</td>
				<td width="10%" align="left"><input style="width: 99%"
							class="easyui-datebox" name="endTime" type="text" id="endTime" editable="false" value="${applyCoupon.endTime}"/>
							<input type="hidden" value="${saleActivity.endDate}" id="endTimeId">
							</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td width="10%" align="right"></td>
			<td width="10%" align="right">渠道代码：</td>
			<td width="10%" align="left"	><input style="width: 99%"
							class="easyui-textbox" name="channelCode"  id="channelCode" data-options="required:true" value="${applyCoupon.channelCode}"/></td>
			<%-- <td width="10%" align="right">每月日集合：</td>
			<td width="10%" align="left"><input style="width: 99%"
							class="easyui-textbox" name="monthDayList"  id="monthDayList" data-options="required:true" value="${applyCoupon.monthDayList}"/></td>
			<td width="10%" align="right">每周日集合：</td>
				<td width="10%" align="left"><input style="width: 99%"
							class="easyui-textbox" name=weekDayList id="weekDayList" data-options="required:true" value="${applyCoupon.weekDayList}"/>
							</td>
				<td width="10%" align="right">每天时段集合：</td>
				<td width="10%" align="left"><input style="width: 99%"
							class="easyui-textbox" name="dayTimeList" id="dayTimeList" data-options="required:true" value="${applyCoupon.dayTimeList}"/>
							</td> --%>
				<td width="10%" align="right">使用场景：</td>
						<td width="10%"><select id="sceneType" name="sceneType" class="easyui-combobox" editable="false" data-options="required:true" style='width: 99%;'>
								<option value="">--请选择--</option>
								<option ${applyCoupon.sceneType==1?"selected='selected'":""} value="1">购物</option>
								<option ${applyCoupon.sceneType==2?"selected='selected'":""} value="2">首次购物</option>
								<option ${applyCoupon.sceneType==3?"selected='selected'":""} value="3">注册送券</option>
								<option ${applyCoupon.sceneType==4?"selected='selected'":""} value="4">申领优惠券</option>
								</select></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="11"></td>
				
			</tr>
			<tr>
				<td colspan="2"></td>
				<td><a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding: 5px 0px; width: 150px;" onclick="applyUpdate.updateApplyCoupon();">
				<span style="font-size: 14px;">保 存</span></a></td>
				<td></td>
				<td><a href="javascript:void(0);" id="btnReturn" class="easyui-linkbutton" data-options="iconCls:'icon-back'" style="padding: 5px 0px; width: 150px;"
				onclick="applyUpdate.returnToListPage();"> <span style="font-size: 14px;">返 回</span></a></td>
				<td colspan="6"></td>
			</tr>
		</table>
	</fieldset>
</form>
</div>
<div class="easyui-window" data-options="closed:true,cache:false" id="applyCoupoonMagnifier_Activity_window"></div>
</div>
<script type="text/javascript" src="common/js/applyCoupon/applyCoupon_update_Window.js"></script>
