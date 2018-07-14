<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="zeroBuy_Add_Page">
	<table id="zeroBuyAdd">
		<tr height="50px">
			<td width="7%">销售组织：</td>
			<td width="8%">
					<input name="salAgencyCode" id="salAgencyCodeId"
							type="text" placeholder="请输入销售组织代码" class="span2">
			</td>
			<td width="10%" align="right"><a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="zeroBuy_add.queryActivity()">查询活动</a></td>
			<td width="8%" align="right">活动号：</td>
			<td width="8%" align="left"	><input style="width: 99%"
							class="easyui-textbox" name="activityId"  id="activityId" editable="false" data-options="required:true" /></td>
			<td width="10%" align="right">活动名称：</td>
			<td width="10%" align="left"><input style="width: 99%"
							class="easyui-textbox" name="activityName"  id="activityName" editable="false" data-options="required:true" /></td>
			<td width="10%" align="right">活动开始时间：</td>
				<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="startDate" type="text" id="startDate" editable="false" />
							<input  type="hidden" name="startDate"  id="startDateId" editable="false" />
							</td>
				<td width="10%" align="right">活动结束时间：</td>
				<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="endDate" type="text" id="endDate" editable="false"/>
							<input  type="hidden" name="endDate"  id="endDateId" editable="false" />
							</td>				
			
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
					 onclick="zeroBuy_add.save();">保存</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="zeroBuy_add.back();">返回</a></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	</form>
	<div id="tb" style="display: none;">
		<a href="javascript:void(0);" id="but" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="zeroBuy_add.addRow();">增加</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true" onclick="zeroBuy_add.delRow();">删除</a>
	</div>
	<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier"></div>
</div>

<script type="text/javascript"	src="common/js/zeroBuy/zeroBuy_AddWindow.js"></script>