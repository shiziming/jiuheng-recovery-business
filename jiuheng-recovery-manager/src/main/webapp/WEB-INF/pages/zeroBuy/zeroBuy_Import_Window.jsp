<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="zeroBuy_Import_Page">
<form id="searchForm" method='post' enctype="multipart/form-data">
	<table id="zeroBuyImport">
		<tr height="50px">
			<td width="10%" align="right"><a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="zeroBuy_Import.queryActivity()">查询活动</a></td>
			<td width="8%" align="right">活动号：</td>
			<td width="8%" align="left"	><input style="width: 99%"
							class="easyui-textbox" name="promotionCode" type="text"  id="promotionCode" editable="false" data-options="required:true" /></td>
			<td width="10%" align="right">活动名称：</td>
			<td width="10%" align="left"><input style="width: 99%"
							class="easyui-textbox" name="activityName"  id="activityName" editable="false" data-options="required:true" /></td>
			<td width="10%" align="right">开始时间：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="beginDate" type="text" id="beginDate" editable="false" data-options="required:true"/>
							<input  type="hidden" name="beginDateId"  id="beginDateId" editable="false" />
							</td>
			<td width="10%" align="right">结束时间：</td>
			<td width="10%" align="left"><input style="width: 85%"
							class="easyui-datebox" name="endDate" type="text" id="endDate" editable="false" data-options="required:true"/>
							<input  type="hidden" name="endDateId"  id="endDateId" editable="false" /></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="right">销售组织：</td>
			<td align="left"><input name="salAgencyCode" id="salAgencyCode"
							type="text" placeholder="请输入销售组织代码" class="span2" /></td>
			<td align="right">渠道代码：</td>
			<td align="left"><input name="channelCode" id="channelCode"
							type="text" placeholder="请输入渠道代码" class="span2" /></td>
			<td align="left"></td>
			<td align="right"><input type="file" name="fileimport" id = "fileimportId" style="width:140px" onclick="$('#saveExport_btn').linkbutton('enable');" />
			</td>
			
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
			<td align="right"></td>
				
		</tr>
		<tr>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"></td>
				<td width="10%" align="center"><a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					 onclick="zeroBuy_Import.save(this);">上传</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="zeroBuy_Import.back();">返回</a></td>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"></td>
				
		</tr>
	</table>
</form>
	
	<div class="easyui-window" data-options="closed:true,cache:false" id="importMagnifier"></div>
</div>

<script type="text/javascript"	src="common/js/zeroBuy/zeroBuy_Import_Window.js"></script>