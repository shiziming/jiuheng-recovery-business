<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="attrPage">
	<div id="listPanel">
		<table id="dataGrid"></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table>
						<tr>
							<td class="label">id:</td>
							<td class="content">
								<input name="id"/>
							</td>
							<td class="label">名称:</td>
							<td class="content">
								<input name="name"/>
							</td>
							 <td> <a id="btnSearch" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>  
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
					<a id="btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">新增</a>
					<a id="btnEdit" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit',plain:true">修改</a>
					<a id="btnDel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">删除</a>
			</div>
		</div>
	</div>
	
	<div id="editPanel" class="easyui-panel" data-options="iconCls:'icon-save', closed:true, cache:false"></div>
	
	<script type="text/javascript" src="common/js/category_attribute/attribute.js"></script> 
</div>
