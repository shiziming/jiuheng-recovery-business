<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="list_sale_activity">
<!-- 促销活动查询列表 -->
	<div id="activity_list_panel" class="easyui-panel">
		<div id="check_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 1% 0px 1%">
					<tr>
						<td width="100px" align="center">促销活动号</td>
						<td width="100px"><input  class="easyui-textbox" name="activityId" type="text"></td>
						<td width="100px" align="center">促销活动名称</td>
						<td width="100px"><input  class="easyui-textbox" name="activityName" type="text"></td>
						<td width="100px" align="center">状态</td>
					    <td width="200px"><select id="status" name="status" class="easyui-combobox" style="width: 132px;">
								<option value="" selected="selected"></option>
								<option value="0">已录入</option>
								<option value="1">审核通过</option>
								<option value="2">活动已终止</option>
						</select></td>
					</tr>
					<tr>
						<td width="100px" align="center">开始日期</td>
						<td width="150px"><input id="start" style="width:132px"
							placeholder="起始日期" class="easyui-datebox" name="startTime1" type="text" />至
							<input id="jsrq" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="endTime1" type="text" /></td>
						<td width="100px" align="center">结束日期</td>
						<td width="150px"><input id="end" style="width: 132px"
							placeholder="起始日期" class="easyui-datebox" name="startTime2" type="text" />至
							<input id="jsrq" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="endTime2" type="text" /></td>
						<td align="left" colspan="2"><a href="#" id="activity_list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="activity_list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="toolbar" style="display: none;">
					<a id="activity_list_btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">新增</a>
					<a id="activity_list_btnEdit" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit',plain:true">修改</a>
					<a id="activity_list_btnDel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">删除</a>
		</div>
		 <div data-options="border:false"> 
			  <table id="dg"></table>
		  </div> 
       </div>
	<div class="easyui-panel" id="edit_panel" data-options="iconCls:'icon-save',closed:true, cache:false" style="display:block"></div>
	<div class="easyui-panel" id="check_panel" data-options="closed:true, cache:false" style="display:block"></div>

    <script type="text/javascript"	src="common/js/sale_activity/sale_activity.js"></script>

</div>
