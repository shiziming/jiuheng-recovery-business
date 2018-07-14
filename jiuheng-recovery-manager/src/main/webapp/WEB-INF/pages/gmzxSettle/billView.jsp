<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">

</style>
<div id="gmzxViewBillDetailPage">

	<!-- 单头信息 -->
	<div id="gmzxViewBillDetailPage_head" data-options="selected:true" style="overflow:auto;padding:10px;" class="easyui-panel" title="单头">
		<table>
					<tr >
						<td style="text-align: right; width: 100px">
							单据编号：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_billId" name="" readonly="readonly" value="${bill.billId}" disabled="disabled" class="easyui-textbox"/>
						</td>
						<td style="text-align: right; width: 150px">
							平台店铺代码：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_popShopId" name="" readonly="readonly" value="${bill.popShopId}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 100px">
							状态：
						</td>
						<td>
							<input type="hidden" id="gmzxSettleBillDetail_status" name="" readonly="readonly" value="${bill.status}" />
							<c:if test="${bill.status==0}">
								<input type="text" id="gmzxStatusNameDetail" class="easyui-textbox" value="建单中"  readonly="readonly"></>
							</c:if>
							<c:if test="${bill.status==1}">
								<input type="text" id="gmzxStatusNameDetail" class="easyui-textbox" value="已审核"   readonly="readonly"></>
							</c:if>
						</td>	
					</tr>
					
					<tr >
					    <td style="text-align: right; width: 150px">
							制单人名称：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_createUserName" name="" readonly="readonly" value="${bill.createUserName}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							制单时间：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_createTime" name="" readonly="readonly" value="${bill.createTime}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							审核人名称：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_auditUserName" name="" readonly="readonly" value="${bill.auditUserName}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							审核时间：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_autditTime" name="" readonly="readonly" value="${bill.autditTime}" class="easyui-textbox" />
						</td>
					</tr>
					
                    <tr>
					    <td style="text-align: right; width: 150px">
							总成交金额：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_salesAmountSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.salesAmountSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							平台优惠金额合计：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_discAmountPopSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.discAmountPopSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							佣金合计：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_commissionSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.commissionSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							销售净金额合计：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_netSalesAmountSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.netSalesAmountSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
                    </tr>
					<tr>
                        <td style="text-align: right;">
							结算起止时间：
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_time1" name="" readonly="readonly" value="${bill.startTime}" class="easyui-textbox" /> - 
						</td>
						<td>
							<input type="text" id="gmzxSettleBillDetail_time2" name="" readonly="readonly" value="${bill.endTime}" class="easyui-textbox" />
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="GmzxSettleBillDetailUtils.exportExcel()">导出</a>
						    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="GmzxSettleBillDetailUtils.justBack()">返回</a>
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
	<div  id="gmzxViewBillDetailPage_details"  data-options="selected:true" style="overflow:auto;padding:10px;"  class="easyui-panel" title="明细">
		<div id="gmzxSettleBillDetailPage_dg1" ></div>
	</div>

	
</div>

<script type="text/javascript" src="common/js/gmzxSettle/billDetail.js"></script>
