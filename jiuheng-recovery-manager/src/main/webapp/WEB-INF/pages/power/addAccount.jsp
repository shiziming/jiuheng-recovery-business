<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
	#introduce{
		padding-left: 90px;
		padding-top: 50px;
	}
	#addAccountWindow{
		padding-left: 120px;
		padding-top: 70px;
	}
</style>
<div id="addAccountWindow">
	<form id="addAccount" action="" method="post">
		<table>
			<tr>
				<td>账号:</td>
				<td>
					<input type="text" class="easyui-textbox" name="account" id="account"/>
				</td>
			</tr>
			<tr>
				<td>密码:</td>
				<td>
					<input type="text" class="easyui-textbox" name="password" id="password"/>
				</td>
			</tr>
			<tr>
				<td>使用人姓名:</td>
				<td>
					<input type="text" class="easyui-textbox" name="name" id="name"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="addAccount()">保存账号</a>
			</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
	function addAccount(){
		var account = $("#account").val();
		var password = $("#password").val();
		var name = $("#name").val();
		if(account==null ||account==''){
			$.messager.alert('警告','账号不能为空','warm');
			return false;
		}
		if(password==null ||password==''){
			$.messager.alert('警告','密码不能为空','warm');
			return false;
		}
		$.ajax({
			url:'power/addAccount?account='+account+'&password='+password+'&name='+name,
			type:'get',
			success:function(data){
				if(data.ok== true){
					$.messager.alert('提示','添加成功','',function(){
						$('#power_add_div').window('close')
					});
					$('#power_data_div').datagrid('load');
				}else if(data.ok==false){
					$.messager.alert('警告',data.error,'warm');
				}

			}
		});
	}
</script>