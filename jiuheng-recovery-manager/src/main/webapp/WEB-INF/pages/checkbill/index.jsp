<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">


</style>
<div id="checkBillPage">
	<div id="checkBillPage_listPanel">
	
		<!-- toolbar -->
		<div id="checkBillPage_tb" class="easyui-panel" style="padding:10px">
			<table>
				<tr>
					<c:if test="${FUNC_MAINTAIN}">
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="CheckBillUtils.openNew()">新建</a>
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="CheckBillUtils.openDetail()">更改明细</a>
					</td>
					</c:if>
					<c:if test="${FUNC_VIEW}">
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="CheckBillUtils.viewDetail()">查看明细</a>
					</td>
					</c:if>
				</tr>
			</table>
			<div style="border:solid 2px #add9c0;">
			<table >
				<tr>
						<td style="text-align: right; width: 100px">
							支付公司代码：
						</td>
						<td>
							<input type="hidden" value="${zbflag} "  id="checkBillPage_zbflag"/>
							<c:if test="${zbflag == 1}">
							<input type="text" id="checkBillPage_compCode" name="" style="width: 100px; " class="easyui-validatebox" value=""/>
							</c:if>
							<c:if test="${zbflag == 0}">
							<input type="text" id="checkBillPage_compCode" name="" style="width: 100px; " class="easyui-validatebox" value="${companyId}" disabled="disabled" />
							</c:if>
						</td>
						<td style="text-align: right; width: 100px">
							支付方式：
						</td>
						<td>
							<select id="checkBillPage_payType" class="easyui-combobox" name="" editable="false" style="width:100px;">
							    <option value="">请选择</option>
							    <option value="12">微信</option>
							    <option value="13">银联</option>
							    <option value="11">支付宝</option>
							</select>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CheckBillUtils.search()">查询</a>
						</td>
				</tr>
			</table>
			</div>
		</div>
		
		<!-- 数据列表 -->
		<div id="checkBillPage_dg" ></div>
		
	
	</div>



	<!-- 新增panel -->
	<div id="checkBillPage_newPanel"></div>

	<div id="checkBillPage_editPanel"></div>

	<!-- 对账单信息 -->
	<div id="checkBillPage_billPanel"></div>

	<!-- 查询对账信息panel -->
	<div id="checkBillPage_check"></div>
	
	
</div>

<script type="text/javascript" src="common/js/checkbill/index.js"></script>
