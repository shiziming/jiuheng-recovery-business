<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="gmzxOrder_index">
	<div id="gmzxList_panel" class="easyui-panel" style="width:100%">
		<div id="gmzxList_search_panel" class="easyui-panel" title="查询条件" data-options="collapsible:true"
			style="width: 100%; height: 180px;background: #ffffff;">
			<form id="gmzxSearchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 2px 1% 0px 1%">
					<tr>
						<td width="80px" align="center">主单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="xsddh"></td>
						<td width="80px" align="center">分单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="xsfdh"></td>
					    <td width="80px" align="center">分单类型</td>
						<td width="100px"><select id="xsfdlx" name="xsfdlx" class="easyui-combobox" editable="false" style="width:74%;"
						 data-options="onSelect:function(rec){
						 	    $('#gmzxOrder_index #gmzxList_panel #fstatus').combobox('clear'); 
						 		if(rec.value==''){
						 			$('#order_index #list_panel #fstatus').combobox('setValues', []);
						 			return;
						 		}
						 		var url='gmzxOrder/getOrderStatus/'+rec.value;
								$('#gmzxOrder_index #gmzxList_panel #fstatus').combobox('reload',url);
							}">
								<option value="" selected="selected">全部</option>
								<option value="0">销售订单</option>
								<option value="1">退款订单</option>
								<option value="3">拒收订单</option>
								<option value="4">退货订单</option>
						</select></td>
						<td width="80px" align="center">分单状态</td>
						<td width="100px"><select id="fstatus" name="fstatus" class="easyui-combobox"  editable="false" style="width:74%;"
							data-options="valueField: 'value',textField: 'text'">
						</select></td>
					</tr>
					<tr>
						<td width="80px" align="center" style="padding-bottom:10px;">国美在线订单编号</td>
						<td width="80px" style="padding-bottom:10px;"><input  class="easyui-textbox" name="wbxsddh" type="text"></td>
						<td width="80px" align="center">原分单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="fyxsfdh" type="text"></td>
					    <td width="80px" align="center" style="padding-bottom:10px;">SKUID</td>
						<td width="80px" style="padding-bottom:10px;"><input  class="easyui-textbox" name="skuId" type="text"></td>
						<td width="80px" align="center" style="padding-bottom:10px;">配送区域代码</td>
						<td width="80px"><input  class="easyui-textbox" name="psqydm" type="text"></td>
					</tr>
					<tr>
						<td width="80px" align="center">预约配送日期</td>
						<td width="80px"><input  class="easyui-datebox" name="yypsrq" type="text"></td>
					    <td width="80px" align="center">支付方式</td>
						<td width="80px"><select id="zffsid" name="zffsid" class="easyui-combobox" style="width:74%;">
								<option value="" selected="selected"></option>
								<option value="11">支付宝</option>
								<option value="12">微信</option>
								<option value="13">银联</option>
								<option value="99">线下退款</option>
						</select></td>
						<td width="80px" align="center">订单提交日期</td>
						<td width="80px" colspan="2"><input id="tjsj1" style="width:100px"
							placeholder="起始日期" class="easyui-datebox" required="required" name="tjsj1" type="text" />至
							<input id="tjsj2" style="width: 100px" placeholder="结束日期" class="easyui-datebox" name="tjsj2" type="text" /></td>
					<tr>
						<td width="80px" align="center">是否3C</td>
						<td width="80px"><select id="wlpslx" name="wlpslx" class="easyui-combobox" style="width: 74%" editable="false">
								<option value="" selected="selected">全部</option>
								<option value="2">是</option>
								<option value="1">否</option>
						</select></td>
						<td width="80px" align="center"><!-- 标记类型 --></td>
						<td width="80px"><!-- <select id="bjlx" name="bjlx" class="easyui-combobox" style="width: 74%" editable="false">
								<option value="0" selected="selected">全部</option>
								<option value="1">带安</option>
								<option value="2">零元购</option>
						</select> --></td>
						<td width="80px" align="center"></td>
						<td width="80px" align="center"></td>
						<td width="80px" align="center"></td>
						<td align="left" colspan="2"><a href="#" id="gmzxList_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="gmzxList_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false" >
			<table id="gmzxDg"></table>
		</div>
		<div id="gmzxTb">
		<c:if test="${FUNC_EXPORT}">
				<a href="#" id="gmzxExportBtn" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-save" plain="true" onclick="$('#gmzxOrder_index_exportWin').window('open');">导出当前查询的所有结果</a>
		</c:if>
		<c:if test="${FUNC_CREATORDER}">		
				<a href="#" id="gmzxCreatPositiveOrder" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-edit" plain="true" onclick="gmzxOrderquery.creatPositiveOrder()">创建正向订单</a>
		</c:if>
			<a href="#" id="gmzxCreatReverseKuCun" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-reload" plain="true" onclick="gmzxOrderquery.creatReverseKuCun()">重新确认库存</a>
		</div>
		<div id="gmzxOrder_index_exportWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-excel'" title="导出向导" style="width:300px;height:180px;">
		    <form style="padding:10px 20px 10px 40px;" style="width:250px;">
		        <select id="gmzxExportType" name="exportType"  class="easyui-combobox"  type="text" style="width:200px;">
		        	<option value="excel2003">Excel 2003格式</option>   
    				<option value="excel2007">Excel 2007格式</option>   
		        </select>
		        <div style="padding:20px;text-align:center;">
		            <a href="#" class="easyui-linkbutton" id="gmzxOrder_index_exportBtn" icon="icon-ok" onclick="gmzxOrderquery.exportExcel($('#gmzxOrder_index_exportWin #gmzxExportType').combobox('getValue'))">Ok</a>
		            <a href="#" class="easyui-linkbutton" icon="icon-cancel" onclick="$('#gmzxOrder_index_exportWin').window('close');">Cancel</a>
		        </div>
    		</form>
		</div>
		<div id="gmzxOrder_index_creatReverseOrder" class="easyui-window" data-options="modal:true,closed:true"></div>
    </div>
	<div class="easyui-panel" id="creatPositiveOrder" data-options=" closed:true, cache:false" style="display:block"></div>
	<div class="easyui-panel" id="gmzxView_panel" data-options=" closed:true, cache:false" style="display:block"></div>
</div>
    <script type="text/javascript"	src="common/js/gmzxOrder/index.js"></script>
