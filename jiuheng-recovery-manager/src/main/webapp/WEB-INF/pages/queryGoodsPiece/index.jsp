<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="queryGoodsPrice_Page">
<!-- SKU价格有效期查询 -->
	<div id="queryGoodsPrice_Panel">
		<div id="queryGoodsPrice_searchPanel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: 120px; padding-top: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table style="width: auto;">
					<tr >
						<td width="2%" align="right">销售组织代码</td>
						<td width="2%" align="left" ><input name="saleOrgCode" id="saleOrgCode" 
							type="text" placeholder="请输入销售组织代码" class="span2"></td>
						<td width="2%" align="right" >商品SKUID</td>
						<td width="2%" align="left" ><input name="skuId" id="skuId"
							type="text" placeholder="请输入商品SkuId" class="span2"></td>
						<td width="2%" align="right" >价格类型</td>
						<td width="2%" align="left"><select id="priceType" name="priceType" class="easyui-combobox" editable="false" >
							<option value="">--请选择--</option>
							<option value="ZP43">期间价</option>
							<option value="ZP44">长期价</option>
							<option value="ZP45">爆款价格集采</option>
							<option value="ZP46">爆款价格地采</option>
							</select>
						</td>
						<td width="2%"></td>
					</tr>
					<tr>
						<td width="2%" align="right" >价格失效期范围</td>
						<td width="2%" align="left" colspan="4"><input	placeholder="起始日期" class="easyui-datebox" required="required"
						name="beginDate" type="text" id="beginDate"/>至<input	placeholder="结束日期" class="easyui-datebox" required="required"
						name="endDate" type="text" id="endDate"/></td>
						<td width="5%"><a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="queryGoodsPrice.query()">查询</a></td>
							<td width="2%"></td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 表格 -->
		<div data-options="border:false">
			<table id="queryPriceResult"></table>
		</div>
		<c:if test="${FUNC_EXPORT}">
		<div id="toolbar">
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-save" plain="true" onclick="queryGoodsPrice.excel()">导出</a>
		</div>
		</c:if>
	</div>
</div>
 
<script type="text/javascript"	src="common/js/queryGoodsPiece/index.js"></script>
