<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="spuWithSkuPage">
	<div id="listPanel">
			<table id="dg" title="spu与sku对照关系"></table>
			<div id="tb" style="height: auto">
				<div class="search">
					<form id="searchForm">
						<table style="width: auto">
							<tr>
								<td class="label">SPU码:</td>
								<td class="content">
									<input name="spuCode" />
								</td>
								<td class="label">SPU名称:</td>
								<td class="content">
									<input name="spuName" />
								</td>
								<td class="label">SKU码:</td>
								<td class="content">
									<input name="skuCode" />
								</td>
								<td class="label">SKU名称:</td>
								<td class="content">
									<input name="skuName" />
								</td>
							</tr>
							<tr>
								<td class="label">类目:</td>
								<td class="content">
									<ul id="categroyCode" class="easyui-combotree" style="width: 150px"></ul>
								</td>
								<td class="label">品牌:</td>
								<td class="content">
									<input name="brandName" />
								</td>
								<td class="label">SPU状态:</td>
								<td class="content">
									<select name ="spuStatus" class="easyui-combobox">
										<option></option>
										<option value="1">发布</option>
										<option value="0">未发布</option>
									</select>
								</td>
								<td class="label">SKU状态:</td>
								<td class="content">
									<select name ="skuStatus" class="easyui-combobox">
										<option></option>
										<option value="2">发布</option>
										<option value="1">未发布</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="label">维护时间:</td>
								<td class="content" colspan="3">
									<input id="startTime" class="easyui-datebox" name="handleStartTime"/> 至
									<input id="endTime" class="easyui-datebox" name="handleEndTime"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="toolbar">
					<a id="btnSearch"
							class="easyui-linkbutton"
							data-options="iconCls:'icon-search',plain:true">查 询</a>
					<c:if test="${FUNC_EXPORT}">
					<a id="btnExport" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-save',plain:true">导出</a>
					</c:if>
				</div>
			</div>
	</div>
</div>

<script type="text/javascript"	src="common/js/spuWithSku/index.js"></script>

