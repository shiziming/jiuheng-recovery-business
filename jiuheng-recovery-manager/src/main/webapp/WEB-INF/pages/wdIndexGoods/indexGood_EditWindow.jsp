<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="indexGoods_Edit_page">
<!-- 微店首页商品修改页面 -->
	<div id="indexGood_SearchWindow">
		<div id="indexGood_EditWindow_show" class="easyui-panel" 
			style="padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="indexGoodsEditForm" method="post">
			<input type="hidden" value="${indexGoods.orderAgencyCode}" id="orderAgencyCodeIdID">
			<table>
				<tr>
					<td width="100px" >单据编号：</td>
					<td width="80px" align="left">
					<input type="hidden" value="${indexGoods.orderNum}" id="orderNumidId">
					<input class="easyui-textbox" id="orderNumId" name="orderNum" style="width: 130px" 
					 disabled="disabled" value="${indexGoods.orderNum}"/>
					</td>
					<td width="30px"></td>
					<td>销售组织：</td>
	    		<td>
					<select id="salAgencyCodeId" class="easyui-combobox" name="salAgencyCode" editable="false" style="width:135px;"data-options="required:true">   
				    <c:forEach items="${indexGoods.list}" var="saleOrg">
				    <option ${saleOrg.saleOrgCode==indexGoods.salAgencyCode?"selected='selected'":""} value="${saleOrg.saleOrgCode}">${saleOrg.saleOrgCode}${saleOrg.saleOrgName}</option>
				    </c:forEach>
				</select> 
   				</td>
					<td width="30px"></td>
					<td width="85px">计划发布日期：</td>
					<td width="80px" align="left"><input style="width: 99%"
							placeholder="计划发布时间" class="easyui-datebox" name="publicDate"  id="publicDateId" editable="false" data-options="required:true" value="${indexGoods.publicDate}"/>
					</td>
				</tr>
				<tr>
					<td width="85px">制单人ID：</td>
					<td width="80px" align="left"><input name="creatUserID" class="easyui-textbox"
							style="width: 130px" id="creatUserIDId" value="${indexGoods.creatUserID}" disabled="disabled">
					</td>
					<td width="30px"></td>
					<td width="85px">制单人名称：</td>
					<td width="80px" align="left"><input name="creatUserName" class="easyui-textbox"
							style="width: 130px" id="creatUserNameId" value="${indexGoods.creatUserName}" disabled="disabled">
					</td>
					<td width="30px"></td>
					<td width="85px">制单时间：</td>
					<td width="80px" align="left"><input style="width: 99%"
							placeholder="制单时间" class="easyui-datebox" name="creatDate" disabled="disabled"  id="creatDateId" data-options="required:true" value="${indexGoods.creatDate}"/>
					</td>
				</tr>
			</table>
			</form>
		</div>
		<div style="padding: 20px 210px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;" onclick="indexGoodEdit.submit();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="indexGoodEdit.returnToList();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
	</div>
	<div id="magnifier_SalAgencyCode_Window1" class="easyui-window"
		data-options="closed:true, cache:false,border:false"></div>
</div>
<script type="text/javascript" src="common/js/wdIndexGoods/indexGood_EditWindow.js"></script>
