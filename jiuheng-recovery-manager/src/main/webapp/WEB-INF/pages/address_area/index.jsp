<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
#addressArea .categories-panel {
	float: left;
	margin-right: 1px;
	width : 10%
}

#addressArea #configDiv {
	float: left;
	width:56%
}
</style>
<div id="addressArea">
	<!-- 查看权限 -->
	<input type="hidden" value="${FUNC_VIEW}" id="VIEW">
	<!-- 分部维护 -->
	<input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
	<!-- 分部导出 -->
	<input type="hidden" value="${FUNC_FEXPORT}" id="FEXPORT">
	<!-- 总部导出 -->
	<input type="hidden" value="${FUNC_EXPORT}" id="EXPORT">
	<!-- 总部导入 -->
	<input type="hidden" value="${FUNC_IMPORT}" id="IMPORT">
	<div id="listPanel">
		<div if="import_tb" style="width:100%;height:30px;">
			<a id="download_btn" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">下载模板</a>
		<c:if test="${FUNC_IMPORT}">
			<a id="import_btn" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">导入
			</a>
			<a id="portion_import_btn" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">选择导入
			</a>
			<a id="special_import_btn" href="#" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true">门店/仓库修改导入
			</a>
		</c:if>
		<c:if test="${FUNC_EXPORT}">
			<a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-print',plain:true" onclick="addressArea.exportAllArea('#addressArea #dg1')">导出全部地址
			</a>
		</c:if>
		</div>
		<div class="categories-panel">
			<table id="dg1" title="一级城市" class="categories-datagrid" data-options="toolbar:'#address_area_tb1'"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg2" class="categories-datagrid" title="二级城市" data-options="toolbar:'#address_area_tb2'"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg3" class="categories-datagrid" title="三级城市" data-options="toolbar:'#address_area_tb3'"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg4" class="categories-datagrid" title="四级城市" data-options="toolbar:'#address_area_tb4'"></table>
		</div>
		
		<div id="address_area_tb1" style="height: auto">
		<c:if test="${FUNC_MAINTAIN}">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true"
				onclick="addressArea.deleteArea('#addressArea #dg1')"> 
			</a> 
			 <a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="addressArea.editArea('#addressArea #dg1')">
			</a>
		</c:if>
		<c:if test="${FUNC_FEXPORT}">
			<a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-print',plain:true" onclick="addressArea.exportArea('#addressArea #dg1')">
			</a>
		</c:if>
		</div>
		<div id="address_area_tb2" style="height: auto">
		<c:if test="${FUNC_MAINTAIN}">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true"
				onclick="addressArea.deleteArea('#addressArea #dg2')"> 
			</a> 
			 <a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="addressArea.editArea('#addressArea #dg2')">
			</a>
		</c:if>
		<c:if test="${FUNC_FEXPORT}">
			<a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-print',plain:true" onclick="addressArea.exportArea('#addressArea #dg2')">
			</a>
		</c:if>
		</div>
		<div id="address_area_tb3" style="height: auto">
		<c:if test="${FUNC_MAINTAIN}">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true"
				onclick="addressArea.deleteArea('#addressArea #dg3')"> 
			</a> 
			 <a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="addressArea.editArea('#addressArea #dg3')">
			</a>
		</c:if>
		<c:if test="${FUNC_FEXPORT}">
			<a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-print',plain:true" onclick="addressArea.exportArea('#addressArea #dg3')">
			</a>
		</c:if>
		</div>
		<div id="address_area_tb4" style="height: auto">
		<c:if test="${FUNC_MAINTAIN}">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true"
				onclick="addressArea.deleteArea('#addressArea #dg4')"> 
			</a> 
			 <a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="addressArea.editArea('#addressArea #dg4')">
			</a>
		</c:if>
		<c:if test="${FUNC_FEXPORT}">
			<a href="javascript:void(0)"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-print',plain:true" onclick="addressArea.exportArea('#addressArea #dg4')">
			</a>
		</c:if>
		</div>
		
		<div id="configDiv" class="panel-hide">
			<table id="configDg" title="配置管理"></table>
			<div id="tb" style="height: auto">
				<div class="toolbar">
				<c:if test="${FUNC_MAINTAIN}">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true"
						onclick="addressArea.deleteConfig()"> 
					</a> 
					 <a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-edit',plain:true" 
						onclick="addressArea.editConfig()">
					</a>
				</c:if>
				</div>
			</div>
		</div>
	</div>
	<div id="editPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
	<form id="exportForm" action="addressArea/exportExcel">
		<input id="areaCode" name="areaCode" value="" type="hidden">
	</form>
</div>

<script type="text/javascript" src="common/js/address_area/index.js"></script>
