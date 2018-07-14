<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="daypay">
	<div id="list_panel" class="easyui-panel">
		<div id="check_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 1% 0px 1%">
					<tr>
						<td width="100px" align="center">OTM凭证号</td>
						<td width="100px"><input  class="easyui-textbox" name="id" type="text"></td>
                        <td width="100px" align="center">是否已上传</td>
						<td width="100px"><select id="uploaded" name="uploaded" class="easyui-combobox" style="width: 132px;">
								<option value=""></option>
								<option value="0">未上传</option>
								<option value="1">上传未反馈</option>
								<option value="2">上传成功</option>
								<option value="-1" selected="selected">上传失败</option>
						</select></td>
						<td width="100px" align="center">接口类型</td>
						<td width="100px"><select id="interfacetype" name="interfacetype" class="easyui-combobox" style="width: 132px;">
								<option value=""></option>
								<option value="FI187" selected="selected">FI187</option>
								<option value="FI188">FI188</option>
								<option value="FI207">FI207</option>
						</select></td>
						<td width="100px" align="center">支付公司代码</td>
						<td width="100px"><input class="easyui-textbox" name="payCompCode" type="text"></td>
					</tr>
					<tr>
						<td width="100px" align="center">凭证日期</td>
						<td width="100px"><input id="voucherDate" style="width: 132px"
							placeholder="起始日期" class="easyui-datebox" name="voucherDate" type="text" />
					    </td>
						<td width="100px" align="center">凭证上传时间</td>
						<td width="100px"><input id="uploadDateStart" style="width:132px"
							placeholder="起始日期" class="easyui-datebox" name="uploadDateStart" type="text" />至
							<input id="uploadDateEnd" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="uploadDateEnd" type="text" /></td>
						<td width="100px" align="center">凭证反馈时间</td>
						<td width="100px"><input id="voucherDateStart" style="width:132px"
							placeholder="起始日期" class="easyui-datebox" name="voucherDateStart" type="text" />至
							<input id="voucherDateEnd" style="width: 132px" placeholder="结束日期" class="easyui-datebox" name="voucherDateEnd" type="text" /></td>
						<td align="center" colspan="2"><a href="#" id="query"
							class="easyui-linkbutton" iconCls="icon-search" style="margin-right: 20px;">查询</a>
							<a href="#" id="check_list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
			<div id="tb" style="display: none;">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok',plain:true"
				onclick="daypay.resend()">重发</a>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
       </div>
	<!-- 微店退款审核界面 -->
	<div class="easyui-panel" id="check_panel" data-options=" closed:true, cache:false" style="display:block">
	
	</div>
		<!-- 微店退款查看界面 -->
	<div class="easyui-panel" id="view_panel" data-options=" closed:true, cache:false" style="display:block">
	
	</div>
	
    <script type="text/javascript"	src="common/js/daypay/daypay.js"></script>
</div>

