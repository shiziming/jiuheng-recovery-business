<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="width: 100%;">

<form id="config_edit_form" action="addressArea/updateConfig" method="POST">
		<table style="margin:50px 100px 0 100px">
			<tr style="height:30px;margin:0 auto;">
				<td>地址区域代码:</td>
				<td><input value="${areaConfig.addressAreaCode}" id="addressAreaCode" class="easyui-textbox" readonly="readonly" data-options="editable:false" name="addressAreaCode"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>门店代码:</td>
				<td><input value="${areaConfig.shopCode}" id="shopCode" class="easyui-textbox" readonly="readonly" data-options="required:true" name="shopCode"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>国美标记:</td>
				<td>
						<select class="easyui-combobox" id="isGome" value="${areaConfig.isGome}" name="isGome" editable="false" style="width: 150px" data-options="required:true">
							<!--<c:if test="${areaConfig.isGome} == '1'">
							<option value="1" selected="selected">是</option>
							</c:if>
							<c:if test="${areaConfig.isGome} != '1'">
							<option value="1">是</option>
							</c:if>
							<c:if test="${areaConfig.isGome} == '0'">
							<option value="0" selected="selected">否</option>
							</c:if>
							<c:if test="${areaConfig.isGome} != '0'">
							<option value="0">否</option>
							</c:if>-->
							<option value="1"  ${areaConfig.isGome==1 ? "selected" : ""}>否</option>
							<option value="0"  ${areaConfig.isGome==0 ? "selected" : ""}>是</option>
						</select>
				</td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>仓库代码:</td>
				<td><input value="${areaConfig.warehouseCode}" id="warehouseCode" name="warehouseCode" class="easyui-textbox" readonly="readonly" data-options="editable:false,required:true"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>配送区域代码:</td>
				<td><input value="${areaConfig.deliverAreaCode}" id="deliverAreaCode" name="deliverAreaCode" class="easyui-textbox" ></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>配送远程费:</td>
				<td><input value="${deliverFeeStr}" id="deliverFeeStr" name="deliverFeeStr" class="easyui-textbox" data-options="validType:['disableSpecialChar', 'transIntervalTwo', 'length[1,13]'],required:true"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>配送路桥费:</td>
				<td><input value="${roadTollStr}" id="roadTollStr" name="roadTollStr" class="easyui-textbox" data-options="validType:['disableSpecialChar', 'transIntervalTwo', 'length[1,13]'],required:true"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>安装区域代码:</td>
				<td><input value="${areaConfig.installAreaCode}" id="installAreaCode" name="installAreaCode" class="easyui-textbox"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>POS机编号:</td>
				<td><input value="${areaConfig.posNo}" id="posNo" name="posNo" class="easyui-textbox" data-options="required:true,validType:{length:[1,4]} "></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>是否快递上门取件:</td>
				<td>
						<select class="easyui-combobox" id="pickUpFlag" value="${areaConfig.pickUpFlag}" name="pickUpFlag" editable="false" style="width: 150px" data-options="required:true">
							<option value="1"  ${areaConfig.pickUpFlag==1 ? "selected" : ""}>是</option>
							<option value="0"  ${areaConfig.pickUpFlag==0 ? "selected" : ""}>否</option>
						</select>
				</td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>仓库3C标记:</td>
				<td>
						<select class="easyui-combobox" id="expressFlag" value="${areaConfig.expressFlag}" name="expressFlag" editable="false" style="width: 150px" data-options="required:true">
							<option value="1"  ${areaConfig.expressFlag==1 ? "selected" : ""}>是</option>
							<option value="0"  ${areaConfig.expressFlag==0 ? "selected" : ""}>否</option>
						</select>
				</td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>销售组织代码:</td>
				<td><input value="${areaConfig.shopSaleOrgCode}" id="shopSaleOrgCode" name="shopSaleOrgCode" class="easyui-textbox" data-options="required:true"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>渠道代码:</td>
				<td><input value="${areaConfig.channelCode}" id="channelCode" name="channelCode" class="easyui-textbox" data-options="required:true"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>退货专用标记:</td>
				<td><input value="${areaConfig.returnGoodsMark}" id="returnGoodsMark" name="returnGoodsMark" class="easyui-textbox" data-options="required:true"></input></td>
			</tr>
			<tr style="height:30px;margin:0 auto;">
				<td>门店优先级:</td>
				<td><input value="${areaConfig.priority}" id="priority" name="priority" type="text" class="easyui-numberbox" data-options="required:true"></input></td>
			</tr>
		</table>
		<div style="margin:20px 100px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 80px;" onclick="addressArea.saveConfig();">
				<span style="font-size: 14px;">保 存</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				style="padding: 5px 0px; width: 80px; margin-left: 50px"
				onclick="addressArea.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
</form>
</div>
<!-- 
<script>
	$(document).ready(function(){
	    if($("#gome").val()=="1")
			$('#isGome').combobox("setValue","1");
		else
		    $('#isGome').combobox("setValue","0");
	});
</script> -->

