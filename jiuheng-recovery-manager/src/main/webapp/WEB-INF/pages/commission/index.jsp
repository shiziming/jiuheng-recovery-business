<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">


</style>
<div id="commissionPage">
	<div id="commissionPage_listPanel">
	<div id="commissionPage_tb"  style="height: auto">
		<table style="padding:10px">
			<tr>
			<c:if test="${FUNC_VIEW}">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CommissionUtils.openSearch()">查询</a></td>
			</c:if>
				<td style="width: 5px"></td>
			<c:if test="${FUNC_MAINTAIN}">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="CommissionUtils.openAdd()">新建</a></td>
			</c:if>
				<td style="width: 5px"></td>
			<c:if test="${FUNC_VIEW}">
				<td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-view'" onclick="CommissionUtils.openDetail()">查看明细</a></td>
			</c:if>
				<td style="width: 5px"></td>
			</tr>
		</table>
	</div>
	
	<!-- 数据列表 -->
	<div id="commissionPage_dg" ></div>

	</div>
	
	
	<!-- 新增panel -->
	<div id="commissionPage_newPanel"></div>
	
	<!-- 详情panel -->
	<div id="commissionPage_detailPanel"></div>
	
	
	
	<!-- 查询页面 -->
	<div id="commissionPage_search" ></div>

	<!-- 新建页面 -->
	<div id="commissionPage_add" ></div>

	<!-- 查看明细页面 -->
	<div id="commissionPage_detail" ></div>
</div>

<script type="text/javascript" src="common/js/commission/index.js"></script>
