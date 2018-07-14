<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="indexGoods_list_detailed">
<div id="indexGoods_list_detailed_form" class="easyui-panel">
<form id="detailedForm" method="post">
			<input id="orderNum" type="hidden" value="${indexGoods.orderNum}">
			<input id="status" type="hidden" value="${indexGoods.status}">
			<input id="salAgencyCode" type="hidden" value="${indexGoods.salAgencyCode}">
			<input id="funcId" type="hidden" value="<%=session.getAttribute("funcId")%>">
			<div
				style="background-color: #95b8e7; text-align: left; color: #fff; font-weight: bold; border-bottom: 1px solid #000;">
				详细查看首页商品单据</div>
			<table border=1
				style="cellSpacing: 1; cellPadding: 3; width: 100%; background-color: #eff5ff; border-collapse: collapse">
				<tr>
					<td width="25%" align="center">单据编号：</td>
					<td width="25%">${indexGoods.orderNum}</td>
					<td width="25%" align="center">销售组织代码：</td>
					<td width="25%">${indexGoods.salAgencyCode}</td>
				</tr>
				<tr>
					<td width="25%" align="center">制单人名称</td>
					<td width="25%">${indexGoods.creatUserName}</td>
					<td width="25%" align="center">制单时间</td>
					<td width="25%">${indexGoods.creatDate}</td>
				</tr>
				<tr>
					<td width="25%" align="center">计划发布时间</td>
					<td width="25%">${indexGoods.publicDate}</td>
					<td width="25%" align="center">状态</td>
					<td width="25%">${indexGoods.status}</td>
				</tr>
				<c:if test="${indexGoods.status=='已审核'}">
					<tr>
						<td width="25%" align="center">审核人</td>
						<td width="25%">${indexGoods.auditingPeopleName2}</td>
						<td width="25%" align="center">审核时间</td>
						<td width="25%">${indexGoods.auditingDate2}</td>
					</tr>
				</c:if>
				<c:if test="${indexGoods.status=='图片已审核'}">
					<tr>
						<td width="25%" align="center">审核人</td>
						<td width="25%">${indexGoods.auditingPeopleName}</td>
						<td width="25%" align="center">审核时间</td>
						<td width="25%">${indexGoods.auditingDate}</td>
					</tr>
				</c:if>
			</table>
		</form>
		<div align="right" class="easyui-panel" style="padding: 5px;">
			<c:if test="${indexGoods.status=='未审核'||indexGoods.status=='已审核'}">
			<%-- <c:if test="${FUNC_MAINTAIN}"> --%>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="indexGoods_detailed.add();">增加</a>
			<c:if test="${indexGoods.salAgencyCode=='GMZB'}">
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="indexGoods_detailed.newAdd();">非爆款增加</a>
						<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="indexGoods_detailed.addUrl();">添加非爆款链接</a>
			</c:if>
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-remove'"
							onclick="indexGoods_detailed.del();">删除</a>
				<%--</c:if>
				 <c:if test="${FUNC_IMAGECHECK}"> --%>
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
							onclick="indexGoods_detailed.checkImage();">图片审批</a>
					<%-- </c:if> --%>
			</c:if>
			<c:if test="${indexGoods.status=='未审核'}">
			<%-- <c:if test="${FUNC_CHECK}"> --%>
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
							onclick="indexGoods_detailed.check();">审核</a>
			<%-- </c:if> --%>
			</c:if>
			<c:if test="${indexGoods.status=='未审核'||indexGoods.status=='已审核'}">
			<%-- <c:if test="${FUNC_MAINTAIN}"> --%>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-edit'"
						onclick="indexGoods_detailed.updateDetail();">修改</a>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-edit'"
						onclick="indexGoods_detailed.update();">上传/修改图片</a>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="indexGoods_detailed.downloadImage();">下载图片</a>
			<%-- </c:if> --%>
			<%-- <c:if test="${FUNC_VIEW}"> --%>
					<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-search'"
					onclick="indexGoods_detailed.searImage();">查看图片</a>
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
						onclick="indexGoods_detailed.back();">返回</a>
			</c:if>
			
			<%-- </c:if> --%>
			<c:if test="${indexGoods.status=='图片已审核'}">
				<%-- <c:if test="${FUNC_VIEW}"> --%>
				<c:if test="${indexGoods.salAgencyCode==null}">
				<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="indexGoods_detailed.nationalGoods();">全国统一爆款</a>
			</c:if>
				<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-search'"
					onclick="indexGoods_detailed.searImage();">查看图片</a>
			<%-- </c:if> --%>
			<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="indexGoods_detailed.back();">返回</a>
			</c:if>
		</div>
		<div class="easyui-layout">
			<table id="detailed"></table>
		</div>
	</div>
		<div id="update_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="add_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="searImage_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
		<div id="choice_salAgencyCode_panel" class="easyui-panel" data-options="closed:true,cache:false,border:false"></div>
</div>
<script type="text/javascript"	src="common/js/wdIndexGoods/indexGoods_searcherDetailedWomdow.js"></script>
		