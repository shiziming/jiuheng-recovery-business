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
    <span style="display:block; text-align:center;">您正在重置  <strong>${userAccount.account}</strong>  的密码</span>
    <input type="hidden" name="userId" id="userId" value="${userAccount.userId}">
  </div>
  <div>
    <table>
      <tr style="width: 100%">
        <td style="width: 50%">设置密码:</td>
        <td style="width: 50%"><input class="easyui-validatebox textbox  text pwd" type="password" name="password" /></td>
      </tr>
      <tr>
        <td>确认密码:</td>
        <td><input class="easyui-validatebox textbox  text pwd" type="password" name="resetPassword" /></td>
      </tr>
    </table>
  </div>
</form>
<script type="text/javascript">

</script>