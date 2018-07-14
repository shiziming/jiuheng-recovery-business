<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">

</style>
<div id="checkBillDetailPage">

	<!-- toolbar -->
	<%-- <div id="checkBillDetailPage_tb" class="easyui-panel">
		<table>
			<tr>
				<td>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="CheckBillDetailUtils.back()">返回</a>
				</td>
				<td style="width: 15px">
				</td>
				<c:if test="${FUNC_CHECK &&  bill.status == 0}">
				<td>
					<a href="javascript:void(0)" id="detail_href_audit" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="CheckBillDetailUtils.audit()">审核</a>
				</td>
				</c:if>
			</tr>
		</table>
	</div> --%>

	<!-- 单头信息 -->
	<div id="checkBillDetailPage_head" data-options="selected:true" style="overflow:auto;padding:10px;" class="easyui-panel" title="单头">
		<table>
					<tr >
						<td style="text-align: right; width: 100px">
							单据编号：
						</td>
						<td>
							<input type="text" id="checkBillDetail_billId" name="" readonly="readonly" value="${bill.billId}" disabled="disabled" class="easyui-textbox"/>
						</td>
						<td style="text-align: right; width: 170px">
							支付公司代码：
						</td>
						<td>
							<input type="text" id="checkBillDetail_payCompanyCode" name="" readonly="readonly" value="${bill.payCompanyCode}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 170px">
							支付方式：
						</td>
						<td>
							<input type="text" id="checkBillDetail_payMethodName" name="" readonly="readonly" value="${bill.payMethodName}" class="easyui-textbox" />
							<input type="hidden" id="checkBillDetail_payMethodId" name="" readonly="readonly" value="${bill.payMethodId}"  />
						</td>
						<td style="text-align: right; width: 100px">
							收付账户：
						</td>
						<td>
							<input type="text" id="checkBillDetail_receiveAccountNo" name="" readonly="readonly" value="${bill.receiveAccountNo}" class="easyui-textbox"/>
						</td>
