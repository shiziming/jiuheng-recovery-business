<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="zeroBuy_list_detailed">
<div id="zeroBuy_list_detailed_form" class="easyui-panel">
<form id="detailedForm" method="post">
			<input id="orderNum" type="hidden" value="${zeroBuy.orderNum}">
			<input id="status" type="hidden" value="${zeroBuy.status}">
			<input id="salAgencyCode" type="hidden" value="${zeroBuy.salAgencyCode}">
			<input id="funcId" type="hidden" value="<%=session.getAttribute("funcId")%>">
			<input id="promotionCode" type="hidden" value="${zeroBuy.promotionCode}">
			<input type="hidden" value="${FUNC_VIEW}" id="VIEW">
			<input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
			<input type="hidden" value="${FUNC_CHECK}" id="CHECK">
			<input type="hidden" value="${FUNC_STOP}" id="STOP">
			<div
				style="background-color: #95b8e7; text-align: left; color: #fff; font-weight: bold; border-bottom: 1px solid #000;">
				详细查看首页商品单据</div>
			<table border=1
				style="cellSpacing: 1; cellPadding: 3; width: 100%; background-color: #eff5ff; border-collapse: collapse">
				<tr>
					<td width="25%" align="center">单据编号：</td>
					<td width="25%">${zeroBuy.orderNum}</td>
					<td width="25%" align="center">活动号：</td>
					<td width="25%">${zeroBuy.promotionCode}</td>
				</tr>	
				<tr>	
					<td width="25%" align="center">销售组织代码：</td>
					<td width="25%">${zeroBuy.salAgencyCode}</td>
					<td width="25%" align="center">状态：</td>
					<td width="25%">${zeroBuy.status}</td>
				</tr>
				<tr>
					<td width="25%" align="center">开始日期</td>
					<td width="25%">${zeroBuy.beginDate}</td>
					<td width="25%" align="center">结束日期</td>
					<td width="25%">${zeroBuy.endDate}</td>
				</tr>
				<tr>
					<td width="25%" align="center">制单人名称</td>
					<td width="25%">${zeroBuy.creatUserName}</td>
					<td width="25%" align="center">制单时间</td>
					<td width="25%">${zeroBuy.creatTime}</td>
				</tr>
				<c:if test="${zeroBuy.status=='已审核'||zeroBuy.status=='审核不通过'}">
				<tr>
					<td width="25%" align="center">审核人名称</td>
					<td width="25%">${zeroBuy.auditingPeopleName}</td>
					<td width="25%" align="center">审核时间</td>
					<td width="25%">${zeroBuy.auditingTime}</td>
				</tr>
				</c:if>
				<c:if test="${zeroBuy.status=='已终止'}">
				<tr>
					<td width="25%" align="center">终止人名称</td>
					<td width="25%">${zeroBuy.endPeopleName}</td>
					<td width="25%" align="center">终止时间</td>
					<td width="25%">${zeroBuy.endTime}</td>
				</tr>
				</c:if>
			</table>
		</form>
		<div align="right" class="easyui-panel" style="padding: 5px;">
		<c:if test="${zeroBuy.status=='已审核'||zeroBuy.status=='审核不通过'}">
					<c:if test="${FUNC_STOP}">
					<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					onclick="zeroBuy_detailed.stop();">终止活动</a>
				</c:if>	
		</c:if>
		<c:if test="${zeroBuy.status=='已录入'}">
		<c:if test="${FUNC_MAINTAIN}">
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="zeroBuy_detailed.add();">增加</a>
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-remove'"
							onclick="zeroBuy_detailed.del();">删除</a>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-edit'"
						onclick="zeroBuy_detailed.updateDetail();">修改</a>
		</c:if>
		<c:if test="${FUNC_CHECK}">
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
							onclick="zeroBuy_detailed.check();">审核同意</a>
					<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					onclick="zeroBuy_detailed.checkNo();">审核不同意</a>
		</c:if>
		
		<c:if test="${FUNC_STOP}">
					<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					onclick="zeroBuy_detailed.stop();">终止活动</a>
		</c:if>
		</c:if>
		
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
						onclick="zeroBuy_detailed.back();">返回</a>
		</div>
		<div class="easyui-layout">
			<table id="detailed"></table>
		</div>
	</div>
		<div id="update_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="add_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="searImage_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
</div>
<script type="text/javascript"	src="common/js/zeroBuy/zeroBuy_searcherDetailedWomdow.js"></script>
		