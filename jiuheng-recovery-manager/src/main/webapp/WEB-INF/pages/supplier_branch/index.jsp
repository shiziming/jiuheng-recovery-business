<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="supplier_branch">
	<div id="listPanel">
		<table id="dataGrid"></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm1">
					<table>
						<tr>
							<td class="label">销售组织:</td>
							<td class="content">
								<input name="saleOrgCode" class="easyui-textbox"/>
							</td>
							<td class="label">供应商编码:</td>
							<td class="content">
								<input name="supplierCode" class="easyui-textbox"/>
							</td>
							 <td class="label">供应商名称:</td>
							<td class="content">
								<input name="supplierName" class="easyui-textbox"/>
							</td>
							<td class="label">是否是平台商:</td>
							<td class="content">
							<select name="platformFlag" class="easyui-combobox" style="width: 132px;" >
							    <option value="" selected="selected"></option>
							    <option value="1" >是</option>
							    <option value="0">否</option>
							</select>
							</td>
							 <td width="132px" align="center"> <a id="btnSearch" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>  
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
					<a id="btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">增加</a>
					<a id="experotExcel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">导出</a>
					<a id="btnDel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">批量删除</a>
			</div>
		</div>
	</div>
	<div id="addPanel" class="easyui-panel"
		data-options="iconCls:'icon-save'"></div>
    </div>
	<script type="text/javascript" src="common/js/supplier_branch/branch.js"></script> 
