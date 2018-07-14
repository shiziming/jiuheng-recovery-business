<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<div id="goods_up_view_page1">
<form id="form" method="post">
			<input id="billId" type="hidden" value="${m.billId}">
			<input id="status" type="hidden" value="${status}">
			<input id="status" type="hidden" value="${status==1}">
			<div
				style="background-color: #95b8e7; text-align: left; color: #fff; font-weight: bold; border-bottom: 1px solid #000;">
				详细查看上架单据</div>
			<table border=1
				style="cellSpacing: 1; cellPadding: 3; width: 100%; background-color: #eff5ff; border-collapse: collapse">
				<tr>
					<td width="25%" align="center">单据编号</td>
					<td width="25%">${m.billId}</td>
				</tr>
				<tr>
					<td width="25%" align="center">状态</td>
					<c:if test="${m.status==1}">
						<td width="25%">已审核</td>
					</c:if>
					<c:if test="${m.status==0}">
						<td width="25%">已录入</td>
					</c:if>
					<c:if test="${m.status==-1}">
						<td width="25%"><span style="color: red">不同意</span></td>
					</c:if>
					<td width="25%" align="center">单据机构代码</td>
					<td width="25%">${m.billOrgCode}</td>
				</tr>
				<tr>
					<td width="25%" align="center">录入人</td>
					<td width="25%">${m.createUserName}</td>
					<td width="25%" align="center">录入时间</td>
					<td width="25%">${m.createTime}</td>
				</tr>
				<c:if test="${status!=0}">
					<tr>
						<td width="25%" align="center">审核人</td>
						<td width="25%">${m.checkUserName}</td>
						<td width="25%" align="center">审核时间</td>
						<td width="25%">${m.checkTime}</td>
					</tr>
				</c:if>
			</table>
		</form>
		<div align="right" class="easyui-panel" style="padding: 5px;">
			<c:if test="${status==0}">
				<c:if test="${FUNC_CHECK}">
						<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
						onclick="gmj_goods_up_view.check(true);">审批</a>
						<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-cancel'"
						onclick="gmj_goods_up_view.check(false);">不同意</a>
				</c:if>
				<c:if test="${FUNC_MAINTAIN}">
					<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-edit'"
						onclick="gmj_goods_up_view.update();">修改</a>
					<a href="#" class="easyui-linkbutton"
							data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-remove'"
							onclick="gmj_goods_up_view.del();">删除</a>
				</c:if>
			</c:if>
				<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="gmj_goods_up_view.back();">返回</a>
		</div>
		<div class="easyui-layout">
			<table id="dg" class="categories-datagrid" title="单据明细"></table>
		</div>
</div>
		<script type="text/javascript"	src="common/js/gmj_goods_manage/goods_up_view.js"></script>
		