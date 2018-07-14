<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
#spuPage .categories-panel {
	float: left;
	margin-right: 1px;
	width : 15%;
}

#spuPage #spuDiv {
	float: left;
	width: 50%;
}
#spuPage #editPanel .attr-value {
	color: red
}
</style>
<div id="spuPage">
	<div id="listPanel">
		<div class="categories-panel" >
			<table id="dg1" title="一级类目" class="categories-datagrid"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg2" class="categories-datagrid" title="二级类目"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg3" class="categories-datagrid" title="三级类目"></table>
		</div>
		<div id="spuDiv" class="panel-hide">
			<table id="spuDg" title="SPU管理" ></table>
			<div id="tb" style="height: auto">
				<div class="search1">
					<form id="searchForm">
						<table>
							<tr>
								<td class="label">spu码:<input name="code" /></td>
								<td class="label">spu名称:<input name="name" /></td>
								<td class="label"><a id="btnSearch"
									class="easyui-linkbutton"
									data-options="iconCls:'icon-search',plain:true">查 询</a></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="toolbar">
					<c:if test="${FUNC_ADD}">
						<a id="btnAdd" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">新增</a> 
					</c:if>
						<a id="btnEdit" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-edit',plain:true">修改</a> <a
						id="btnDel" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true">删除</a>
					<c:if test="${MAT_PIC}">
						<a id="btnPicAdd" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">上传素材</a>
						<a id="btnSearchPic" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-search',plain:true">素材详情</a>
					</c:if>	
					<c:if test="${BIND_SKU}">
						<a id="btnBindSku" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">绑定SKU</a>
					</c:if>
					<c:if test="${PUBLISH}">
						<a id="btnPublishSpu" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">发布SPU</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div id="editPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
</div>

<script type="text/javascript" src="common/js/spu/index.js"></script>
