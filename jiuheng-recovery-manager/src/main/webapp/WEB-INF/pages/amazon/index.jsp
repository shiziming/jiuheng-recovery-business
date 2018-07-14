<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="jobPowerPage">
	<div class="easyui-panel" id='anazomPage' title="查询条件" style="width: 100%; height: 150px; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
		<form id="uploadAnazomOrder" action="amazon/uploadAnazomOrder" method='post' enctype="multipart/form-data">
		<table>
			<tr>
				<td width="100px">上传亚马逊订单</td>
				<td width="200px" align="left">
				<input type="file" name="fileimport" id = "fileimportId" style="width:140px" onclick="$('#saveExport_btn').linkbutton('enable');" />
				<a href="#" class="easyui-linkbutton" id='saveExport_btn' iconCls="icon-save" onclick="saveExport(this);">上传</a>
				</td>
			</tr>
			
				
		</table>
		</form>
	</div>
</div>
<script type="text/javascript">

function saveExport(obj){
	//判断上传文件是否为excel
	var fileaa = $('input[name=fileimport]').val();
	if (fileaa.lastIndexOf('.xls') == "-1") {
		$.messager.alert('警告','上传的不是Excle文件,请重新选择！',"warning");
		return;
	}
	var curForm = $('#uploadAnazomOrder');
	curForm.form('submit',{
		success:function(data){
		    	var result = $.parseJSON(data);
		    	if(result!=null){
		    	    $.o2m.handleActionResult(result);
		    	}
		}
	});
	curForm.form('clear');
	
}
</script>