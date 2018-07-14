<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="indexGoods_salAgencyCode_page">
<!-- 微店首页商品单列表 -->
	<div id="indexGoods_salAgencyCode_panel">
		<!-- 表格 -->
		<div data-options="border:false">
			<form id="checkSalAgencyCode_form" enctype="multipart/form-data"  method="post">
				<input type="hidden" value="${indexGoods.orderNum}" name="orderNum" id="orderNum"/>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-save" plain="true" onclick="indexGoodsSalAgencyCode.downloadTemplate()">模板下载</a>
				<input type="file" name="fileimport" id = "fileimportId" style="width:140px" onclick="$('#saveExport_btn').linkbutton('enable');" />
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-add" plain="true" onclick="indexGoodsSalAgencyCode.uploadSalAgencyCode(this)">导入销售组织</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-ok" plain="true" onclick="indexGoodsSalAgencyCode.add()">确认维护分部爆款</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-ok" plain="true" onclick="indexGoodsSalAgencyCode.checkAll()">全选/反选</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-back" plain="true" onclick="indexGoodsSalAgencyCode.back()">返回</a>
			<table id="indexGoods_salAgencyCode_dg">
				<c:forEach items="${indexGoods.list}" var="saleOrgs">
				<tr>
				<c:if test="${saleOrgs.saleOrgCode1!=null&&saleOrgs.saleOrgCode1!=''}">
					<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode1}"><font style="font-size: 13px">${saleOrgs.saleOrgCode1}</font></td>
				</c:if>
				<c:if test="${saleOrgs.saleOrgCode2!=null&&saleOrgs.saleOrgCode2!=''}">
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode2}"><font style="font-size: 13px">${saleOrgs.saleOrgCode2}</font></td>
	            </c:if>
	            <c:if test="${saleOrgs.saleOrgCode3!=null&&saleOrgs.saleOrgCode3!=''}">
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode3}"><font style="font-size: 13px">${saleOrgs.saleOrgCode3}</font></td>
	            </c:if>
	            <c:if test="${saleOrgs.saleOrgCode4!=null&&saleOrgs.saleOrgCode4!=''}">
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode4}"><font style="font-size: 13px">${saleOrgs.saleOrgCode4}</font></td>
	            </c:if>
	            <c:if test="${saleOrgs.saleOrgCode5!=null&&saleOrgs.saleOrgCode5!=''}">
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode5}"><font style="font-size: 13px">${saleOrgs.saleOrgCode5}</font></td>
	            </c:if>
	            <c:if test="${saleOrgs.saleOrgCode6!=null&&saleOrgs.saleOrgCode6!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode6}"><font style="font-size: 13px">${saleOrgs.saleOrgCode6}</font></td>
	            </c:if>
	            <c:if test="${saleOrgs.saleOrgCode7!=null&&saleOrgs.saleOrgCode7!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode7}"><font style="font-size: 13px">${saleOrgs.saleOrgCode7}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode8!=null&&saleOrgs.saleOrgCode8!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode8}"><font style="font-size: 13px">${saleOrgs.saleOrgCode8}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode9!=null&&saleOrgs.saleOrgCode9!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode9}"><font style="font-size: 13px">${saleOrgs.saleOrgCode9}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode10!=null&&saleOrgs.saleOrgCode10!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode10}"><font style="font-size: 13px">${saleOrgs.saleOrgCode10}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode11!=null&&saleOrgs.saleOrgCode11!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode11}"><font style="font-size: 13px">${saleOrgs.saleOrgCode11}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode12!=null&&saleOrgs.saleOrgCode12!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode12}"><font style="font-size: 13px">${saleOrgs.saleOrgCode12}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode13!=null&&saleOrgs.saleOrgCode13!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode13}"><font style="font-size: 13px">${saleOrgs.saleOrgCode13}</font></td>
				</c:if>
	            <c:if test="${saleOrgs.saleOrgCode14!=null&&saleOrgs.saleOrgCode14!=''}"> 	
	             	<td align="center"><input type="checkbox" name="saleOrgCode" value="${saleOrgs.saleOrgCode14}"><font style="font-size: 13px">${saleOrgs.saleOrgCode14}</font></td>
				</c:if>
				</tr>
				</c:forEach>
			</table>	
			</form>
		</div>
	</div>
</div>
 
<script type="text/javascript"	src="common/js/wdIndexGoods/indexGood_SalAgencyCodeWindow.js"></script>
