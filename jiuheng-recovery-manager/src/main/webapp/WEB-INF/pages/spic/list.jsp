<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="spicPage">
	<div id="listPanel">
			<table id="dg" title="SPU加工图管理"></table>
			<div id="tb" style="height: auto">
				<div class="search">
					<form id="searchForm">
						<table style="width: auto">
							<tr>
								<td class="label">类目:</td>
								<td class="content">
									<ul id="categroyCode" class="easyui-combotree" style="width: 150px"></ul>
								</td>
								<td class="label">SPU码:</td>
								<td class="content">
									<input name="code" />
								</td>
								<td class="label">SPU名称:</td>
								<td class="content">
									<input name="name" />
								</td>
								<td class="label">SPU状态:</td>
								<td class="content">
									<select name ="status" class="easyui-combobox">
										<option></option>
										<option value="1">发布</option>
										<option value="0">未发布</option>
									</select>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="toolbar">
					<a id="btnSearch"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-search',plain:true">查 询</a>
					<a id="btnMatINfo" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">素材详情</a>
					<a id="btnDownMats" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">下载素材</a>
					<a id="btnPicAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">上传图片</a>
					<a id="btnSearchPic" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-search',plain:true">CDN图片</a>
					<c:if test="${PUBLISH}">
						<a id="btnPublishSpu" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">发布SPU</a>
					</c:if>
				</div>
			</div>
	</div>
	<div id="editPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
</div>

<script type="text/javascript"	src="common/js/spic/spic_list.js"></script>

