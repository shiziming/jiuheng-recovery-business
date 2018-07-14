<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="check_index" style="width: 100%;">
<!-- 微店退款审核 -->
     <div id="check_index_panel" class="easyui-panel" style="width: 100%;">
		<div id="return_money_panel" class="easyui-panel" title="退款信息"
			style="width: 100%; background-color: #eff5ff;"
			data-options="collapsible:true">
			<input type="hidden" id="returnParOrderId" name="returnParOrderId" value="${returnMoneyMessage.returnParOrderId}">
			<input type="hidden" id="saleCompanyId" name="returnParOrderId" value="${returnMoneyMessage.returnParOrderId}">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 1% 0px 1%" >
					<tr>
						<td width="11%" align="center">支付公司代码 :</td>
						<td id="payCompanyId" width="5%">${returnMoneyMessage.payCompanyId}</td>
						<td width="11%" align="center">支付公司名称 :</td>
						<td id="payCompanyName" width="5%"></td>
						<td width="11%" align="center">销售公司代码 :</td>
						<td id="saleCompanyId" width="5%">${returnMoneyMessage.saleCompanyId}</td>
						<td width="11%" align="center">销售公司名称 :</td>
						<td id="saleCompanyName" width="5%"></td>
						<td width="11%" align="center">门店编码 :</td>
						<td id="shopId" width="5%">${returnMoneyMessage.shopId}</td>
						<td width="11%" align="center">门店名称 :</td>
						<td id="shopName" width="5%"></td>
					</tr>
					<tr>
						<td width="11%" align="center">退款单号 :</td>
						<td width="5%" id="returnId">${returnMoneyMessage.returnId}</td>
						<td width="11%" align="center">退款单状态 :</td>
						<td width="5%" id="retStatus">
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
						<td width="11%" align="center">原支付流水号 :</td>
						<td width="5%" style="word-break:break-all;">${returnMoneyMessage.payId}</td>
						<td width="11%" align="center">支付时间 :</td>
						<td width="5%">${returnMoneyMessage.payTime}</td>
					</tr>
						<c:if test="${FUNCTION_ACTCHECK }">
							<tr>
							    <td width="11%" align="center">发票是否收回 :</td>
								<td width="5%">
		                            <select name="retBillBj" id="retBill1" class="easyui-combobox" style="width: 50px;">
			                           <option value="true" selected="selected">是</option>  
				                       <option value="false">否</option>
		                           </select> 
								</td>
								<td width="11%" id="td1" align="center" >原发票号 :</td>
								<td width="5%" id="td2"><input name="billInfo" class="easyui-textbox" id="oldBillid1" data-options="required:true" style="width:100px;"></td>
								<td width="11%" id="td3" align="center" style="display:none">备注原因 :</td>
								<td width="5%" id="td4" style="display:none;"><input name="despReason" class="easyui-textbox" id="despReason1" data-options="required:true" style="width:100px;"></td>
							    </tr>
						 </c:if>
				         <c:if test="${FUNCTION_DIRCHECK }">
				                <td width="10%" align="center">发票是否收回</td>
						    <c:if test="${returnMoneyMessage.retBillBj == 1 }">
						        <td width="5%" id="retBill2">是</td>
								<td width="10%"  align="center" >原发票号:</td>
							    <td width="5%" id="oldBillid2" >${returnMoneyMessage.billInfo}</td>
							</c:if>
							<c:if test="${returnMoneyMessage.retBillBj == 0 }">
							    <td width="5%" id="retBill2">否</td>
								<td width="10%"  align="center">备注原因:</td>
							    <td width="5%" id="despReason2" >${returnMoneyMessage.billInfo}</td>
						 </c:if>
				 </c:if>
				</table>
		</div>
		<div data-options="border:false" class="easyui-panel" title="订单明细"   data-options="border:false"style="width: 100%;min-height: 100px;background-color: #eff5ff;">
        <table cellspacing="0" cellpadding="0" width="100%" border="1px" class="pn-ltable">
			<thead class="pn-lthead" bgcolor="#DCDCDC">
				<tr>
					<th align="center" width="4%">退款单号</th>
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
						<td id="goodId" align="center">${detail.goodId }</td>
						<td id="goodName" align="center"></td>
						<td align="center">${detail.price }</td>
						<td align="center">${detail.num }</td>
						<td align="center">${detail.trueMoney }</td>
					</tr>
				</c:forEach>
			</tbody>
        </table>
		</div>
		<div style="clear:both;background-color: #E9F2FF;">
			 <div style="float:left; width:49%;">
			 	<div class="easyui-panel" title="退款订单履历" data-options="border:false" style="width: 100%;min-height: 100px;background-color: #eff5ff;">
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
			 </div>
			 <div style="float:left; width:49%; margin-left:2%">
			 	<div class="easyui-panel" title="原订单履历" data-options="border:false" style="width: 100%;min-height: 100px;background-color: #eff5ff;">
					<table cellspacing="0" cellpadding="0" width="100%" border="1px" class="pn-ltable">
						<thead class="pn-lthead" bgcolor="#DCDCDC">
							<tr>
								<th align="center" width="4%">处理时间</th>
								<th align="center" width="4%">状态描述</th>
								<th align="center" width="4%">备注信息</th>
							</tr>
						</thead>
						<tbody class="pn-ltbody">
							<c:forEach items="${returnMoneyMessage.originOrderHistorys}" var="ohistory">
								<tr bgcolor="#ffffff" onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
									<td align="center">${ohistory.checkTime }</td>
									<td align="center">${ohistory.statusDesc }</td>
									<td align="center">${ohistory.despMessage }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			 </div>
			 <div style="clear:both;background-color: rgb(239, 245, 255);"></div>
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
		
		<div style="width: 100%;padding: 5px 0px;min-height: 160px;background-color: #eff5ff;" align="center">
		<c:if test="${FUNCTION_ACTCHECK }">
			<a href="javascript:void(0);" id="btnPass1" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Pass1();"> <span style="font-size: 14px;">发票已确认</span>
			</a> 
		</c:if>
		<c:if test="${FUNCTION_DIRCHECK }">
			<a href="javascript:void(0);" id="btnPass2" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Pass2();"> <span style="font-size: 14px;">同意退款</span>
			</a> 
			 <a href="javascript:void(0);" id="btnBack" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.returned8();"> <span style="font-size: 14px;">线下已退款</span>
			</a>  
		</c:if>
			<!-- <a href="javascript:void(0);" id="btnBack" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Back();"> <span style="font-size: 14px;">驳回退款</span>
			</a> -->
			
			<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.Return();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
