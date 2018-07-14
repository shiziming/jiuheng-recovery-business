<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="amazonOrder_index">
	<div id="amazonList_panel" class="easyui-panel" style="width:100%">
		<div id="amazonList_search_panel" class="easyui-panel" title="查询条件" data-options="collapsible:true"
			style="width: 100%; height: 180px;background: #ffffff;">
			<form id="amazonSearchForm">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 2px 1% 0px 1%">
					<tr>
						<td width="80px" align="center">主单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="xsddh"></td>
						<td width="80px" align="center">分单号</td>
						<td width="80px"><input  class="easyui-numberbox" name="xsfdh"></td>
					    <td width="80px" align="center">分单类型</td>
						<td width="100px"><select id="xsfdlx" name="xsfdlx" class="easyui-combobox" editable="false" style="width:74%;"
						 data-options="onSelect:function(rec){
						 	    $('#amazonOrder_index #amazonList_panel #fstatus').combobox('clear'); 
						 		if(rec.value==''){
						 			$('#order_index #list_panel #fstatus').combobox('setValues', []);
						 			return;
						 		}
						 		var url='amazonOrder/getOrderStatus/'+rec.value;
								$('#amazonOrder_index #amazonList_panel #fstatus').combobox('reload',url);
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
						<td width="80px" align="center" style="padding-bottom:10px;">亚马逊订单编号</td>
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
						<td width="80px" align="center">订单发货日期</td>
						<td width="80px" colspan="2"><input id="fhsj1" style="width:100px"
							placeholder="起始日期" class="easyui-datebox" name="fhsj1" type="text" />至
							<input id="fhsj2" style="width: 100px" placeholder="结束日期" class="easyui-datebox" name="fhsj2" type="text" /></td>
						<td width="80px" align="center">库存类型</td>
						<td width="80px" align="center">
						<select id="spkclx" name="spkclx" class="easyui-combobox" style="width:80%;">
								<option value="" selected="selected">全部</option>
								<option value="1">门店库存</option>
								<option value="2">DC在库</option>
								<option value="3">DC在途</option>
								<option value="4">厂家带安</option>
						</select>
						</td>
						<td  align="center"></td>
						<td align="left" colspan="2"><a href="#" id="amazonList_query"
							class="easyui-linkbutton" iconCls="icon-search" >查询</a>
							<a href="#" id="amazonList_reset" 
							class="easyui-linkbutton" iconCls="icon-remove">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="border:false" >
			<table id="amazonDg"></table>
		</div>
		<div id="amazonTb">
				<a href="#" id="amazonExportBtn" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-save" plain="true" onclick="$('#amazonOrder_index_exportWin').window('open');">导出当前查询的所有结果</a>
				<a href="#" id="amazonCreatPositiveOrder" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-edit" plain="true" onclick="amazonOrderquery.creatPositiveOrder()">创建正向订单</a>
				<a href="#" id="amazonCreatReverseOrder" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-redo" plain="true" onclick="amazonOrderquery.creatReverseOrder()">创建逆向订单</a>
				<a href="#" id="amazonCreatReverseKuCun" class="easyui-linkbutton"
					data-options="disabled:true" iconCls="icon-reload" plain="true" onclick="amazonOrderquery.creatReverseKuCun()">重新确认库存</a>
		</div>
		<div id="amazonOrder_index_exportWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-excel'" title="导出向导" style="width:300px;height:180px;">
		    <form style="padding:10px 20px 10px 40px;" style="width:250px;">
		        <select id="amazonExportType" name="exportType"  class="easyui-combobox"  type="text" style="width:200px;">
		        	<option value="excel2003">Excel 2003格式</option>   
    				<option value="excel2007">Excel 2007格式</option>   
		        </select>
		        <div style="padding:20px;text-align:center;">
		            <a href="#" class="easyui-linkbutton" id="amazonOrder_index_exportBtn" icon="icon-ok" onclick="amazonOrderquery.exportExcel($('#amazonOrder_index_exportWin #amazonExportType').combobox('getValue'))">Ok</a>
		            <a href="#" class="easyui-linkbutton" icon="icon-cancel" onclick="$('#amazonOrder_index_exportWin').window('close');">Cancel</a>
		        </div>
    		</form>
		</div>
		<div id="amazonOrder_index_creatReverseOrder" class="easyui-window" data-options="modal:true,closed:true"></div>
		<!-- <div id="amazonOrder_index_creatReverseOrder" class="easyui-window" data-options="modal:true,closed:true" title="创建逆向订单确认" style="width:300px;height:180px;">
		    <form style="padding:10px 20px 10px 40px;" style="width:250px;">
		        <select id="reverseReason" name="reverseReason"  class="easyui-combobox"  type="text" style="width:200px;">
		        	<option value="1">无库存</option>   
    				<option value="2">配送地址无法送达</option>
    				<option value="3">买家已取消</option>
    				<option value="4">买家退货</option>
    				<option value="5">买家换货</option>
    				<option value="6">商品没收到</option>
    				<option value="7">一般盘点</option>
		        </select>
		        <input type="hidden" id="xsddh1">
		        <input type="hidden" id="xsfdh1">
		        <div style="padding:20px;text-align:center;">
		            <a href="#" class="easyui-linkbutton" id="amazonOrder_index_reverseOrderBtn" icon="icon-add" onclick="amazonOrderquery.saveReverseOrder();">确认创建</a>
		            <a href="#" class="easyui-linkbutton" icon="icon-back" onclick="$('#amazonOrder_index_creatReverseOrder').window('close');">取消</a>
		        </div>
    		</form>
		</div> -->
    </div>
	<div id="win" closed="true" class="easyui-window" title="修改配送时间" style="width:300px;height:250px;">  
	    <form style="padding:10px 20px 10px 40px;">  
	       <p>配送日期: <input id="psrq" style="width:100px"
							placeholder="配送日期" class="easyui-datebox" required="required"  type="text"></p>  
	       <p>开始时间: <input id="psrqstart" style="width:100px"
							placeholder="配送日期" class="easyui-datetimebox" required="required" type="text"></p>  
	       <p>结束时间: <input id="psrqend" style="width:100px"
							placeholder="配送日期" class="easyui-datetimebox" required="required"  type="text"></p>  
	       
	       	       
	       
	       
	        <div style="padding:5px;text-align:center;">  
	        <a href="#" class="easyui-linkbutton" onclick="modpssj();" icon="icon-ok">确认</a>  
	        </div>  
	    </form>  
	</div>   
	<div class="easyui-panel" id="creatPositiveOrder" data-options=" closed:true, cache:false" style="display:block"></div>
	<div class="easyui-panel" id="amazonView_panel" data-options=" closed:true, cache:false" style="display:block"></div>
</div>
    <script type="text/javascript"	src="common/js/amazonOrder/index.js"></script>
