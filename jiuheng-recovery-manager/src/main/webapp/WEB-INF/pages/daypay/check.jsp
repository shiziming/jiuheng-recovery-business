<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="check_index" style="width: 100%; height: 740px">
<!-- 微店退款审核 -->
     <div id="check_index_panel" class="easyui-panel" style="width: 100%; height: 100%">
		<div id="return_money_panel" class="easyui-panel" title="退款信息"
			style="width: 100%; padding: 10px; background-color: #eff5ff;"
			data-options="collapsible:true">
			<input type="hidden" id="returnId" name="returnId" value="${returnMoneyMessage.returnId}">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 1% 0px 1%" >
					<tr>
						<td width="11%" align="center">支付公司代码 :</td>
						<td width="5%">${returnMoneyMessage.payCompanyId}</td>
						<td width="11%" align="center">支付公司名称 :</td>
						<td width="5%">${returnMoneyMessage.payCompanyName}</td>
						<td width="11%" align="center">销售公司代码 :</td>
						<td width="5%">${returnMoneyMessage.saleCompanyId}</td>
						<td width="11%" align="center">销售公司名称 :</td>
						<td width="5%">${returnMoneyMessage.saleCompanyName}</td>
						<td width="11%" align="center">门店编码 :</td>
						<td width="5%">${returnMoneyMessage.shopId}</td>
						<td width="11%" align="center">门店名称 :</td>
						<td width="5%">${returnMoneyMessage.shopName}</td>
					</tr>
					<tr>
						<td width="11%" align="center">退货主单号 :</td>
						<td width="5%" id="returnParOrderId">${returnMoneyMessage.returnParOrderId}</td>
						<td width="11%" align="center">退货单状态 :</td>
						<td width="5%">
						<c:if test="${returnMoneyMessage.retStatus==8}">财务审核退款中</c:if>
						<c:if test="${returnMoneyMessage.retStatus==9}">已通知微店退款</c:if>
						<c:if test="${returnMoneyMessage.retStatus==-3}">财务审核未通过</c:if>
						<c:if test="${returnMoneyMessage.retStatus==10}">微店已退款</c:if>
						<c:if test="${returnMoneyMessage.retStatus==11}">微店退款不成功</c:if>
						<c:if test="${returnMoneyMessage.retStatus==12}">线下退款成功</c:if>
						</td>
						<td width="11%" align="center">交易金额 :</td>
						<td width="5%">${returnMoneyMessage.tradeMoney}</td>
						<td width="11%" align="center">其他收款金额 :</td>
						<td width="5%">${returnMoneyMessage.otherMoney}</td>
						<td width="11%" align="center">退款金额 :</td>
						<td width="5%">${returnMoneyMessage.retMoney}</td>
					</tr>
					<tr>
						<td width="11%" align="center">原主订单号 :</td>
						<td width="5%">${returnMoneyMessage.oldParOrderid}</td>
						<td width="11%" align="center">原子订单号 :</td>
						<td width="5%">${returnMoneyMessage.oldChidOrderid}</td>
						<td width="11%" align="center">原支付方式 :</td>
						<td width="5%">${returnMoneyMessage.payName}</td>
					    <td width="11%" align="center">原支付状态 :</td>
						<td width="5%">已支付</td>
						<td width="11%" align="center">支付流水号 :</td>
						<td width="5%" style="word-break:break-all;">${returnMoneyMessage.payId}</td>
						<td width="11%" align="center">支付时间 :</td>
						<td width="5%">${returnMoneyMessage.payTime}</td>
					</tr>
					<tr>
					    <td width="11%" align="center">发票是否收回 :</td>
						<td width="5%">
                           <select name="retBillBj" id="retBill" class="easyui-combobox" style="width: 50px;">
	                           <option value="true" selected="selected">是</option>  
		                       <option value="false">否</option>
                           </select>
						</td>
						<td width="11%" id="td1" align="center" >原发票号 :</td>
						<td width="5%" id="td2"><input name="billInfo" class="easyui-textbox" id="oldBillid" data-options="required:true" style="width:100px;"></td>
						<td width="11%" id="td3" align="center" style="display:none">备注原因 :</td>
						<td width="5%" id="td4" style="display:none;"><input name="despReason" class="easyui-textbox" id="despReason" data-options="required:true" style="width:100px;"></td>
					    </tr>
				</table>
		</div>
		<div data-options="border:false" class="easyui-panel" title="订单明细"   data-options="border:false"style="width: 100%;min-height: 100px;background-color: #eff5ff;">
        <table cellspacing="0" cellpadding="0" width="100%" border="1px" class="pn-ltable">
			<thead class="pn-lthead" bgcolor="#DCDCDC">
				<tr>
					<th align="center" width="4%">退货单号</th>
					<th align="center" width="4%">商品编码</th>
					<th align="center" width="4%">商品名称</th>
					<th align="center" width="4%">单价</th>
					<th align="center" width="4%">数量</th>
					<th align="center" width="12%">实收金额</th>
				</tr>
			</thead>
			<tbody class="pn-ltbody">
				<c:forEach items="${orderDetails }" var="detail">
					<tr bgcolor="#ffffff" onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
						<td align="center">${detail.retOrderid }</td>
						<td align="center">${detail.goodId }</td>
						<td align="center">${detail.goodName }</td>
						<td align="center">${detail.price }</td>
						<td align="center">${detail.num }</td>
						<td align="center">${detail.trueMoney }</td>
					</tr>
				</c:forEach>
			</tbody>
        </table>
		</div>
		<div class="easyui-panel" title="订单履历" data-options="border:false" style="width: 100%;min-height: 100px;background-color: #eff5ff;">
			<table cellspacing="0" cellpadding="0" width="100%" border="1px" class="pn-ltable">
				<thead class="pn-lthead" bgcolor="#DCDCDC">
					<tr>
						<th align="center" width="4%">处理时间</th>
						<th align="center" width="4%">状态描述</th>
						<th align="center" width="4%">备注信息</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${orderHistorys }" var="history">
						<tr bgcolor="#ffffff" onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
							<td align="center">${history.checkTime }</td>
							<td align="center">${history.statusDesc }</td>
							<td align="center">${history.despMessage }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="easyui-panel" title="审核信息" style=" width: 100%;min-height: 150px;background-color: #eff5ff;" data-options="border:false">
		   <table>
			   <tr>
				   <td>备注信息:</td>
			   </tr>
			   <tr>
	              <td width="80%" align="center" ><textarea style="width: 800px; height:50px" name="despMessage" id="despMessage" ></textarea> </td>
	           </tr>
		   </table>
		</div>
		<c:if test="${returnMoneyMessage.retStatus==8}">
		<div style="width: 100%;padding: 0px 5px;min-height: 160px;background-color: #eff5ff;" align="center">
			<a href="javascript:void(0);" id="btnPass" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Pass(2);"> <span style="font-size: 14px;">同意退款</span>
			</a> 
			<a href="javascript:void(0);" id="btnBack" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Back();"> <span style="font-size: 14px;">驳回退款</span>
			</a>
			<a href="javascript:void(0);" id="btnBack" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Pass(3);"> <span style="font-size: 14px;">线下已退款</span>
			</a> 
			<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Return();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
	</c:if>
	<c:if test="${returnMoneyMessage.retStatus==11}">
		<div style="width: 100%;padding: 0px 5px;min-height: 160px;background-color: #eff5ff;" align="center">
			<a href="javascript:void(0);" id="btnPass" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.xxx();"> <span style="font-size: 14px;">线下已退款</span>
			</a> 
		</div>
	</c:if>
</div>
<script type="text/javascript"	src="common/js/return_money/check.js"></script>
</div>

