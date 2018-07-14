<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
</script>
<style>
#twocodePage #edit_panel table {
	padding: 30px 80px
}

#twocodePage #edit_panel table tr {
	line-height: 30px;
}

#twocodePage #edit_panel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
	<table id="activityTable" >
		<tr>
			<td width="30%" align="right">门店代码:</td>
			<td width="70%">
			  <input name="storeCode" value="${twocode.storeCode }" id="storeCode"  class="easyui-textbox" data-options="required:true"/>
             </td>
		</tr>
		<tr>
			<td width="30%" align="right">商品内码:</td>
			<td width="70%">
			  <input name="skuId" value="${twocode.skuId }" id="skuId"  class="easyui-textbox" data-options="required:true"/>
             </td>
		</tr> 
	</table>
</form>
	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="twocode.save();"> <span style="font-size: 14px;">保
				存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="twocode.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>