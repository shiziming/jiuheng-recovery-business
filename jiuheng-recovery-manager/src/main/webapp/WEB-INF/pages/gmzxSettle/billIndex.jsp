<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">


</style>
<div id="gmzxSettleBillPage">
	<div id="gmzxSettleBillPage_listPanel">
	
		<!-- toolbar -->
		<div id="gmzxSettleBillPage_tb" class="easyui-panel" style="padding:10px">
			<table>
				<tr>
					<c:if test="${FUNC_MAINTAIN}">
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="GmzxSettleBillUtils.openNew()">新建</a>
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="GmzxSettleBillUtils.openDetail()">更改明细</a>
					</td>
					</c:if>
					<c:if test="${FUNC_VIEW}">
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="GmzxSettleBillUtils.viewDetail()">查看明细</a>
					</td>
					</c:if>
				</tr>
			</table>
			<div style="border:solid 2px #add9c0;">
			<table >
				<tr>
						<td style="text-align: right; width: 100px">
							平台店铺ID：
						</td>
						<td>
							<select id="gmzxSettleBillPage_popShopId" class="easyui-combobox" name="" editable="true" style="width:100px;">
							    <option value="">请选择</option>
							    <option value="80011302">国美电器</option>
							    <option value="80011384">大中电器</option>
							    <option value="80011385">永乐电器</option>
							</select>
						</td>
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="GmzxSettleBillUtils.search()">查询</a>
						</td>
				</tr>
			</table>
			</div>
		</div>
		
		<!-- 数据列表 -->
		<div id="gmzxSettleBillPage_dg" ></div>
		
	
	</div>



	<!-- 新增panel -->
	<div id="gmzxSettleBillPage_newPanel"></div>

	<div id="gmzxSettleBillPage_editPanel"></div>

	<!-- 结算单信息 -->
	<div id="gmzxSettleBillPage_billPanel"></div>

	<!-- 查询对账信息panel -->
	<div id="gmzxSettleBillPage_check"></div>
	
	
</div>

<script type="text/javascript" src="common/js/gmzxSettle/billIndex.js"></script>
