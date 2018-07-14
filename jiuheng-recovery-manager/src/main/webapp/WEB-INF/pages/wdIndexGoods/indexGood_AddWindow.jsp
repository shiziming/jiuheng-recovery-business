<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="indexGoods_Add_Page">
	<input type="hidden" value="${indexGoods.orderAgencyCode}" id="orderAgencyCode"/>
	<input type="hidden" value="${flag}" id="flag"/>
	<c:if test="${flag!=1}">
	<table id="indexGoodsAdd">
		<tr height="50px">
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="6%">销售组织：</td>
			<td width="8%">
					<select id="salAgencyCodeId" class="easyui-combobox" name="salAgencyCode" editable="false" style="width:135px;"data-options="required:true">   
				    <option value="">--请选择--</option>   
				    <c:forEach items="${indexGoods.list}" var="saleOrg">
				    <option value="${saleOrg.saleOrgCode}">${saleOrg.saleOrgCode}${saleOrg.saleOrgName}</option>
				    </c:forEach>
				</select>
			</td>
			<td width="8%">计划发布日期：</td>
			<td width="8%"><input style="width: 99%"
							placeholder="计划发布时间" class="easyui-datebox" name="publicDate"  id="publicDateId" editable="false" data-options="required:true" /></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
		</tr>
	</table>
	</c:if>
	<table id="dg"></table>
	<form id="searchForm">
		<table class="table table-hover table-condensed"
			style="width: 100%; padding: 7px 80px 0px 80px">
			<tr>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%" align="center">
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					 onclick="indexGoods_add.save();">保存</a>
				<a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="indexGoods_add.back();">返回</a></td>
				<td width="10%"></td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	</form>
	<div id="tb" style="display: none;">
		<a href="javascript:void(0);"	class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="indexGoods_add.addRow();">增加</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true" onclick="indexGoods_add.delRow();">删除</a>
	</div>
	<div class="easyui-window" data-options="closed:true,cache:false" id="magnifier"></div>
</div>

<script type="text/javascript"	src="common/js/wdIndexGoods/indexGood_AddWindow.js"></script>
