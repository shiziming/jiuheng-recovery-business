<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
</script>
<style>
#list_sale_activity #edit_panel table {
	padding: 30px 80px
}

#list_sale_activity #edit_panel table tr {
	line-height: 30px;
}

#list_sale_activity #edit_panel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
  <input type="hidden" id="activityId"  name="activityId" value="${saleActivity.activityId }">
	<table id="activityTable" >
		<tr>
			<td width="30%" align="right">促销活动名称:</td>
			<td width="70%">
			  <input name="activityName" value="${saleActivity.activityName }" id="activityName"  class="easyui-textbox" data-options="required:true"/>
             </td>
		</tr>
		<tr>
			<td>开始日期:</td>
			<td><input name="startDate" value="${saleActivity.startDate }" id="startDate"  class="easyui-datebox" data-options="required:true" editable="false"
			/>
			</td>
		</tr>
		<tr>
			<td>结束日期:</td>
			<td><input name="endDate" value="${saleActivity.endDate }" id="endDate"  class="easyui-datebox" data-options="required:true" editable="false"
			/></td>
		</tr>
	</table>
</form>
	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="saleactivity.save();"> <span style="font-size: 14px;">保
				存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="saleactivity.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>