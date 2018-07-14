<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#introduce{
	padding-left: 90px;
	padding-top: 50px;
}
#addFunctionWindow{
	padding-left: 120px;
	padding-top: 20px;
}
</style>
<div  id="introduce"><span>当前职位为：${GWMC}<br/>当前系统为：${XTCXMC}</span></div>
	<div id="addFunctionWindow">
		<form id="addFunction" action="" method="post">
		<input type="hidden" value="${GWDM}" name="GWDM" id="GWDMId">
		<input type="hidden" value="${XTCXID}" name="XTCXID" id="XTCXIDId">
		<table>
	    	<tr>
	    		<td>模块名称:</td>
	    		<td>
					<input id="modelid" class="easyui-combobox" name="modelName" editable="false"  
    						data-options="valueField:'XTMKID',
    									  textField:'XTMKMC',
    									  url:'power/queryModelByXTCXID?systemId='+$('#XTCXIDId').val(), 
    									  onSelect: function(rec){
    									   	$('#fatherFunctionid').combobox('clear');
    									   	$('#sunFunctionid').combobox('clear');
								            var url = 'power/queryFatherFunctionByXTMKID?modelid='+rec.XTMKID;   
								            $('#fatherFunctionid').combobox('reload', url);   
								        }"/> 
   				</td>
	    	</tr>
	    	<tr>
	    		<td>功能名称:</td>
	    		<td>
	    			<input id="fatherFunctionid" class="easyui-combobox" editable="false"
	    			data-options="valueField:'XTGNID',
	    			 		 	  textField:'XTGNMC',
	    			 		 	  onSelect: function(rec){  
	    			 		 	  			$('#sunFunctionid').combobox('clear'); 
								            var url = 'power/querySunFunctionByXTMKID?fatherFunctionId='+rec.XTGNID;   
								            $('#sunFunctionid').combobox('reload', url);   
								        }
	    			 		 	  " />
	    		
	    	</tr>
	    	<tr>
	    		<td>权限名称:</td>
	    		<td>
	    			<input id="sunFunctionid" class="easyui-combobox" editable="false"
	    			data-options="valueField:'XTGNID',
	    			 		 	  textField:'XTGNMC'" />
	    		
	    	</tr>
	    	<tr>
	    		<td></td>
	    		<td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addFunction()">添加功能</a>
	    	</tr>
		</table>
		</form>
	</div>
<script type="text/javascript">
	function addFunction(){
		var sunFunctionId = $('#sunFunctionid').combobox("getValue");
		var fatherFunctionId = $('#fatherFunctionid').combobox("getValue");
		var modelid = $('#modelid').combobox("getValue");
		var GWDMId=$('#GWDMId').val();
		if(modelid==null ||modelid==''){
			$.messager.alert('警告','模块名称不能为空','warm');
			return false;
		}
		if(fatherFunctionId==null ||fatherFunctionId==''){
			$.messager.alert('警告','功能名称不能为空','warm');
			return false;
		}
		$.ajax({
			url:'power/addFunction',
			data:{'GWDMId':GWDMId,'sunFunctionId':sunFunctionId,'fatherFunctionId':fatherFunctionId},
			type:'post',
			success:function(data){
				if(data.code== 0){
					$.messager.alert('提示',data.msg,'',function(){
						$('#addFunctionView').window('close')
					});
					$('#dg2').datagrid('load');
				}else if(data.code== 1){
					$.messager.alert('警告',data.msg,'warm');
				}
				
			}
		});
	}
</script>