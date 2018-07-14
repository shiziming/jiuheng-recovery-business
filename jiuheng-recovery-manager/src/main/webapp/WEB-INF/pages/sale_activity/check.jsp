<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
</script>
<style>
#list_sale_activity #check_panel table {
	padding: 30px 80px
}

#list_sale_activity #check_panel table tr {
	line-height: 30px;
}

#list_sale_activity #check_panel table tr td:first-child {
	width: 150px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
	<table id="activityTable" style="height: 200px">
		<tr>
			<td width="125px" align="center">促销活动号:</td>
			 <td width="130px" >
		       <input name="activityId" value="${saleActivity.activityId }" id="activityId"  class="easyui-textbox" editable="false"/>
             </td>
			<td width="125px" align="center">促销活动名称:</td>
			<td width="130px">
			   <input name="activityName" value="${saleActivity.activityName }" id="activityName"  class="easyui-textbox" editable="false"/>
             </td>
            <td width="125px" align="center">开始日期:</td>
			<td width="130px">
			   <input name="startDate" value="${saleActivity.startDate }" id="startDate"  class="easyui-textbox" editable="false"/>
			</td>
			<td width="125px" align="center">结束日期:</td>
			<td width="130px">
			   <input name="endDate" value="${saleActivity.endDate }" id="endDate"  class="easyui-textbox" editable="false"/>
			</td>
		</tr>
		<tr>
			<td width="125px" align="center">单据机构代码:</td>
			<td><input name="billOrgCode" value="${saleActivity.billOrgCode }" id="billOrgCode"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">制单人id:</td>
			<td><input name="createId" value="${saleActivity.createId }" id="billOrgCode"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">制单人名称:</td>
			<td><input name="createName" value="${saleActivity.createName }" id="createName"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">制单时间:</td>
			<td><input name="createTime" value="${saleActivity.createTime }" id="createTime"  class="easyui-textbox" editable="false"/></td>
		</tr>
		
		<tr>
		<c:if test="${saleActivity.status==1 || saleActivity.status==2}">
			<td width="125px" align="center">审核人id:</td>
			<td><input name="createId" value="${saleActivity.checkId }" id="checkId"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">审核人名称:</td>
			<td><input name="createName" value="${saleActivity.checkName }" id="checkName"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">审核时间:</td>
			<td><input name="createTime" value="${saleActivity.checkTime }" id="checkTime"  class="easyui-textbox" editable="false"/></td>
		</c:if>
		</tr>
		<tr>
		<c:if test="${saleActivity.status==2 }">
			<td width="125px" align="center">终止人id:</td>
			<td><input name="endId" value="${saleActivity.endId }" id="checkId"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">终止人名称:</td>
			<td><input name="endName" value="${saleActivity.endName }" id="checkName"  class="easyui-textbox" editable="false"/></td>
			<td width="125px" align="center">终止时间:</td>
			<td><input name="endTime" value="${saleActivity.endTime }" id="checkTime"  class="easyui-textbox" editable="false"/></td>
		</c:if>
		</tr>
	</table>
</form>
	<div style="padding: 0px 80px" align="center">
	  <c:if test="${saleActivity.status==0 }">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="saleactivity.checkPass();"> <span style="font-size: 14px;">审核</span>
		</a> 
	 </c:if>
		 <c:if test="${saleActivity.status==1 }">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="saleactivity.Stop();"> <span style="font-size: 14px;">终止活动</span>
		</a>
		</c:if> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="saleactivity.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>