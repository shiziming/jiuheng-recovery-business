<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajaxfileupload.js"></script>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
	});
	function importExcel(fn){
		$.o2m.showProgressing();
		
		  $.ajaxFileUpload (
              {
                  url: "<%=request.getContextPath()%>/common/import/${param.actionName}", //用于文件上传的服务器端请求地址
                  secureuri: false, //是否需要安全协议，一般设置为false
                  fileElementId: 'fileData', //文件上传域的ID
                  dataType: 'json',
                  type: 'post',
                  success: function (data, status)  //服务器成功响应处理函数
                  {
                	  $.o2m.closeProgressing();
                	  if($.o2m.handleActionResult(data)){
	                	  $("#importStatus").val(data.code);
                		  if(fn != undefined){
                			  fn(data.data);
                		  }else{
		                	  $("#importData").val(JSON.stringify(data.data));
                		  }
                		  parent.$.modalDialog.handler.dialog('close');
                	  }
                  }
              }
          )
	}
	
	function downLoadTemplate(){
		window.location.href="<%=request.getContextPath()%>/common/import/downLoadTemplate?templateName=${param.templateName}";
	}
	
</script>
<div id="excelImport">
<form id="form" method="post">
	<input type="hidden" value="" id="importData">
	<input type="hidden" value="" id="importStatus">
	<table class="table table-hover table-condensed" style="padding: 10px 20px 10px 20px;">
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td width="25%" align="center">请选择：</td>
			<td width="75%" align="center"><input  class="span2"  type="file" name="fileData" id="fileData"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr align="center">
			 <td colspan="2">
				 <a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-excel',plain:true" onclick="downLoadTemplate();">模板下载</a>
				 <a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok',plain:true" onclick="importExcel(${fnName});">导入</a>
				</td>
		</tr>
	</table>
</form>
</div>