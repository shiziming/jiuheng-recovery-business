<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>

#hotModelMagnifierWindow{
	padding-left: 50px;
	padding-top: 10px;
	padding-bottom: 10px;
}
</style>
<div id="hotModelMagnifierWindow">
	<input type="hidden" value="${row}" id="row">
	<form id="goods_search_form" name="goods_search_form">
		<table>
			<tr>
				<td>分类</td>
				<td>
					<select name="categoryId" class="easyui-combobox" data-options="editable:false">
						<option value="">全部</option>
						<c:forEach items="${categories}" var="cate">
							<option  <c:if test="${cate.fid == -1}">disabled="disabled"</c:if> value="${cate.id}"><c:if test="${cate.fid != -1}">——</c:if>${cate.name}</option>
						</c:forEach>
					</select>
				</td>
				<td>品牌</td>
				<td>
					<select name="brandId" class="easyui-combobox" data-options="editable:false">
						<option value="">全部</option>
						<c:forEach items="${brands}" var="brand">
							<option value="${brand.id}">${brand.name}</option>
						</c:forEach>
					</select>
				</td>
				<td>设备型号</td>
				<td>
					<input type="text" name="model" />
				</td>
				<td></td>
				<td></td>
				<td align="center">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" id="serchHotModel">搜索</a>
				</td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</form>
</div>

<div>
	<table id="hotModelDataGrid"></table>
</div>
<script type="text/javascript" src="common/js/index/hotModelManager.js"></script>