<!-- 						<td style="text-align: right; width: 100px"> -->
<!-- 							单据机构： -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 							<input type="text" id="checkBillDetail_billAgencyCode" name="" readonly="readonly" value="${bill.billAgencyCode}" class="easyui-textbox" /> --%>
<!-- 						</td> -->
					</tr>
					<tr >
						<td style="text-align: right; width: 170px">
							银行账户号：
						</td>
						<td>
							<input type="text" id="checkBillDetail_bankAccountNo" name="" readonly="readonly" value="${bill.bankAccountNo}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 100px">
							支付日期：
						</td>
						<td>
							<input type="text" id="checkBillDetail_payDate" name="" readonly="readonly" value="${bill.payDate}" class="easyui-textbox"/>
						</td>
						<td style="text-align: right; width: 170px">
							资金到账日期：
						</td>
						<td>
							<input type="text" id="checkBillDetail_arrivalDate" name="" readonly="readonly" value="${bill.arrivalDate}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 170px">
							凭证日期：
						</td>
						<td>
							<input type="text" id="checkBillDetail_voucherDate" name="" readonly="readonly" value="${bill.voucherDate}" class="easyui-textbox" />
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 100px">
							状态：
						</td>
						<td>
							<input type="hidden" id="checkBillDetail_status" name="" readonly="readonly" value="${bill.status}" />
							<c:if test="${bill.status==0}">
								<input type="text" id="statusNameDetail" class="easyui-textbox" value="建单中"  readonly="readonly"></>
							</c:if>
							<c:if test="${bill.status==1}">
								<input type="text" id="statusNameDetail" class="easyui-textbox" value="已审核"   readonly="readonly"></>
							</c:if>
						</td>
						<td style="text-align: right; width: 170px">
							资金到账金额：
						</td>
						<td>
							<input type="text" id="checkBillDetail_arrivalAmount" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.arrivalAmount/100}' pattern='#0.##'/>" class="easyui-textbox" />
							
						</td>
						<td style="text-align: right; width: 170px">
							手续费：
						</td>
						<td>
							<input type="text" id="checkBillDetail_commissionCharge" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.commissionCharge/100}' pattern='#0.##'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 170px">
							制单人名称：
						</td>
						<td>
							<input type="text" id="checkBillDetail_createUserName" name="" readonly="readonly" value="${bill.createUserName}" class="easyui-textbox" />
						</td>
						
					</tr>
					<tr >
						<%-- <td style="text-align: right; width: 100px">
							制单人ID：
						</td>
						<td>
							<input type="text" id="checkBillDetail_createUserId" name="" readonly="readonly" value="${bill.createUserId}" class="easyui-textbox" />
						</td> --%>
						<td style="text-align: right; width: 170px">
							制单时间：
						</td>
						<td>
							<input type="text" id="checkBillDetail_createTime" name="" readonly="readonly" value="${bill.createTime}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 170px">
							审核人名称：
						</td>
						<td>
							<input type="text" id="checkBillDetail_auditUserName" name="" readonly="readonly" value="${bill.auditUserName}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 170px">
							审核时间：
						</td>
						<td>
							<input type="text" id="checkBillDetail_autditTime" name="" readonly="readonly" value="${bill.autditTime}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 100px">
							<font color="red">提现金额：</font>
						</td>
						<td>
							<input type="text" id="checkBillDetail_WithdrawAmount" name="" readonly="readonly" class="easyui-textbox" />
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 103px">
							财务凭证号：
						</td>
						<td>
							<input type="text" id="checkBillDetail_financeVoucherNo" name="" readonly="readonly" value="${bill.financeVoucherNo}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 170px">
							凭证上传标记：
						</td>
						<td>
							<input type="hidden" id="checkBillDetail_voucherUploadFlag" name="" readonly="readonly" value="${bill.voucherUploadFlag}" />
							<c:if test="${bill.voucherUploadFlag==0}">
								<input type="text" id="flagNameDetail" class="easyui-textbox" value="未上传"  readonly="readonly"></>
							</c:if>
							<c:if test="${bill.voucherUploadFlag==1}">
								<input type="text" id="flagNameDetail" class="easyui-textbox" value="已上传"   readonly="readonly"></>
							</c:if>
							<c:if test="${bill.voucherUploadFlag==2}">
								<input type="text" id="flagNameDetail" class="easyui-textbox" value="上传反馈成功"   readonly="readonly"></>
							</c:if>
							<c:if test="${bill.voucherUploadFlag==-1}">
								<input type="text" id="flagNameDetail" class="easyui-textbox" value="上传反馈失败"   readonly="readonly"></>
							</c:if>
						</td>
						<td style="text-align: right; width: 170px">
							凭证上传时间：
						</td>
						<td>
							<input type="text" id="checkBillDetail_voucherUploadTime" name="" readonly="readonly" value="${bill.voucherUploadTime}" class="easyui-textbox" />
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center;">
							订单支付明细起止时间：
						</td>
						<td>
							<input type="text" id="checkBillDetail_time1" name="" value="${bill.startPayTime}" class="easyui-textbox" readonly="readonly"/> - 
						</td>
						<td>
							<input type="text" id="checkBillDetail_time2" name="" value="${bill.endPayTime}" class="easyui-textbox" readonly="readonly"/>
						</td>
						<td></td>
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="CheckBillDetailUtils.back()">返回</a>&nbsp;&nbsp;
						<c:if test="${FUNC_CHECK &&  bill.status == 0}">
						<a href="javascript:void(0)" id="detail_href_audit" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="CheckBillDetailUtils.audit()">审核</a>
						</c:if>
						</td>
					</tr>
					<tr>
					</tr>
					<tr>
					</tr>
					<tr>
					</tr>
					
		</table>
	</div>
	
	<!-- 明细数据列表 -->
	<div  id="checkBillDetailPage_details"  data-options="selected:true" style="overflow:auto;padding:10px;"  class="easyui-panel" title="明细">
		<div id="checkBillDetailPage_dg1" ></div>
	</div>

			<c:if test="${FUNC_CHECK &&  bill.status == 0}">
	<!-- toolbar -->
	<div id="checkBillDetailPage_tb2" class="easyui-panel">
		<table>
			<tr>
				<td style="text-align: right; width: 150px">
							支付公司代码：
				</td>
				<td>
							<input type="text" id="checkBillCheck_payCompanyCode" name="payCompanyCode" value="${bill.payCompanyCode}" style="width:100px;" readonly="readonly" disabled="disabled" class="easyui-validatebox" data-options="validType:{length:[0,4]} "/>
				</td>
				<td style="text-align: right; width: 150px">
							支付方式：
				</td>
				<td>
							<select id="checkBillCheck_payMethodId" class="easyui-combobox" name="payType" data-options="value:${bill.payMethodId}" style="width:80px;" data-options="required:true">
							    <option value="12">微信</option>
							    <option value="13">银联</option>
							    <option value="11">支付宝</option>
							</select>
				</td>
				<td style="text-align: right; width: 170px">
							资金到账日期：
						</td>
						<td>
							<input type="text" id="checkBillCheck_time3" name="" value="${bill.arrivalDate}" editable="false"  class="easyui-datebox" style="width:100px;"/>
						</td>
			</tr>
			<tr>
						<td style="text-align: right; ">
							订单支付明细起止时间：
						</td>
						<td>
							<input type="text" id="checkBillCheck_time1" name="" value="${bill.startPayTime}"  editable="false" class="easyui-datebox" style="width:100px;" />
							- <input type="text" id="checkBillCheck_time2" name="" value="${bill.endPayTime}"  editable="false" class="easyui-datebox" style="width:100px;" />
						</td>
 						
						<td style="text-align: right; width: 80px">
						</td>
						<td>
									<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CheckBillDetailUtils.search(this)">刷新对账数据</a>
						</td>
 			</tr>
			<tr>
				<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="CheckBillDetailUtils.remove()">移除</a>
				</td>
				
			</tr>
		</table>
	</div>
		</c:if>	
	
	
</div>

<script type="text/javascript" src="common/js/checkbill/bill.js"></script>
