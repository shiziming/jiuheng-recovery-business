<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">

#showPanel{
	padding-left: 420px;
	padding-top: 20px;
}

#title{
	padding-left: 450px;
	padding-top: 150px;
}
#attention{
	padding-left: 430px;
}

</style>
	<div id='title' style="font-size: 40px; font-family: 宋体">欢迎修改密码</div>
	<div id='attention' style="font-size: 30px; font-family: 宋体">请注意保管您的密码！</div>
	<div id="showPanel" class="content" align="center" style="width: 300px; height: 100px">
		<form id="updatePassword" action="" method="post" >
		<table>
			<tr>
	    		<td>旧密码<span style="color:red">(*)</span>:</td>
	    		<td><input class="easyui-validatebox textbox  text pwd" id="oldPassword" type="password" name="oldPwd" data-options="required:true" style="width: 150px;height:20px"></input></td>
	    	</tr>
			<tr>
	    		<td>新密码<span style="color:red">(*)</span>:</td>
	    		<td><input class="easyui-validatebox textbox  text pwd" id="password" type="password" name="pwd" data-options="required:true" style="width: 150px;height:20px"></input></td>
	    	</tr>
	    	<tr>
	    		<td>新密码确认<span style="color:red">(*)</span>:</td>
	    		<td><input class="easyui-validatebox textbox  text pwd" id="newPassword" type="password" name="newPwd" data-options="required:true" style="width: 150px;height:20px"></input></td>
	    	</tr>
	    	<tr>
	    		<td></td>
	    		<td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()">修改密码</a>
	    	</tr>
		</table>
		</form>
	</div>
<script type="text/javascript">
	function submitForm(){
		var oldPassword=$('#oldPassword').val();
		var password=$('#password').val();
		var newPassword=$('#newPassword').val();
		if(null==oldPassword||''==oldPassword){
			$.messager.alert('提示','旧密码不能为空！');
			return false;
		}
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
				url:"${ctx}power/checkUpdatePassword?currtime=" + new Date(),
				type:'post',
				data:{'oldPassword':oldPassword,'password':password,'newPassword':newPassword},
				success:function(data){
					if(data==0){
						$.messager.alert('提示','修改密码成功！');
					}else if(data==1){
						$.messager.alert('消息提示','原密码不正确，请重新输入','error');
						
					}
					else{
						$.messager.alert('消息提示','未成功修改密码，请重新修改','error');
					}
					
				}
				
				
				
			});
			
		}else{
			$.messager.alert('消息提示',"新密码与确认密码输入不一致，请重新输入",'error');
		}
		
	}
</script>