<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">


</style>
<div id="commissionDetailPage">

	<!-- toolbar -->
	<div id="commissionDetailPage_tb" class="easyui-panel">
		<table style="padding:6px">
			<tr>
				<td style="text-align: right; width: 70px">
					<a href="javascript:void(0)" id="commissionDetailPage_href_back" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="CommissionDetailUtils.back()">返回</a>
				</td>
			<c:if test="${FUNC_EXPORT}">
				<td style="text-align: right; width: 70px">
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="CommissionDetailUtils.exportExcel()">导出</a>
				</td>
			</c:if>
			<c:if test="${FUNC_CHECK  &&  bill.status == 0}">
				<td style="text-align: right; width: 70px">
							<a href="javascript:void(0)" id="commissionDetailPage_href_check" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CommissionDetailUtils.audit()">审核</a>
				</td>
			</c:if>
			</tr>
		</table>
	</div>

	<div style="padding:15px" id="commissionDetailPage_panel" class="easyui-panel" title="单头信息" >
				<table id="commissionDetailPage_table_head">
					<tr>
						<td style="text-align: right; width: 100px">
							单据编号：
						</td>
						<td>
							<input type="text" id="commissionDetailPage_billId" value="${bill.billId}" class="easyui-textbox" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							状态：
						</td>
						<td>
							<input type="hidden" id="statusDetailHidden" value="${bill.status}"  />
							<c:if test="${bill.status==0}">
								<input type="text" id="statusDetail" class="easyui-textbox" value="建单中"  disabled="true"></>
							</c:if>
							<c:if test="${bill.status==1}">
								<input type="text" id="statusDetail" class="easyui-textbox" value="已审核"  disabled="true"></>
							</c:if>
						</td>
						
					</tr>					
					<tr >
						<td style="text-align: right; width: 100px">
							销售组织代码：
						</td>
						<td>
							<input type="text" id="saleOrgCodeDetail" class="easyui-textbox" value="${bill.saleOrgCode}" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							销售组织名称：
						</td>
						<td>
							<input type="text" id="saleOrgNameDetail" class="easyui-textbox" value="${bill.saleOrgName}" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							单据机构：
						</td>
						<td>
							<input type="text" id="billOrgDetail" class="easyui-textbox" value="${bill.billOrgCode}"  disabled="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 100px">
							制单人ID：
						</td>
						<td>
							<input type="text" id="createUserDetail" class="easyui-textbox" value="${bill.createUserCode}" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							制单人：
						</td>
						<td>
							<input type="text" id="createNameDetail" class="easyui-textbox" value="${bill.createUserName}" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							制单时间：
						</td>
						<td>
							<input type="text" id="createTimeDetail" class="easyui-textbox" value="${bill.createTime}" disabled="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right; width: 100px">
							审核人ID：
						</td>
						<td>
							<input type="text" id="checkUserCodeDetail" class="easyui-textbox" value="${bill.checkUserCode}" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							审核人名称：
						</td>
						<td>
							<input type="text" id="checkUserNameDetail" class="easyui-textbox" value="${bill.checkUserName}" disabled="true"/>
						</td>
						<td style="text-align: right; width: 100px">
							审核时间：
						</td>
						<td>
							<input type="text" id="checkTimeDetail" class="easyui-textbox" value="${bill.checkTime}" disabled="true"/>
						</td>
						
					</tr>
				</table>
	</div>
	<div>
		<input type="hidden" id="commissionBillId_detail" value="${bill.billId}"/>
	</div>

	<div title="已选中订单分单" data-options="selected:true" style="overflow:auto;padding:10px;"  class="easyui-panel">
			<!-- 已选中数据列表 -->
			<div id="commissionDetailPage_selected_dg" style="height: 300px"></div>
	</div>

			<c:if test="${bill.status == 0}">
	<div id="to_select_detail" title="备选订单分单"   style="overflow:auto;padding:10px;"  class="easyui-panel">
			<!-- 备选数据列表 -->
			<div id="commissionDetailPage_dg" style="height: 300px"></div>
	</div>
			</c:if>

	<!-- toolbar -->
	<div id="commissionDetailPage_tb1" class="easyui-panel">
			<c:if test="${bill.status == 0}">
			<a href="javascript:void(0)" id="href_delete" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="CommissionDetailUtils.remove()">删除</a>
			</c:if>
	</div>


			<c:if test="${bill.status == 0}">
	<div id="commissionDetailPage_tb2" class="easyui-panel">
				<table id="commissionDetailPage_table_detail">
					<tr >
						<td>
							<a href="javascript:void(0)" id="href_add" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="CommissionDetailUtils.add()">添加</a>
						</td>
						<td style="width: 100px"> </td>
						<td>
							销售组织：<input type="text" id="saleOrgCodeUpdate" value="" class="easyui-textbox"/>
						</td>
						<td style="text-align: right; width: 80px">
							起止日期：
						</td>
						<td>
							<input type="text" id="startDay_detail" value="" class="easyui-datebox" style="width: 100px"/>
							- <input type="text" id="endDay_detail" value="" class="easyui-datebox" style="width: 100px"/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CommissionDetailUtils.search()">查询</a>
						</td>
					</tr>
				</table>
	</div>
			</c:if>




</div>

<script type="text/javascript" src="common/js/commission/detail.js"></script>
