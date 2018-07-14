<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
$('#banknum').textbox({
    inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
        keyup:function(){
        	$('#banknum').textbox('setValue',$(this).val().replace(/[^0-9A-Za-z\*]*/g,""));
        }
    })
})
 
</script>
<style>
#accountPage #importPanel table {
	padding: 30px 80px
}

#accountPage #importPanel table tr {
	line-height: 30px;
}

#accountPage #importPanel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
	<table id="rateTable" >
		<tr>
			<td width="30%" align="right">公司代码:</td>
			<td width="70%"><input name="companyid" id="companyid" class="easyui-numberbox"  data-options="required:true"/></td>
		</tr>
		<tr>
			<td>支付方式代码:</td>
			<td>
			<select name="payid" id="payid" class="easyui-combobox" style="width: 132px;" editable="false">
	               <option value="ZZ12" selected="selected">ZZ12</option>  
		           <option value="ZZ13">ZZ13</option>
		           <option value="ZZ14">ZZ14</option>
             </select>
             </td>
		</tr>
		<tr>
			<td>收付账户号:</td>
			<td><input name="getnum" id="getnum" class="easyui-textbox" data-options="required:true" /></td>
		</tr>
		<tr>
			<td>银行账户号:</td>
			<td><input name="banknum" id="banknum"  class="easyui-textbox"  data-options="required:true"/></td>
		</tr>
		<tr>
			<td>银行名称:</td>
			<td><input name="bankname" id="bankname" class="easyui-textbox" data-options="required:true"/></td>
		</tr>
	</table>
</form>
	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="commissionaccount.save();"> <span style="font-size: 14px;">保
				存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="commissionaccount.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>