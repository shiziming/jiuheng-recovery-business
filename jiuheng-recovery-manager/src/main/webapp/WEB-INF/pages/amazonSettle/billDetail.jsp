<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">

</style>
<div id="settleBillDetailPage">

	<!-- 单头信息 -->
	<div id="settleBillDetailPage_head" data-options="selected:true" style="overflow:auto;padding:10px;" class="easyui-panel" title="单头">
		<table>
					<tr >
						<td style="text-align: right; width: 100px">
							单据编号：
						</td>
						<td>
							<input type="text" id="settleBillDetail_billId" name="" readonly="readonly" value="${bill.billId}" disabled="disabled" class="easyui-textbox"/>
						</td>
						<td style="text-align: right; width: 150px">
							公司代码：
						</td>
						<td>
							<input type="text" id="settleBillDetail_companyId" name="" readonly="readonly" value="${bill.companyId}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 100px">
							销售组织代码：
						</td>
						<td>
							<input type="text" id="settleBillDetail_saleOrgId" name="" readonly="readonly" value="${bill.saleOrgId}" class="easyui-textbox"/>
						</td>
						<td style="text-align: right; width: 100px">
							状态：
						</td>
						<td>
							<input type="hidden" id="settleBillDetail_status" name="" readonly="readonly" value="${bill.status}" />
							<c:if test="${bill.status==0}">
								<input type="text" id="statusNameDetail" class="easyui-textbox" value="建单中"  readonly="readonly"></>
							</c:if>
							<c:if test="${bill.status==1}">
								<input type="text" id="statusNameDetail" class="easyui-textbox" value="已审核"   readonly="readonly"></>
							</c:if>
						</td>
					</tr>

					<tr>
						<td style="text-align: right; width: 150px">
							制单人名称：
						</td>
						<td>
							<input type="text" id="settleBillDetail_createUserName" name="" readonly="readonly" value="${bill.createUserName}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							制单时间：
						</td>
						<td>
							<input type="text" id="settleBillDetail_createTime" name="" readonly="readonly" value="${bill.createTime}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							审核人名称：
						</td>
						<td>
							<input type="text" id="settleBillDetail_auditUserName" name="" readonly="readonly" value="${bill.auditUserName}" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							审核时间：
						</td>
						<td>
							<input type="text" id="settleBillDetail_autditTime" name="" readonly="readonly" value="${bill.autditTime}" class="easyui-textbox" />
						</td>
					</tr>
					    
					<tr>
					    <td style="text-align: right; width: 150px">
							总成交金额：
						</td>
						<td>
							<input type="text" id="settleBillDetail_salesAmountSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.salesAmountSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							佣金合计：
						</td>
						<td>
							<input type="text" id="settleBillDetail_commissionSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.commissionSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							广告费合计：
						</td>
						<td>
							<input type="text" id="settleBillDetail_advFeeSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.advFeeSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
						<td style="text-align: right; width: 150px">
							退货管理费合计：
						</td>
						<td>
							<input type="text" id="settleBillDetail_refundMgmtFeeSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.refundMgmtFeeSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
                    </tr>
					<tr>
					    <td style="text-align: right; width: 150px">
							销售净金额合计：
						</td>
						<td>
							<input type="text" id="settleBillDetail_netSalesAmountSum" name="" readonly="readonly" value="<fmt:formatNumber value='${bill.netSalesAmountSum/100}' pattern='#0.00'/>" class="easyui-textbox" />
						</td>
					    <td style="text-align: right; width: 150px">
							出账日期：
						</td>
						<td>
							<input type="text" id="settleBillDetail_time3" name="" value="${bill.settleDate}" readonly="readonly" editable="false"  class="easyui-datebox" />
						</td>
						<td style="text-align:right;">
							结算起止时间：
						</td>
						<td>
							<input type="text" id="settleBillDetail_time1" name="" value="${bill.startTime}" readonly="readonly" editable="false"  class="easyui-datebox"/> - 
						</td>
						<td>
							<input type="text" id="settleBillDetail_time2" name="" value="${bill.endTime}" readonly="readonly" editable="false"  class="easyui-datebox"/>
						</td>
					    <td colspan = "2">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="SettleBillDetailUtils.back()">返回</a>
						
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="SettleBillDetailUtils.exportExcel()">导出</a>
							
						<c:if test="${FUNC_CHECK &&  bill.status == 0}">
						<a href="javascript:void(0)" id="detail_href_audit" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="SettleBillDetailUtils.audit()">审核</a>
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
	<div  id="settleBillDetailPage_details"  data-options="selected:true" style="overflow:auto;padding:10px;"  class="easyui-panel" title="明细">
		<div id="settleBillDetailPage_dg1" ></div>
	</div>

			<c:if test="${FUNC_CHECK &&  bill.status == 0}">
	<!-- toolbar -->
	<div id="settleBillDetailPage_tb2" class="easyui-panel">
		<table>
			<tr>
				<td style="text-align: right; width: 150px">
					出账日期：
				</td>
				<td>
					<input type="text" id="settleBillDetails_time3" name="" value="${bill.settleDate}" editable="false" pattern="yyyy-MM-dd" class="easyui-datebox" style="width:95px;"/>
				</td>
			    <td style="text-align: right; width: 80px">
				</td>
				<td style="text-align: right; ">
					结算起止时间：
				</td>
				<td>
					<input type="text" id="settleBillDetails_time1" name="" value="${bill.startTime}"  editable="false" class="easyui-datebox" pattern="yyyy-MM-dd" style="width:95px;" />
					- <input type="text" id="settleBillDetails_time2" name="" value="${bill.endTime}"  editable="false" class="easyui-datebox" pattern="yyyy-MM-dd" style="width:95px;" />
				</td>
							    <td style="text-align: right; width: 80px">
				</td>
				<td>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SettleBillDetailUtils.search(this)">刷新对账数据</a>&nbsp;&nbsp;
				</td>
				<td>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="SettleBillDetailUtils.remove()">移除</a>
				</td>
 			</tr>

		</table>
	</div>
		</c:if>	
	
	
</div>

<script type="text/javascript" src="common/js/amazonSettle/billDetail.js"></script>
