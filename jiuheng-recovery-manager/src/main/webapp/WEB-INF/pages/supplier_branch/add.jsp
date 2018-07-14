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
#supplier_branch #addPanel table {
	padding: 30px 80px
}

#supplier_branch #addPanel table tr {
	line-height: 30px;
}

#supplier_branch #addPanel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
	<table id="rateTable" >
		<tr>
			<td width="30%" align="right">销售组织:</td>
			<td width="70%"><input name="saleOrgCode" id="saleOrgCode" class="easyui-textbox"  data-options="required:true"/></td>
		</tr>
		<tr>
			<td>供应商编码:</td>
			<td>
			   <input name="supplierCode" id="supplierCode" class="easyui-textbox"  data-options="required:true"/>
             </td>
		</tr>
		<tr>
			<td>是否平台商:</td>
			<td>
			  <input name="platformFlag" value="1" id="platformFlag"  type="radio" />是
			  <input name="platformFlag" value="0" id="platformFlag"  type="radio"/>否
		</tr>
	</table>
</form>
	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="supplierbranch.save();"> <span style="font-size: 14px;">保
				存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="supplierbranch.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>