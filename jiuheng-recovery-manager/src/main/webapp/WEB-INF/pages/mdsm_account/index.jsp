<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="mdsm_accountPage">
	<div id="listPanel">
		<table id="dataGrid"></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table>
						<tr>
							<td class="label">公司代码:</td>
							<td class="content">
								<input name="companyCode" class="easyui-textbox"/>
							</td>
							<td class="label">支付方式代码:</td>
							<td class="content">
								<input name="payCode" class="easyui-textbox"/>
							</td>
							 <td> <a id="btnSearch" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>  
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
					<a id="btnUpload" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">下载模板</a>
					<a id="btnAddid" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">手动增加</a>
					<a id="btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">批量导入</a>
					<a id="btnDel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">批量删除</a>
			</div>
		</div>
	</div>
	<div id="importPanel" class="easyui-panel"
		data-options="iconCls:'icon-save', closed:true, cache:false"></div>
    </div>
	<script type="text/javascript" src="common/js/mdsm_account/account.js"></script> 
