<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
#amazonCreatPositiveOrder_page .amazonCategories-panel {
	float: left;
	margin-right: 0px;
}
#amazonCreatPositiveOrder_page #aa {
	margin-left: 300px;
}
#amazonCreatPositiveOrder_page #bb {
	margin-top: 50px;
}
</style>
<div id="amazonOrder_CreatPositiveOrder">
	<div id="amazonCreatPositiveOrder_page" style="padding-left: 30px;padding-top:25px">
	<input type="hidden" value="${amazonOrder.xsddh}" id="xsddh">
	<input type="hidden" value="${amazonOrder.xsfdh}" id="xsfdh">
	<div>
		<form id="creatPositiveOrderForm">	
			<table>
				<tr>
					<td align="left"><font size="50" color="#800080" style="font-weight:bold"><b>亚马逊订单地址<b></font></td>
				</tr>
				<tr>
					<td align="left">${address.address0}${address.address1}${address.address2}${address.address3}${address.address4}${address.address5}${address.address6}</td>
				</tr>
				<tr>
					<td align="center">
						O2M地址区域代码：
					</td>
					<td>
						<input id="addressAreaCode"  class="easyui-numberbox" type="text" style="width: 150px" required="required">
					</td>
					<td><a href="#" class="easyui-linkbutton" icon="icon-add" onclick="amazonCreatPositiveOrder.creat();">确定创建</a>
						<a href="#" class="easyui-linkbutton" icon="icon-back" onclick="amazonCreatPositiveOrder.back();">返回</a>
					</td>
				</tr>
			</table>
		</form>
		</div>
		<div id="bb">
		<div class="amazonCategories-panel " id='aa'>
			<table id="dg1"  class="categories-datagrid" ></table>
		</div>
		<div class="amazonCategories-panel amazonPanel-hide">
			<table id="dg2" class="categories-datagrid" ></table>
		</div>
		<div class="amazonCategories-panel amazonPanel-hide">
			<table id="dg3" class="categories-datagrid" ></table>
		</div>
		<div class="amazonCategories-panel amazonPanel-hide">
			<table id="dg4" class="categories-datagrid" ></table>
		</div>
		</div>
	</div>
</div>
    <script type="text/javascript"	src="common/js/amazonOrder/amazonPositiveOrderWindow.js"></script>
