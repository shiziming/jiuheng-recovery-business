<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="copy_Add_page">
<!-- 微店首页单据新增页面 -->
	<div id="indexGood_AddWindow">
		<div id="indexGood_AddWindow_show" class="easyui-panel" 
			style="padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="indexGoodsAddForm" method="post">
			<table>
				<tr>
					<td>销售组织：</td>
	    		<td>
	    		<select id="salAgencyCodeId" class="easyui-combobox" name="salAgencyCode" editable="false" style="width:135px;"data-options="required:true">   
				    <option value="">--请选择--</option>   
				    <c:forEach items="${indexGoods.list}" var="saleOrg">
				    <option value="${saleOrg.saleOrgCode}">${saleOrg.saleOrgName}</option>
				    </c:forEach>
				</select>
   				</td>
   				<td width="30px">
   				<input type="hidden" value="${indexGoods.orderAgencyCode}" id="orderAgencyCodeIdID">
   				<c:if test="${indexGoods.orderNum!=null}">
   				<input type="hidden" value="${indexGoods.orderNum}" id="orderNumID" name="orderNum">
   				</c:if>
   				</td>
					<td width="85px">计划发布日期：</td>
					<td width="80px" align="left"><input style="width: 99%"
							placeholder="计划发布时间" class="easyui-datebox" name="publishDate"  id="publishDateId" editable="false" data-options="required:true" />
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div style="padding: 20px 100px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;" onclick="copyIndexGoodsAdd.submit();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="copyIndexGoodsAdd.returnToList();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
	</div>
	<div id="magnifier_SalAgencyCode_Window" class="easyui-window"
		data-options="closed:true, cache:false,border:false"></div>
</div>
<script type="text/javascript" src="common/js/wdIndexGoods/copyAddIndexGoods.js"></script>
