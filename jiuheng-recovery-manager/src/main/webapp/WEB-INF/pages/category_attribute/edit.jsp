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
				<input id="attrName" value="${goodsAttribute.name}"/>
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
		 		<c:when test="${goodsAttributeValues.size() == 0}">
		 			<tr id="addAttrValueTr">
						<td>添加属性:</td>
						<td><input placeholder="序号" value=1 style="width: 25px" readonly="readonly"/>
							&nbsp;<input placeholder="属性值" class="attr-value"  onkeyup="categoryAttrEdit.checkIsNum(this)"/>&nbsp; <a
							class="easyui-linkbutton" data-options="iconCls:'icon-add'"
							onClick="categoryAttrEdit.addAttr(this)">添加</a></td>
					</tr>
		 		</c:when>
		 		<c:when test="${goodsAttributeValues.size() > 0}">
		 			<c:forEach items="${goodsAttributeValues}" var="list" varStatus="status">
	 					<tr <c:if test="${status.index == 0}">id="addAttrValueTr"</c:if>>
							<td ><c:if test="${status.index == 0}">添加属性:</c:if></td>
							<td><input placeholder="序号" value="${list.num}" style="width: 25px" readonly="readonly"/>
								&nbsp;<input placeholder="属性值" class="attr-value" data-id="${list.id}" value="${list.goodsattrvalue}" readonly="readonly"/>&nbsp; 
							<a class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onClick="categoryAttrEdit.delAttr(this)">删除</a>
						</tr>
						<c:if test="${status.index == goodsAttributeValues.size()-1}">
							<tr>
								<td></td>
								<td><input placeholder="序号" value="${list.num+1}" style="width: 25px" readonly="readonly"/>
									&nbsp;<input placeholder="属性值" class="attr-value" onkeyup="categoryAttrEdit.checkIsNum(this)"/>&nbsp; 
								<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onClick="categoryAttrEdit.addAttr(this)">添加</a>
							</tr>
						</c:if>
					</c:forEach>
		 		</c:when>
			</c:choose> 
		</c:if>
	</table>

	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="categoryAttrEdit.saveAttrValue();"> <span style="font-size: 14px;">修改名称</span>
		</a> <a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="categoryAttr.returnToListPage();"> <span
			style="font-size: 14px;">返 回</span>
		</a>
	</div>

</div>
<script type="text/javascript">
	var categoryAttrEdit = {};
 	categoryAttrEdit.addAttr = function(obj) {
		var td = $(obj).parent();
		if(td.find('input:eq(1)').val() != ''){
			var attr = new Object();
			attr.goodsattrid = $(categoryAttr.panelId + " #attrId").val();
			attr.num = td.find('input:first').val();
			attr.goodsattrvalue = td.find('input:eq(1)').val();
			$.ajax({ 
				async : false,
				type : "POST",
				url : "attribute/addvalue",
				data : attr,
				success : function(result) {
					if($.o2m.handleActionResult(result)){
						var tdNew = $(obj).parent().clone();
						tdNew.find('input:first').val(parseInt(td.find('input:first').val())+1);
						tdNew.find('input:eq(1)').val('');
						$(categoryAttr.panelId +" #attrTable").append($('<tr>').append($('<td>')).append(tdNew));
						var delBut = "<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-remove'\" onClick=\"categoryAttrEdit.delAttr(this)\">删除</a>";
						$(obj).parent().append(delBut);
						$.parser.parse($(obj).parent());
						tdNew.find('input:eq(1)').focus();
						td.find('input:eq(1)').attr("data-id",result.data);
						$(obj).remove();
					}
				}
			}); 
		}
	}
 	categoryAttrEdit.delAttr = function(obj){
 		var td = $(obj).parent();
 		$.ajax({
 			type : "POST",
 			url : "attribute/deletevalue?id="+td.find('input:eq(1)').attr("data-id"),
 			success : function(result) {
 				if($.o2m.handleActionResult(result)){
					//删除首行数据
					if($(obj).parent().parent().find('td:first').html() != ''){
						var first = $(obj).parent().parent();
						var next = $(obj).parent().parent().next();
						first.find('td:eq(1)').remove();
						first.append(next.find('td:eq(1)'));
						next.remove();
					}else{
						$(obj).parent().parent().remove();
					}
 				}
 			}
 		}); 
	} 
 	var dataType = "${goodsAttribute.dataType}";
 	categoryAttrEdit.checkIsNum = function(obj){
		if(dataType == 2){
			$.o2m.replaceNotNum(obj);
		}
	}
 	categoryAttrEdit.saveAttrValue = function(){
		 var param = {};
		 var goodsattr = {};
		 goodsattr.id = "${goodsAttribute.id }";
		 goodsattr.name = $(categoryAttr.panelId + " #attrName").val();
		 param.goodsattr = goodsattr;
		 $.ajax({
			type : "POST",
			url : "attribute/addData",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(param),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(categoryAttr.panelId).panel('close');
					$(categoryAttr.gridId).datagrid('reload');
					$(categoryAttr.listId).show();
				}
			}
		 }); 
 	}
	
</script>