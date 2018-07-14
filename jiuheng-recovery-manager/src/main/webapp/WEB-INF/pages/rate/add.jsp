<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
</script>
<style>
#ratePage #importPanel table {
	padding: 30px 80px
}

#ratePage #importPanel table tr {
	line-height: 30px;
}

#ratePage #importPanel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
  <form id="searchForm">
	<table id="rateTable" >
		<tr>
			<td width="30%" align="right">支付方式代码:</td>
			<td width="70%">
			  <select name="payid" id="payid" class="easyui-combobox" style="width: 132px;" editable="false">
	               <option value="ZZ12" selected="selected">ZZ12</option>  
		           <option value="ZZ13">ZZ13</option>
		           <option value="ZZ14">ZZ14</option>
		           <option value="ZZZZ">ZZZZ</option>
             </select>
             </td>
		</tr>
		<tr>
			<td>开始日期:</td>
			<td><input name="startdate" id="startdate" class="easyui-datebox" data-options="required:true" editable="false"
			/>
			</td>
		</tr>
		<tr>
			<td>结束日期:</td>
			<td><input name="enddate" id="enddate" class="easyui-datebox" data-options="required:true" editable="false"
			/></td>
		</tr>
		<tr>
			<td>费率:</td>
			<td><input name="rate" id="rate" class="easyui-numberbox"  data-options="max:1,precision:4,required:true"/></td>
		</tr>
	</table>
</form>
	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="commissionrate.save();"> <span style="font-size: 14px;">保
				存</span>
		</a> 
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="commissionrate.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
		</a>
	</div>
</div>