<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="ymx_sku_up_down">
	<div id="listPanel">
			<table id="dg" title="亚马逊SKU上下架状态查询"></table>
			<div id="tb" style="height: auto">
				<div class="search" style="padding: 5px 10px">
					<form id="searchForm">
						<table  style="width: auto;">
							<tr>
								<td class="label">SKU码:</td>
								<td class="content">
									<input name="skuCode" />
								</td>
								<td class="label">SKU名称:</td>
								<td class="content">
									<input name="skuName" />
								</td>
								<td class="label">销售组织:</td>
								<td class="content">
									<input name="saleOrgCode" />
								</td>
							</tr>
							<tr>
								<td class="label">类 目:</td>
								<td class="content">
									<ul id="categroyCode" class="easyui-combotree" style="width:99%"></ul>
								</td>
								<td class="label">品 牌:</td>
								<td class="content">
									<input name="brand" />
								</td>
								<td class="label">渠道代码:</td>
								<td class="content">
									<input name="channelCode" />
								</td>
							</tr>
							<tr>
								<td class="label">上下架时间:</td>
								<td class="content" colspan="3">
									<input class="easyui-datebox" name="startTime"/> 至
									<input class="easyui-datebox" name="endTime"/>
								</td>
								<td class="label">品类:</td>
								<td class="content">
									<ul id="secondCategroyCode" class="easyui-combotree" style="width: 99%"></ul>
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

<script type="text/javascript"	src="common/js/ymx_goods_manage/index.js"></script>

