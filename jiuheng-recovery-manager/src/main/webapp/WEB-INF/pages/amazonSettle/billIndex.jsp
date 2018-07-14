<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">


</style>
<div id="settleBillPage">
	<div id="settleBillPage_listPanel">
	
		<!-- toolbar -->
		<div id="settleBillPage_tb" class="easyui-panel" style="padding:10px">
			<table>
				<tr>
					<c:if test="${FUNC_MAINTAIN}">
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="SettleBillUtils.openNew()">新建</a>
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="SettleBillUtils.openDetail()">更改明细</a>
					</td>
					</c:if>
					<c:if test="${FUNC_VIEW}">
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="SettleBillUtils.viewDetail()">查看明细</a>
					</td>
					</c:if>
				</tr>
			</table>
			<div style="border:solid 2px #add9c0;">
			<table >
				<tr>
						<td style="text-align: right; width: 100px">
							公司代码：
						</td>
						<td>
							<input type="hidden" value="${zbflag} "  id="settleBillPage_zbflag"/>
<%-- 							<c:if test="${zbflag == 1}"> --%>
							<input type="text" id="settleBillPage_companyId" name="" style="width: 100px; " class="easyui-validatebox" value=""/>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${zbflag == 0}"> --%>
<%-- 							<input type="text" id="settleBillPage_companyId" name="" style="width: 100px; " class="easyui-validatebox" value="${companyId}" disabled="disabled" /> --%>
<%-- 							</c:if> --%>
						</td>
						<td style="text-align: right; width: 100px">
							销售组织：
						</td>
						<td>
							<input type="text" id="settleBillPage_saleOrgId" name=""/>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SettleBillUtils.search()">查询</a>
						</td>
				</tr>
			</table>
			</div>
		</div>
		
		<!-- 数据列表 -->
		<div id="settleBillPage_dg" ></div>
		
	
	</div>



	<!-- 新增panel -->
	<div id="settleBillPage_newPanel"></div>

	<div id="settleBillPage_editPanel"></div>

	<!-- 结算单信息 -->
	<div id="settleBillPage_billPanel"></div>

	<!-- 查询对账信息panel -->
	<div id="settleBillPage_check"></div>
	
	
</div>

<script type="text/javascript" src="common/js/amazonSettle/billIndex.js"></script>
