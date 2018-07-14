<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="indexGoods_list_page">
<!-- 微店首页商品单列表 -->
	<div id="indexGoods_list_list_panel">
	<%-- <input type="hidden" value="${FUNC_VIEW}" id="VIEW">
	<input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
	<input type="hidden" value="${FUNC_CHECK}" id="CHECK"> --%>
		<div id="indexGoods_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: 150px; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 80px 0px 80px">
					<tr>
						<td width="10%" align="center">单据编号</td>
						<td width="5%"><input name="orderNum" type="text"
							placeholder="请输入单据编号" class="span2" id="orderNumId"></td>
						<td width="5%"></td>
						<td width="10%" align="center">销售组织代码</td>
						<td width="5%"><input name="salAgencyCode" id="salAgencyCodeId"
							type="text" placeholder="请输入销售组织代码" class="span2"></td>
						<td width="5%"></td>
						<td width="10%"></td>
						<td width="5%"></td>
						<td width="5%"></td>
						<td width="10%" align="left"></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="10%" align="center">录入人</td>
						<td width="5%"><input name="creatUserName" type="text" placeholder="请输入录入人" class="span2" id="creatUserNameId"></td>
						<td width="5%"></td>
						<td width="10%" align="center">状态</td>
						<td width="5%"><select id="statusId" name="status" class="easyui-combobox" style='width: 100%;'>
								<option value="">已录入</option>
								<option value="0">未审核</option>
								<option value="2">已审核</option>
								<option value="1">图片已审核</option>
								</select></td>
						<td width="5%"></td>
						<td width="10%"></td>
						<td width="5%"></td>
						<td width="5%"></td>
						<td width="10%" align="left"></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="10%" align="center">录入日期</td>
						<td width="5%"><input style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="createStartTime" type="text" id="createStartTimeId"/>至
							<input style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="createEndTime" type="text" id="createEndTimeId"/></td>
						<td width="5%"></td>
						<td width="10%" align="center">审核日期</td>
						<td width="5%"><input  style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="checkStartTime" type="text" id="checkStartTimeId"/>至
							<input  style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="checkEndime" type="text" id="checkEndTimeId"/></td>
						<td width="5%"></td>
						<td width="10%" align="right"><a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="query()">查询</a></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="toolbar">
		<%-- <c:if test="${FUNC_MAINTAIN}"> --%>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-add" plain="true" onclick="indexGoodsManage.addGoods()">新增首页单据</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-add" plain="true" onclick="indexGoodsManage.addHavenGoods()">选择已有单据新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-add" plain="true" onclick="indexGoodsManage.maintainBranchHotGoods()">维护分部爆款</a>
		<%-- </c:if> --%>
		</div>
		<!-- 表格 -->
		<div data-options="border:false">
			<table id="indexGoods_list_dg"></table>
		</div>
	</div>
		<!-- 打开查看页面 -->
		<div class="easyui-panel" id="searchAndAuditing" style="display:block"></div>
		<!-- 打开添加页面 -->
		<div id="add" class="easyui-panel"
		data-options="closed:true, cache:false,border:false"></div>
		<!-- 打开修改页面 -->
		<div id="update" class="easyui-panel"
		data-options="closed:true,cache:false"></div>
		<!-- 打来添加图片页面 -->
		<div class="easyui-panel"
		data-options="closed:true, cache:false,border:false" id="uploadImage"></div>
</div>
 
<script type="text/javascript"	src="common/js/wdIndexGoods/indexGood_list.js"></script>
