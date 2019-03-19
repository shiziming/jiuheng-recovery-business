<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/10 0010
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="power_data_form" name="power_data_form" class="data_form" method="POST">
  <div>
    <br>
    <span style="display:block; text-align:center;">您正在重置  <strong>${userAccount.account}</strong>  的密码</span>
    <input type="hidden" name="userId" id="userId" value="${userAccount.userId}">
  </div>
  <div>
    <table style="display:block; text-align:center;">
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr style="width: 100%;">
        <td style="width: 50%; text-align: right">设置密码:</td>
        <td style="width: 50%"><input class="easyui-validatebox textbox  text pwd" type="password" name="password" id="password"/></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td style="text-align: right">确认密码:</td>
        <td><input class="easyui-validatebox textbox  text pwd" type="password" name="resetPassword" id="resetPassword"/></td>
      </tr>
    </table>
  </div>
  <br>
  <div align="center">
    <a class="easyui-linkbutton" plain="true" id="rasetPassowrdSave" href="javascript:rasetPassowrdSave();" iconCls="icon-ok">保存</a>
    <a class="easyui-linkbutton" plain="true" id="rasetPassowrdCancel" href="javascript:rasetPassowrdCancel();" iconCls="icon-cancel">关闭</a>
  </div>
</form>
<script type="text/javascript">
function rasetPassowrdCancel() {
    $("#power_dialog_div").dialog("close");
}
function rasetPassowrdSave() {
    var password = $("#password").val();
    var resetPassword = $("#resetPassword").val();
    if(password.length<=0){
        $.messager.alert("提示","设置密码为空！");
        return false;
    }
    if(resetPassword.length>20){
        $.messager.alert("提示","确认密码为空！");
        return false;
    }
    if(password != resetPassword){
        $.messager.alert("提示","两次密码不一致，请重新设置！");
        return false;
    }
    $.messager.progress();
    $("#power_data_form").form("submit",{
        url : "power/updatePassword",
        onSubmit:function(param){
            var isValid = $(this).form('validate');
            if (!isValid){
                $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
            }
            return isValid;	// 返回false终止表单提交

        },
        success:function(data){
            parent.$.messager.progress('close');	// 如果提交成功则隐藏进度条
            data = $.parseJSON(data);
            if(data.result == true){
                $.messager.alert("提示","修改成功","info");
                reloadBrandList();
                closeBrandDlg();
            }
            else {
                $.messager.alert("提示", "修改失败", "warning");
            }
        }
    });
  function reloadBrandList(){
    $("#power_data_div").datagrid("reload");
  }

  function closeBrandDlg(){
    $("#power_dialog_div").dialog("close");
  }
}
</script>