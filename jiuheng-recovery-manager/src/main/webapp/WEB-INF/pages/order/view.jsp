<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="order_view" style="width: 100%; height: auto;">
     <div id="view_index_panel" class="easyui-panel" style="width: 100%;">
		<div id="order_panel" class="easyui-panel" title="主单信息"	style="width: 100%; background-color: #eff5ff; height: 100%;cache:false"
			data-options="collapsible:true" >
				<table class="table table-hover table-condensed" style="width: 100%; padding: 3px 1% 3px 1%">
					<tr>
						<td width="11%" align="right">订单号 :</td>
						<td width="5%">
							${order.orderId}
							<input type="hidden" id="orderId" value="${order.orderId}">
						</td>
						<td width="11%" align="right">订单状态 :</td>
						<td width="5%">
							<c:if test="${order.status==0}">邮寄中</c:if>
							<c:if test="${order.status==1}">已完成</c:if>
							<c:if test="${order.status==2}">已下单</c:if>
							<c:if test="${order.status==3}">已退货</c:if>
						</td>
						<td width="8%" align="right">商品名称 :</td>
						<td width="12%">${order.goodsName}</td>
						<td width="8%" align="right">回收方式 :</td>
						<td width="5%">
							<c:if test="${order.recoveryType==1}">上门</c:if>
							<c:if test="${order.recoveryType==2}">邮寄</c:if>
						</td>
					</tr>
					<tr>
						<td width="11%" align="right">用户名称 :</td>
						<td id="shrmc" width="5%">${order.userName }</td>
						<td width="11%" align="right">用户电话 :</td>
						<td id="shrdh1" width="5%">${order.userPhone}</td>
						<td width="11%" align="right">顾客留言 :</td>
						<td width="5%">${order.message}</td>
						<td width="8%" align="right">用户地址 :</td>
						<td width="12%">${order.userAdd}</td>
					</tr>
					<tr>
						<td width="8%" align="right">估价金额 :</td>
						<td width="5%"><fmt:formatNumber type="number" value="${(order.valuationPrice)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="8%" align="right">成交金额 :</td>
						<td width="5%"><fmt:formatNumber type="number" value="${(order.dealPrice)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="11%" align="right">运费:</td>
						<td width="5%"><fmt:formatNumber type="number" value="${(order.freightPrice)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="8%" align="right">支付方式 :</td>
						<td width="5%">
							<c:if test="${order.payType==11}">支付宝</c:if>
							<c:if test="${order.payType==12}">微信</c:if>
							<c:if test="${order.payType==13}">银联</c:if>
							<c:if test="${order.payType==99}">线下付款</c:if>
						</td>
					</tr>
					<tr>
						<td width="11%" align="right">预约上门日期 :</td>
						<td width="11%" id="returnId">${order.onDoorTime}</td>
						<td width="11%" align="right">提交时间 :</td>
						<td width="5%">${order.subTime}</td>
						<td></td>
						<td></td>
						<td align="right"><a href="javascript:updateOrder(${order.orderId})" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a></td>
						<td></td>
					</tr>
				</table>
		</div>
		<div id="suborder_panel" class="easyui-panel" title="商品信息" style="width: 100%;  background-color: #eff5ff;height: 100%"
			data-options="collapsible:true">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 5px 1% 3px 1%">
					<c:forEach items="${props}" var="prop">
						<tr>
							<c:if test="${prop.prop1.name!=null}">
								<td width="11%" align="right">${prop.prop1.name} :</td>
								<td width="20%">
									<c:forEach items="${prop.prop1.attributeValues}" var="value">
										${value.attributeValueName}
									</c:forEach>
								</td>
							</c:if>
							<c:if test="${prop.prop2.name!=null}">
								<td width="11%" align="right">${prop.prop2.name} :</td>
								<td width="20%">
									<c:forEach items="${prop.prop2.attributeValues}" var="value">
										${value.prop2.attributeValueName}
									</c:forEach>
								</td>
							</c:if>
							<c:if test="${prop.prop2.name == null}">
								<td width="11%" align="right"></td>
								<td width="20%"></td>
							</c:if>

							<c:if test="${prop.prop3.name!=null}">
								<td width="11%" align="right">${prop.prop3.name} :</td>
								<td width="20%">
									<c:forEach items="${prop.prop3.attributeValues}" var="value">
										${value.prop3.attributeValueName}
									</c:forEach>
								</td>
							</c:if>
							<c:if test="${prop.prop3.name == null}">
								<td width="11%" align="right"></td>
								<td width="20%"></td>
							</c:if>
						</tr>
					</c:forEach>

				</table>
		</div>
		 <div id="order_update_div"></div>
	 </div>
</div>
<script>
	function updateOrder(orderId){
		var url = "order/update?orderId="+orderId;
		var title = "修改订单信息";
		$('#order_update_div').dialog({
			title:title,
			width : 700,
			height : $.o2m.centerHeight,
			cache: false,
			modal : true,
			maximizable:true,
			resizable :true,
			href : url,
			buttons:[{
				text :"保存",
				iconCls:"icon-save",
				handler:function(){
					$.messager.progress();
					 saveOrderService();
				}
			},
				{
					text:"关闭",
					iconCls:"icon-cancel",
					handler:closeOrderService
				}]
		});
	}
	function closeOrderService(){
		$("#order_update_div").dialog("close");
	}
	function saveOrderService(){
		$("#order_data_form").form("submit",{
			url : "order/updateOrder",
			onSubmit:function(param){
				var isValid = $(this).form('validate');
				if (!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
				}
				return isValid;	// 返回false终止表单提交

			},
			success:function(data){
				$.messager.progress('close');	// 如果提交成功则隐藏进度条
				data = $.parseJSON(data);
				if(data.result == true){
					$.messager.alert("提示","保存成功","info");
					$("#order_update_div").dialog("close");
				}
				else {
					$.messager.alert("警告", "保存失败", "warning");
				}
			}
		});
	}

</script>