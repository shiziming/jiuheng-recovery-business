<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#spuPage #editPanel td:first-child {
	width: 150px;
}
#spuPage #editPanel .input-content {
	width: 150px;
}
</style>
<div id="zeroBuy_AddZeroBuyDetail">
<div style="width: 100%; background-color: #eff5ff;" id="zeroBuy_AddzeroBuyDetail_form">
<input type="hidden" value="${zeroBuy.orderNum}" id="orderNumId">
<form>
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
								class="easyui-linkbutton" iconCls="icon-search" onclick="zeroBuyUpdateDetail.queryActivity()">查询活动</a></td>
				<td width="8%" align="right">活动号：</td>
				<td width="8%" align="left"	><input style="width: 99%"
								class="easyui-textbox" name="activityId"  id="activityId" editable="false" value="${saleActivity.activityId}" data-options="required:true" /></td>
				<td width="10%" align="right">活动名称：</td>
				<td width="10%" align="left"><input style="width: 99%"
								class="easyui-textbox" name="activityName"  id="activityName" editable="false" value="${saleActivity.activityName}" data-options="required:true" /></td>
				<td width="10%" align="right">活动开始时间：</td>
				<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="startDate" type="text" id="startDate" editable="false" value="${zeroBuy.beginDate}"/>
							<input type="hidden" value="${zeroBuy.beginDate}" id="beginDateId">
							</td>
				<td width="10%" align="right">活动结束时间：</td>
				<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="endDate" type="text" id="endDate" editable="false" value="${zeroBuy.endDate}"/>
							<input type="hidden" value="${zeroBuy.endDate}" id="endDateId">
							</td>
			</tr>
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
				<td></td>
				<td></td>
				<td></td>
				<td><a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding: 5px 0px; width: 150px;" onclick="zeroBuyUpdateDetail.updateZeroBuy();">
				<span style="font-size: 14px;">保 存</span></a></td>
				<td><a href="javascript:void(0);" id="btnReturn" class="easyui-linkbutton" data-options="iconCls:'icon-back'" style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="zeroBuyUpdateDetail.returnToListPage();"> <span style="font-size: 14px;">返 回</span></a></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</fieldset>
</form>
</div>
<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier_Activity_window"></div>
</div>
<script type="text/javascript" src="common/js/zeroBuy/zeroBuy_updateActivity_Window.js"></script>
