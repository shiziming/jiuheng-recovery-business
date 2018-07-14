<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div style="width: 100%;">

<form id="area_edit_form" action="addressArea/updateArea" method="POST">
		<table style="margin:50px 100px 0 100px">
			<tr style="height:30px;margin:0 auto;">
				<td>地址区域代码:</td>
				<td><input value="${addressArea.code}" id="code" class="easyui-textbox" readonly="readonly" data-options="editable:false" name="code"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>地址区域级别:</td>
				<td><input value="${addressArea.level}" id="areaLeve" class="easyui-textbox" readonly="readonly" data-options="editable:false" name="level"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>父地址区域代码:</td>
				<td><input value="${addressArea.parentCode}" id="parentCode" class="easyui-textbox" readonly="readonly" data-options="editable:false" name="parentCode"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>地址区域名称:</td>
				<td><input value="${addressArea.name}" id="areaName" name="name" class="easyui-textbox" data-options="required:true"></input></td>
			</tr>
		</table>
		<div style="margin:20px 100px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 80px;" onclick="addressArea.saveArea();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				style="padding: 5px 0px; width: 80px; margin-left: 50px"
				onclick="addressArea.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
</form>
</div>
