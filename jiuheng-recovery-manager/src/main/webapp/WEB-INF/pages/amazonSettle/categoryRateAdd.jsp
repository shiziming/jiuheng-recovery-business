<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#categoryRatePage #importPanel table {
	padding: 30px 80px
}

#categoryRatePage #importPanel table tr {
	line-height: 30px;
}

#categoryRatePage #importPanel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
	<table id="rateTable" >
		<tr>
			<td width="30%" align="right">渠道代码:</td>
			<td width="70%"><input name="channelId" id="channelId" class="easyui-numberbox"  data-options="required:true"/></td>
		</tr>
		<tr>
			<td>大类代码:</td>
            <td>
			<select name="categoryId" id="categoryId" class="easyui-combobox" style="width: 132px;" editable="false" data-options="required:true">
	               <option selected="selected" value=""></option> 
		           <c:forEach items="${goodsCategory}" var="gc">
			          	<option value="${gc.categoryId}" >${gc.categoryName}</option>
			       </c:forEach>
             </select>
             </td>
		</tr>
		<tr>
			<td>结算扣率:</td>
			<td><input name="settleRate" id="settleRate" class="easyui-numberbox" data-options="max:0.9999,precision:4,required:true" /></td>
		</tr>
		<tr>
			<td>广告费比例:</td>
			<td><input name="advRate" id="advRate"  class="easyui-numberbox"  data-options="max:0.9999,precision:4,required:true"/></td>
		</tr>
	</table>
  </form>
  <div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="categoryrate.save();"> <span style="font-size: 14px;">保存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="categoryrate.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
  </div>
</div>