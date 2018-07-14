<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
#skuPage .categories-panel {
	float: left;
	margin-right: 1px;
	width : 15%;
}

#skuPage #skuDiv {
	float: left;
	width: 50%;
}
#skuPage #editPanel .attr-value {
	color: red
}
</style>
<div id="skuPage">
	<div id="listPanel">
	<input type="hidden" value="${FUNC_VIEW}" id="VIEW">
	<input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
	<input type="hidden" value="${FUNC_CHECK}" id="CHECK">
	<input type="hidden" id="RESULT">
		<table id="dg" title="商品售后信息" ></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table style="width: auto">
						<tr>
							<td class="label">SKU码:</td>
							<td class="content">
								<input name="skuCode" />
							</td>
							<td class="label">SKU名称:</td>
							<td class="content">
								<input name="name" />
							</td>
						</tr>
						<tr>
							<td class="label">SKU状态:</td>
							<td class="content">
								<select name ="publishStatus" class="easyui-combobox">
									<option></option>
									<option value="2">发布</option>
									<option value="0">未发布</option>
								</select>
							</td>
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
			<c:if test="${MAT_PIC}">
				<a id="btnCTPicAddDirection" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">上传说明书</a>
				<a id="btnCTPicAddWarranty" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">上传保修卡</a>
			</c:if>
				<a id="btnSearchPic" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-search',plain:true">CDN图片</a>
			</div>
		</div>
	</div>
	<div id="editPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
</div>

<script type="text/javascript" src="common/js/sku/index.js"></script>
