<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
</script>
<style>
#list_coupontype #edit_panel table {
	padding: 30px 80px
}

#list_coupontype #edit_panel table tr {
	line-height: 30px;
}

#list_coupontype #edit_panel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
  <input type="hidden" id="couponTypeId"  name="couponTypeId" value="${couponType.couponTypeId }">
	<table id="activityTable" >
		<tr>
			<td width="30%" align="right">优惠券名称:</td>
			<td width="70%">
			  <input name="couponName" value="${couponType.couponName }" id="couponName"  class="easyui-textbox" data-options="required:true"/>
             </td>
		</tr>
		<tr>
			<td width="30%" align="right">虚拟券标记:</td>
			<td width="70%">
			  <input ${couponType.virCoupon==1?"checked='checked'":""} name="virCoupon" value="1" id="virCoupon"  type="radio" />是
			  <input ${couponType.virCoupon==0?"checked='checked'":""} name="virCoupon" value="0" id="virCoupon"  type="radio"/>否
             </td>
		</tr>
		<tr>
			<td width="30%" align="right">编号券标记:</td>
			<td width="70%">
			  <input name="numCoupon" value="1" id="numCoupon"  type="radio"${couponType.numCoupon==1?"checked='checked'":""}/>是
			  <input name="numCoupon" value="0" id="numCoupon"  type="radio"${couponType.numCoupon==0?"checked='checked'":""}/>否
             </td>
		</tr>
		<tr>
			<td width="30%" align="right">使用场景类型:</td>
			<td width="70%">
			 <select id="sceneType" class="easyui-combobox" style="width: 132px;" editable="false">
					<option ${couponType.sceneType==1?"selected='selected'":""} value="1" >支付</option>
					<option ${couponType.sceneType==2?"selected='selected'":""} value="2">折扣</option>
			</select>
             </td>
		</tr>
		<tr>
			<td width="30%" align="right">使用限制标记:</td>
			<td width="70%">
			  <input ${couponType.usedlimit==1?"checked='checked'":""} name="usedlimit" value="1" id="usedlimit"  type="radio"/>是
			  <input ${couponType.usedlimit==0?"checked='checked'":""} name="usedlimit" value="0" id="usedlimit"  type="radio"/>否
             </td>
		</tr>
		<tr>
			<td width="30%" align="right">财务记账类型:</td>
			<td width="70%">
			 <select id="accountType" class="easyui-combobox" style="width: 132px;" editable="false">
					<option ${couponType.accountType==1?"selected='selected'":""} value="1" >记折扣</option>
					<option ${couponType.accountType==2?"selected='selected'":""} value="2">记费用</option>
			</select>
             </td>
		</tr>
		<tr>
			<td>开始日期:</td>
			<td><input name="startDate" value="${couponType.startDate }" id="startDate"  class="easyui-datebox" data-options="required:true" editable="false"
			/>
			</td>
		</tr>
		<tr>
			<td>结束日期:</td>
			<td><input name="endDate" value="${couponType.endDate }" id="endDate"  class="easyui-datebox" data-options="required:true" editable="false"
			/></td>
		</tr>
		<tr>
			<td width="30%" align="right">状态:</td>
			<td width="70%">
			  <input ${couponType.status==1?"checked='checked'":""} name="status" value="1" id="status"  type="radio"/>有效
			  <input ${couponType.status==0?"checked='checked'":""} name="status" value="0" id="status"  type="radio"/>无效
            </td>
		</tr>
	</table>
</form>
	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="coupontype.save();"> <span style="font-size: 14px;">保
				存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="coupontype.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>