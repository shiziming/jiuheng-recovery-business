<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">

#introduce{
	padding-left: 60px;
	padding-top: 50px;
}
#listPanel{
	padding-left: 60px;
	padding-top: 20px;
}
</style>

<div  id="introduce"><span>当前修改用户为：${name},编号为：${code}</span></div>
	<div id="listPanel">
		<form id="updateUserPassword" action="" method="post">
		<input type="hidden" value="${code}" id="code">
		<table>
			<tr>
	    		<td>新密码<span style="color:red">(*)</span>:</td>
	    		<td><input class="easyui-validatebox textbox  text pwd" id="passworded" type="password" name="pwd" data-options="required:true" style="width: 150px;height:20px"></input></td>
	    	</tr>
	    	<tr>
	    		<td>新密码确认<span style="color:red">(*)</span>:</td>
	    		<td><input class="easyui-validatebox textbox  text pwd" id="newPassworded" type="password" name="newPwd" data-options="required:true" style="width: 150px;height:20px"></input></td>
	    	</tr>
	    	<tr>
	    		<td></td>
	    		<td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updatePassword()">修改密码</a>
	    	</tr>
		</table>
		</form>
	</div>
<script type="text/javascript">
	function init(){
		$('#listPanel').window('refresh');
	}
	function updatePassword(){
		var password=$('#passworded').val();
		var newPassword=$('#newPassworded').val();
		var code=$('#code').val();
		if(null==password||''==password){
			$.messager.alert('提示','新密码不能为空！');
			return false;
		}
		if(null==newPassword||''==newPassword){
			$.messager.alert('提示','确认密码不能为空！');
			return false;
		}
		if(password==newPassword){
			$.ajax({
				url:'${ctx}power/updateUserPassword?currtime=' + new Date(),
				data:{'password':password,'code':code},
				type:'post',
				success:function(data){
					if(1==data){
						$.messager.alert('提示','修改密码成功！','',function(){
							$('#openUpdateWindow').window('close')
						});
					}else{
						$.messager.alert('消息提示','未成功修改密码，请重新修改','error');
					}
				}
				
				
			});
			
		}else{
			$.messager.alert('消息提示',"新密码与确认密码输入不一致，请重新输入",'error');
		}
		
	}
</script>