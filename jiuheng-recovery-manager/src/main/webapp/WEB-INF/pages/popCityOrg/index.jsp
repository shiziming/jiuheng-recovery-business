<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="popCityOrgPage">
	<div id="listPanel">
		<table id="dg" title="POP平台城市销售组织查询"></table>
		<div id="tb" style="height: auto">
			<div class="search" style="padding: 5px 10px">
				<form id="searchForm">
					<table style="width: auto;">
						<tr>
							<td class="label">在线城市代码:</td>
							<td class="content"><input name="popCityCode" /></td>
							<td class="label">在线城市名称:</td>
							<td class="content"><input name="popCityName" /></td>
							<td class="label">销售组织代码:</td>
							<td class="content"><input name="saleOrgCode" /></td>
						</tr>
						<tr>
							<td class="label">渠道代码:</td>
							<td class="content"><input name="channelCode" /></td>
							<td class="label">录入日期:</td>
							<td class="content" colspan="3"><input
								class="easyui-datebox" name="startTime" /> 至 <input
								class="easyui-datebox" name="endTime" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
				<a id="btnSearch" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">查 询</a> <a
					id="btnUpload" href="javascript:void(0)" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">下载模板</a>
				<c:if test="${FUNC_IMPORT}">
					<a id="btnImport" href="javascript:void(0)"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">批量导入</a>
				</c:if>
				<c:if test="${FUNC_EXPORT}">
					<a id="btnExport" href="javascript:void(0)"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true">批量导出</a>
				</c:if>

				<c:if test="${FUNC_MAINTAIN}">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true"
						onclick="popCityOrg.append()">添加</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-edit',plain:true"
						onclick="popCityOrg.edit()">编辑</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true"
						onclick="popCityOrg.accept()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true"
						onclick="popCityOrg.removeit()">删除</a>
				</c:if>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="common/js/popCityOrg/index.js"></script>
