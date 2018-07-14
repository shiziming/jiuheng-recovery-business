<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="applyCoupon_list_detailed">
<div id="applyCoupon_list_detailed_form" class="easyui-panel">
<form id="detailedForm" method="post">
			<input id="orderNum" type="hidden" value="${applyCoupon.orderNum}">
			<input id="status" type="hidden" value="${applyCoupon.status}">
			<%-- <input id="salAgencyCode" type="hidden" value="${applyCoupon.salAgencyCode}">
			<input id="funcId" type="hidden" value="<%=session.getAttribute("funcId")%>"> --%>
			<input id="promotionCode" type="hidden" value="${applyCoupon.promotionCode}">
			<input type="hidden" value="${FUNC_VIEW}" id="VIEW">
			<input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
			<input type="hidden" value="${FUNC_CHECK}" id="CHECK">
			<div
				style="background-color: #95b8e7; text-align: left; color: #fff; font-weight: bold; border-bottom: 1px solid #000;">
				详细查看优惠券单据</div>
			<table border=1
				style="cellSpacing: 1; cellPadding: 3; width: 100%; background-color: #eff5ff; border-collapse: collapse">
				<tr>
					<td width="25%" align="center">单据编号：</td>
					<td width="25%">${applyCoupon.orderNum}</td>
					<td width="25%" align="center">活动号：</td>
					<td width="25%">${applyCoupon.promotionCode}</td>
				</tr>
				<tr>
					<td width="25%" align="center">渠道代码：</td>
					<td width="25%">${applyCoupon.channelCode}</td>
					<td width="25%" align="center">应用场景：</td>
					<td width="25%">${applyCoupon.sceneType}</td>
				</tr>	
				<tr>	
					<td width="25%" align="center">单据机构代码：</td>
					<td width="25%">${applyCoupon.orderAgencyCode}</td>
					<td width="25%" align="center">状态：</td>
					<td width="25%">${applyCoupon.status}</td>
				</tr>
				<tr>
					<td width="25%" align="center">开始日期</td>
					<td width="25%">${applyCoupon.beginTime}</td>
					<td width="25%" align="center">结束日期</td>
					<td width="25%">${applyCoupon.endTime}</td>
				</tr>
				<tr>
					<td width="25%" align="center">制单人名称</td>
					<td width="25%">${applyCoupon.creatUserName}</td>
					<td width="25%" align="center">制单时间</td>
					<td width="25%">${applyCoupon.creatTime}</td>
				</tr>
				<c:if test="${applyCoupon.status=='已审核'}">
				<tr>
					<td width="25%" align="center">审核人名称</td>
					<td width="25%">${applyCoupon.auditingPeopleName}</td>
					<td width="25%" align="center">审核时间</td>
					<td width="25%">${applyCoupon.auditingTime}</td>
				</tr>
				</c:if>
			</table>
		</form>
		<div align="right" class="easyui-panel" style="padding: 5px;">
		<c:if test="${applyCoupon.status=='已录入'}">
		<c:if test="${FUNC_MAINTAIN}">
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="applyCoupon_detailed.add();">增加</a>
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-remove'"
							onclick="applyCoupon_detailed.del();">删除</a>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-edit'"
						onclick="applyCoupon_detailed.updateDetail();">修改</a>
		</c:if>
		<c:if test="${FUNC_CHECK}">
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
							onclick="applyCoupon_detailed.check();">审核</a>
		</c:if>
		</c:if>
		
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
						onclick="applyCoupon_detailed.back();">返回</a>
		</div>
		<div class="easyui-layout">
			<table id="detailed"></table>
		</div>
	</div>
		<div id="update_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="add_panelss" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="searImage_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
</div>
<script type="text/javascript"	src="common/js/applyCoupon/applyCoupon_searcherDetailedWindow.js"></script>
		