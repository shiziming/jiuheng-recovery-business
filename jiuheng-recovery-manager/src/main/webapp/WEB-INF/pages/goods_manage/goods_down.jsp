<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="goods_down_page">
	<c:if test="${hasBillId==true}">
			当前单据号为：<input type='text' id="goods_down_billId" value="${billId}" disabled="disabled">
	</c:if>
	<input type='hidden' id="billId" value="${billId}">
	<table title="维护下架单据" id="dg"></table>
	<form id="searchForm">
				<table class="table table-hover table-condensed"
			style="width: 100%; padding: 7px 80px 0px 80px">
			
			<tr style="margin: 20px 0px">
				<td width="5%"></td>
				<td width="5%"></td>
				<td width="5%" align="center">
				<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 100px;" onclick="goods_down.save();">
				<span style="font-size: 14px;">保 存</span></a>
				<td width="10%">
				<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 100px; margin-left: 50px"
				onclick="goods_down.back();"> <span
				style="font-size: 14px;">返 回</span>
				</a>
				
				</td>
				<td width="10%"></td>
				<td width="10%"></td>
			</tr>
		</table>
	</form>
	<div id="tb" style="display: none;">
		<a href="javascript:void(0);" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true" onclick="goods_down.importStocks();">从文件导入</a>
		<input id="numberattr" style="width: 20px;"
			type="hidden" value="1"> <a href="javascript:void(0);"	class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="goods_down.addRow();">增加</a>
		<a href="javascript:void(0);" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true" onclick="goods_down.delRow();">删除</a>
	</div>
</div>

<script type="text/javascript"	src="common/js/goods_manage/goods_down.js"></script>
