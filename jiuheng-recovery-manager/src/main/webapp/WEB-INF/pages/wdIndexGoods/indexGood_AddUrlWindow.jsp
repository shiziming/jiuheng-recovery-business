<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="indexGoods_AddUrl_Page">
	<input type="hidden" value="${indexGoods.orderNum}" id="orderNum"/>
	<input type="hidden" value="${indexGoods.goodsSPUID}" id="goodsSPUID"/>
	<table>
	<tr align="center">
		<td></td>
		<td colspan="2"><h3 align="center">请添加链接地址</h3></td>
	</tr>
	<tr>
	<td></td>
	<td align="center" colspan="2"><textarea name="url" id="url" style="height:40px;width:200px;" placeholder="输入链接时请增加http://或https://"></textarea></td>
	</tr>
	<tr><td></td>
		<td align="right"><a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 80px;" onclick="indexGoodAddUrl.submit();">
				<span style="font-size: 14px;">保 存</span></a> 
		</td>
		<td align="left"><a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 80px; "
				onclick="indexGoodAddUrl.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</td>
	</tr>
	</table>
 </div>
<script type="text/javascript"	src="common/js/wdIndexGoods/indexGood_AddUrlWindow.js"></script>