</div>
 <div id="check_dialog"  style="padding: 0px 30px;background-color: #eff5ff;" class="easyui-dialog"  data-options="title:'线下退款信息', width:'700px',height:'500px',closed:true ,modal:true">
		<div style="margin:20px 0px " >
				<form id="check_checkFrom1" method="post">
				<table id="ReturnedTable" >
					  <tr>
						 <td width="150px">线下退款支付方式代码:</td>
						 <td width="150px">
							<select id="paymentTypeId8" name="paymentTypeId" class="easyui-combobox"  editable="false"  style="width: 132px;" >
									<option value="12" selected>微信</option>
									<option value="11" >支付宝</option>
									<option value="13" >银联</option>
							 </select>
						</td> 
					 </tr> 
					 <tr>
					    <td>线下退款金额:</td>
		             	<td>
		             	   <input name="refundAmount" id="refundAmount8" class="easyui-numberbox"  data-options="precision:2,required:true"/>
		             	</td>
		             </tr> 
					  <tr>
						<td width="150px"> 线下退款公司账号:</td>
 						<td width="150px" id="companyAccountNo8"></td>
					  </tr> 
				  </table>
				  </form>
				  <form id="check_checkFrom2">
				     <table>
						  <tr>
						      <td width="100px">备注信息:</td>
						  </tr>
						  <tr>
			                  <td ><textarea style="width: 600px; height:50px" name="refundInfo" id="refundInfo8" ></textarea> </td>
			              </tr>
		              </table>
		              </form>
		     </div> 
		
		<div style="padding: 0px 80px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;"
				onclick="check.save8();"> <span style="font-size: 14px;">确认</span>
			</a>
			<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="check.returned();"> <span style="font-size: 14px;">返 回</span>
		    </a> 
	  </div>
	</div>
</div>
<script type="text/javascript"	src="common/js/return_money/check.js"></script>


