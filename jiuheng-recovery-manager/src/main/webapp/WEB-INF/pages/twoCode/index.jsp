<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="twocodePage">
<!-- 二维码查询列表 -->
	<div id="twocode_list_panel" class="easyui-panel">
		<div id="twocode_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 1% 0px 1%">
					<tr>
						<td width="100px" align="center">品类代码</td>
						<td width="100px"><input  class="easyui-textbox" name="catorageCode" type="text"></td>
						<td width="100px" align="center">品类名称</td>
						<td width="100px"><input  class="easyui-textbox" name="catorageName" type="text"></td>
						<td width="100px" align="center">品牌代码</td>
						<td width="100px"><input  class="easyui-textbox" name="brandCode" type="text"></td>
						<td width="100px" align="center">品牌名称</td>
						<td width="100px"><input  class="easyui-textbox" name="brandName" type="text"></td>
					</tr>
					<tr>
						<td width="100px" align="center">门店代码</td>
						<td width="100px"><input  class="easyui-textbox" name="storeCode" value="${storeCode}" type="text"/></td>
						<td width="100px" align="center">销售组织代码</td>
						<td width="100px"><select id="saleOrgCode" name="saleOrgCode" class="easyui-combobox" editable="false" style="width: 132px;" >
						    <option selected="selected" value=""></option>
							<c:forEach items="${goodsTwoCodeReq.saleOrgCode}" var="saleOrg">
								<option value="${saleOrg }" >${saleOrg }</option>
						    </c:forEach>
						</select></td>
						<td width="100px" align="center">skuId</td>
						<td width="100px"><input  class="easyui-textbox" name="skuId" type="text"></td>
						<td align="center" colspan="2"><a href="#" id="twocode_list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="twocode_list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
						</tr> 
				</table>
			</form>
		</div>
		<div id="toolbar" style="display: none;">
					<a id="twocode_list_btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">新增</a>
					<a id="twocode_list_btnUpload" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">下载模板</a>
					<a id="twocode_list_btnImport" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">批量导入</a>
					<a id="twocode_list_btnCreate" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">单个生成二维码</a> 
					<!-- <a id="twocode_list_search" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">查看二维码</a> -->
					<a id="twocode_list_export" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true" onclick="twocode.btnExport();">下载二维码</a>
		</div>
		 <div data-options="border:false"> 
			  <table id="dg"></table>
		  </div> 
	</div>
	<div class="easyui-panel" id="edit_panel" data-options="iconCls:'icon-save',closed:true, cache:false" style="display:block"></div>
</div>
   <script type="text/javascript"	src="common/js/twoCode/twocode.js"></script> 
