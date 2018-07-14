<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="gmplus_order_index">
	<div id="list_panel" class="easyui-panel" style="width:100%">
		<div id="list_search_panel" class="easyui-panel" title="查询条件" data-options="collapsible:true"
			style="width: 100%; height: 180px;background: #ffffff;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 2px 1% 0px 1%">
					<tr>
						<td width="80px" align="center">主单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="xsddh"></td>
						<td width="80px" align="center">分单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="xsfdh"></td>
					    <td width="80px" align="center">分单类型</td>
						<td width="100px"><select id="xsfdlx" name="xsfdlx" class="easyui-combobox" editable="false" style="width:74%;"
						 data-options="onSelect:function(rec){
						 	    $('#gmplus_order_index #list_panel #status').combobox('clear'); 
						 		if(rec.value==''){
						 			$('#gmplus_order_index #list_panel #status').combobox('setValues', []);
						 			return;
						 		}
						 		var url='order/getOrderStatus/'+rec.value;
								$('#gmplus_order_index #list_panel #status').combobox('reload',url);
							}">
								<option value="" selected="selected"></option>
								<option value="0">销售订单</option>
								<option value="1">退款订单</option>
								<option value="2">冲红订单</option>
								<option value="3">拒收订单</option>
								<option value="4">退货订单</option>
								<option value="5">换货订单</option>
						</select></td>
						
					</tr>
					<tr>
						<td width="80px" align="center" style="padding-bottom:10px;">国美+订单编号</td>
						<td width="80px" style="padding-bottom:10px;"><input  class="easyui-textbox" name="wbxsddh" type="text"></td>
						<!-- <td width="80px" align="center" style="padding-bottom:10px;">门店代码</td>
						<td width="80px" style="padding-bottom:10px;"><input  class="easyui-textbox" name="mddm" type="text"></td> -->
					    <td width="80px" align="center">原分单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="yxsfdh" type="text"></td>
					    <!-- <td width="80px" align="center" style="padding-bottom:10px;">销售公司代码</td>
						<td width="80px" style="padding-bottom:10px;"><input  class="easyui-textbox" name="xsgsdm" type="text"></td> -->
						<td></td>
						<td></td>
					</tr>
					<tr>
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
						<td></td>
						<td></td>
					</tr>
<!-- 				</table> -->
<!-- 				<table class="table table-ho ver table-condensed" style="width: 100%; padding: 2px 1% 0px 1%"> -->
					<tr>
						<td width="80px" align="center">是否3C</td>
						<td width="80px"><select id="wlpslx" name="wlpslx" class="easyui-combobox" style="width: 74%" editable="false">
								<option value="" selected="selected">全部</option>
								<option value="2">是</option>
								<option value="1">否</option>
						</select></td>
						<td width="80px" align="center">订单发货日期</td>
						<td width="80px" colspan="2"><input id="fhsj1" style="width:100px"
							placeholder="起始日期" class="easyui-datebox" name="fhsj1" type="text" />至
							<input id="fhsj2" style="width: 100px" placeholder="结束日期" class="easyui-datebox" name="fhsj2" type="text" />
						</td>
						<td width="80px" align="center"></td>
						<td align="left" colspan="2"><a href="#" id="list_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="list_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
					
				</table>
			</form>
		</div>
		<div data-options="border:false" >
			<table id="dg"></table>
		</div>
		<%-- <div id="tb">
			<c:if test="${FUNC_EXPORT}">
				<a href="#" id="exportBtn" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-save" plain="true" onclick="$('#order_index_exportWin').window('open');">导出当前查询的所有结果</a> 
			</c:if>
		</div> --%>
		
		<div id="tb">
			<c:if test="${FUNC_EXPORT}">
				<a href="#" id="gmplusExportBtn" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-save" plain="true" onclick="$('#order_index_exportWin').window('open');">导出当前查询的所有结果</a>
			</c:if>
			<!-- <a href="#" id="amazonCreatPositiveOrder" class="easyui-linkbutton"
				data-options="disabled:true" iconCls="icon-edit" plain="true" onclick="amazonOrderquery.creatPositiveOrder()">创建正向订单</a> -->
			<c:if test="${FUNC_CREATEREVERSEORDER}">
				<a href="#" id="gmplusCreatReverseOrder" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-redo" plain="true" onclick="gmplusOrderQuery.creatReverseOrder()">创建逆向订单</a>
			</c:if>
		</div>
		<div id="order_index_exportWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-excel'" title="导出向导" style="width:300px;height:180px;">
		    <form style="padding:10px 20px 10px 40px;" style="width:250px;">
		        <select id="exportType" name="exportType"  class="easyui-combobox"  type="text" style="width:200px;">
		        	<option value="excel2003">Excel 2003格式</option>   
    				<option value="excel2007">Excel 2007格式</option>   
		        </select>
		        <div style="padding:20px;text-align:center;">
		            <a href="#" class="easyui-linkbutton" id="order_index_exportBtn" icon="icon-ok" onclick="gmplusOrderQuery.exportExcel($('#order_index_exportWin #exportType').combobox('getValue'))">Ok</a>
		            <a href="#" class="easyui-linkbutton" icon="icon-cancel" onclick="$('#order_index_exportWin').window('close');">Cancel</a>
		        </div>
    		</form>
		</div>
    </div>
    <div id="gmplusOrder_index_creatReverseOrder" class="easyui-window" data-options="modal:true,closed:true"></div>
	<div class="easyui-panel" id="view_panel" data-options=" closed:true, cache:false" style="display:block;width:99%">
	
	</div>
</div>
    <script type="text/javascript"	src="common/js/gmplusOrder/index.js"></script>
