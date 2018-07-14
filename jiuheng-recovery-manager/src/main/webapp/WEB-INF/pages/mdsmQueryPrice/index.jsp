<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="mdsmQueryGoodsPrice_Page">
<!-- SKU价格有效期查询 -->
	<div id="mdsmQueryGoodsPrice_Panel">
		<div id="mdsmQueryGoodsPrice_searchPanel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: 210px; padding-top: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table style="width: auto;" >
					<tr>
						<td width="2%" align="right">销售组织代码</td>
						<td width="2%" align="left" ><select id="saleOrgCode" name="saleOrgCode" class="easyui-combobox" editable="false" style="width: 132px;" >
						    <option selected="selected" value=""></option>
							<c:forEach items="${skuPriceWD.saleOrgCodes}" var="saleOrg">
								<option value="${saleOrg }" >${saleOrg }</option>
						    </c:forEach>
						</select></td>
						<td width="2%" align="right" >品牌</td>
						<td width="2%" align="left" ><input name="brand" id="brand" 
							type="text" placeholder="请输入品牌名称" class="span2"></td>
						<td width="2%" align="right" >价格时间查询范围</td>
						<td width="2%" align="left" colspan="3"><input	placeholder="起始日期" class="easyui-datebox"
						name="priceBeginDate" type="text" id="priceBeginDate"/>至<input	placeholder="结束日期" class="easyui-datebox"
						name="priceEndDate" type="text" id="priceEndDate"/></td>
					</tr>
					<tr>
						<td width="2%" align="right">门店代码</td>
						<td width="2%" align="left" ><input name="shopCode" id="shopCode" 
							type="text" placeholder="请输入门店代码" class="span2" value="${shopCode}"></td>
						<td width="2%" align="right">品牌代码</td>
						<td width="2%" align="left" ><input name="brandCode" id="brandCode" 
							type="text" placeholder="请输入品牌代码" class="easyui-numberbox"></td>
						<td width="2%" align="right" >价格失效期范围</td>
						<td width="2%" align="left" colspan="3"><input	placeholder="起始日期" class="easyui-datebox"
						name="beginDate" type="text" id="beginDate"/>至<input	placeholder="结束日期" class="easyui-datebox"
						name="endDate" type="text" id="endDate"/></td>
					</tr>
					<tr>
						<td width="2%" align="right" >品类</td>
						<td width="2%" align="left" ><ul id="categroyCode" class="easyui-combotree" style="width: 150px"></ul></td>
						<td width="2%" align="right" >价格类型</td>
						<td width="2%" align="left"><select id="priceType" name="priceType" class="easyui-combobox" editable="false" >
							<option value="">--请选择--</option>
							<option value="ZP53">长期价格</option>
							<option value="ZP54">期间价格</option>
							</select>
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td width="2%" align="right" >商品SKUID</td>
						<td width="2%" align="left" ><textarea name="skuId" id="skuId" style="height:60px;width:200px;" placeholder="请输入商品SkuId,且SkuId之间用英文逗号分离"></textarea>
						<td width="2%" align="right" >价格是否有效</td>
						<td width="2%" align="left"><select id="validityPrice" name="validityPrice" class="easyui-combobox" editable="false" >
							<option value="0">--请选择--</option>
							<option value="1">有效</option>
							<option value="-1">已失效</option>
							</select>
						</td>
						<td width="2%"></td>
						<td width="2%"></td>
						<td width="2%"></td>
						<td width="2%"><a href="#" 
							class="easyui-linkbutton" iconCls="icon-search" onclick="mdsmQueryGoodsPrice.query()">查询</a></td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 表格 -->
		<div data-options="border:false">
			<table id="queryPriceResult"></table>
		</div>
		<div id="toolbar">
				<!-- <a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-save" plain="true" onclick="mdsmQueryGoodsPrice.excel()">导出</a> -->
		</div>
	</div>
</div>
 
<script type="text/javascript"	src="common/js/mdsmQueryPrice/index.js"></script>
