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
<div  id="introduce"><span>当前账号为：${userAccount.account}</span></div>
<div id="addFunctionWindow">
	<form id="addFunction" action="" method="post">
		<input type="hidden" value="${userAccount.userId}" name="userId" id="userId">
		<table>
			<tr>
				<td>模块名称:</td>
				<td>
					<input id="modelid" class="easyui-combobox" name="modelName" editable="false"
						   data-options="valueField:'id',
    									  textField:'name',
    									  url:'power/queryModel',
    									  onSelect: function(rec){
    									   	$('#fatherFunctionid').combobox('clear');
    									   	$('#sunFunctionid').combobox('clear');
								            var url = 'power/queryFunctionByFatherId?modelid='+rec.id;
								            $('#fatherFunctionid').combobox('reload', url);
								        }"/>
				</td>
			</tr>
			<tr>
				<td>功能名称:</td>
				<td>
					<input id="fatherFunctionid" class="easyui-combobox" editable="false"
						   data-options="valueField:'id',
	    			 		 	  textField:'name'" />

			</tr>
			<%--<tr>
				<td>权限名称:</td>
				<td>
					<input id="sunFunctionid" class="easyui-combobox" editable="false"
						   data-options="valueField:'XTGNID',
	    			 		 	  textField:'XTGNMC'" />

			</tr>--%>
			<tr>
				<td></td>
				<td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addFunction()">添加功能</a>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
	function addFunction(){

		var fatherFunctionId = $('#fatherFunctionid').combobox("getValue");
		var modelid = $('#modelid').combobox("getValue");
		var userId=$('#userId').val();
		if(modelid==null ||modelid==''){
			$.messager.alert('警告','模块名称不能为空','warm');
			return false;
		}
		if(fatherFunctionId==null ||fatherFunctionId==''){
			$.messager.alert('警告','功能名称不能为空','warm');
			return false;
		}
		$.ajax({
			url:'power/addPower?modelid='+modelid+'&fatherFunctionId='+fatherFunctionId+'&userId='+userId,
			type:'get',
			success:function(data){
				if(data.ok== true){
					$.messager.alert('提示','添加成功','',function(){
						$('#addFunctionView').window('close')
					});
					$('#dg2').datagrid('load');
				}else if(data.ok==false){
					$.messager.alert('警告',data.error,'warm');
				}

			}
		});
	}
</script>