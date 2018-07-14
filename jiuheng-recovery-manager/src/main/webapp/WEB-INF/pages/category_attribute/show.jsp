<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/header.jsp"%>
<style>
#attrPage #editPanel table {
	padding: 30px 80px
}

#attrPage #editPanel table tr {
	line-height: 30px;
}

#attrPage #editPanel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
	<table id="attrTable">
		<tr>
			<td>属性id:</td>
			<td>
				<input id="attrId" value="${goodsAttribute.id }" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td>属性名称:</td>
			<td>
				<input id="attrName" value="${goodsAttribute.name}" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td>数据类型:</td>
			<td>
				<c:choose>
			 		<c:when test="${goodsAttribute.dataType== 1}"><input readonly="readonly" value="文本"/></c:when>
			 		<c:when test="${goodsAttribute.dataType== 2}"><input readonly="readonly" value="数值"/></c:when>
				</c:choose> 
			</td>
		</tr>
		<tr>
			<td>文本类型:</td>
			<td>
				<c:choose>
			 		<c:when test="${goodsAttribute.chooseType== 1}"><input readonly="readonly" value="单选"/></c:when>
			 		<c:when test="${goodsAttribute.chooseType== 2}"><input readonly="readonly" value="多选"/></c:when>
			 		<c:when test="${goodsAttribute.chooseType== 0}"><input readonly="readonly" value="手输"/></c:when>
				</c:choose> 
			</td>
		</tr>
		<!--非手动输入  -->
		<c:if test="${goodsAttribute.chooseType!= 0}">
			<c:choose>
		 		<c:when test="${goodsAttributeValues.size() > 0}">
		 			<c:forEach items="${goodsAttributeValues}" var="list" varStatus="status">
	 					<tr>
							<td><c:if test="${status.index == 0}">属性值:</c:if></td>
							<td><input placeholder="序号" value="${list.num}" style="width: 25px" readonly="readonly"/>
								&nbsp;<input placeholder="属性值" class="attr-value" data-id="${list.id}" value="${list.goodsattrvalue}" readonly="readonly"/>&nbsp; 
						</tr>
					</c:forEach>
		 		</c:when>
			</c:choose> 
		</c:if>
	</table>

	<div style="padding: 0px 80px">
		 <a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="categoryAttr.returnToListPage();"> <span
			style="font-size: 14px;">返 回</span>
		</a>
	</div>

</div>
