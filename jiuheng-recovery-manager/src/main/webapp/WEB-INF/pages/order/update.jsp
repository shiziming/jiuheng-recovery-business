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
<form id="order_data_form" name="order_data_form" class="data_form" method="POST">
    <table>
        <tr></tr>
        <tr>
            <td width="8%" align="right">订单号：</td>
            <td width="30%">
                ${order.orderId}
                <input  type="hidden" name="orderId" value="${order.orderId}">
            </td>
            <td width="10%" align="right">订单状态：</td>
            <td width="30%">
                <select id="orderStatus" name="orderStatus" class="easyui-combobox" editable="false" style="width:150px;readonly:true">
                    <option value="0" <c:if test="${'0' eq order.status}">selected</c:if>>邮寄中</option>
                    <option value="1" <c:if test="${'1' eq order.status}">selected</c:if>>已完成</option>
                    <option value="2" <c:if test="${'2' eq order.status}">selected</c:if>>已下单</option>
                    <option value="3" <c:if test="${'3' eq order.status}">selected</c:if>>已退货</option>
                </select>
            </td>
        </tr>
        <tr></tr>
        <tr>
            <td width="5%" align="right">商品名称：</td>
            <td width="30%">${order.goodsName}
            </td>
            <td width="10%" align="right">回收方式：</td>
            <td width="30%">
                <select id="recoveryType" name="recoveryType" class="easyui-combobox" editable="false" style="width:150px;readonly:true">
                    <option value="1" <c:if test="${'1' eq order.recoveryType}">selected</c:if>>上门</option>
                    <option value="2" <c:if test="${'2' eq order.recoveryType}">selected</c:if>>邮寄</option>
                </select>
            </td>
        </tr>
        <tr></tr>
        <tr>
            <td width="5%" align="right">用户名称：</td>
            <td width="30%">
                <input  class="easyui-textbox" type="text" name="userName" value="${order.userName}" data-options="required:true">
                <input  type="hidden" name="userId" value="${order.userId}">
            </td>
            <td width="10%" align="right">用户电话：</td>
            <td width="30%"><input  class="easyui-numberbox" name="userPhone" value="${order.userPhone}" data-options="required:true"></td>
        </tr>
        <tr></tr>
        <tr>
            <td width="10%" align="right">省/市：</td>
            <td width="30%">
                <select id="province" class="easyui-combobox" name="province" editable="false" style="width:150px;"data-options="required:true,valueField:'regionCode', textField:'regionName'">
                    <c:forEach items="${provinces}" var="province">
                        <option ${order.province==province.regionCode?"selected='selected'":""} value="${province.regionCode}">${province.regionName}</option>
                    </c:forEach>
                </select>
                <input  type="hidden" name="addId" value="${order.addId}">
            </td>
            <td width="5%" align="right">市：</td>
            <td width="30%">
                <select id="city" class="easyui-combobox" name="city" editable="false" style="width:150px;"data-options="required:true,valueField:'regionCode', textField:'regionName'">
                    <c:forEach items="${citys}" var="city">
                        <option ${order.city==city.regionCode?"selected='selected'":""} value="${city.regionCode}">${city.regionName}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td width="10%" align="right">区/县：</td>
            <td width="30%">
                <select id="county" class="easyui-combobox" name="county" editable="false" style="width:150px;"data-options="required:true,valueField:'regionCode', textField:'regionName'">
                    <c:forEach items="${countys}" var="county">
                        <option ${order.district==county.regionCode?"selected='selected'":""} value="${county.regionCode}">${county.regionName}</option>
                    </c:forEach>
                </select>
            </td>
            <td width="10%" align="right">详细地址：</td>
            <td width="30%">
                <input  class="easyui-textbox" type="text" name="detailed" value="${order.detailed}" data-options="required:true">
            </td>
        </tr>
        <tr></tr>
        <tr>
            <td width="5%" align="right">顾客留言：</td>
            <td width="30%"><input  class="easyui-textbox" type="text" name="message" value="${order.message}"></td>
            <td width="10%" align="right">运费：</td>
            <td width="30%">
                <input  class="easyui-textbox" type="number" name="freightPrice" value="${order.freightPrice/100}" data-options="required:true">
            </td>
        </tr>
        <tr></tr>
        <tr>
            <td width="10%" align="right">估价金额：</td>
            <td width="30%">
                ${order.valuationPrice/100}
            </td>
            <td width="5%" align="right">成交金额：</td>
            <td width="30%"><input  class="easyui-textbox" type="number" name="dealPrice" value="${order.dealPrice/100}" data-options="required:true"></td>
        </tr>
        <tr></tr>
        <tr>
            <td width="5%" align="right">支付方式：</td>
            <td width="30%">
                <select id="payType" name="payType" class="easyui-combobox" editable="false" style="width:150px;readonly:true">
                    <option value="11" <c:if test="${'11' eq order.payType}">selected</c:if>>支付宝</option>
                    <option value="12" <c:if test="${'12' eq order.payType}">selected</c:if>>微信</option>
                    <option value="13" <c:if test="${'13' eq order.payType}">selected</c:if>>银联</option>
                    <option value="99" <c:if test="${'99' eq order.payType}">selected</c:if>>线下付款</option>
                </select>
            </td>
            <td width="10%" align="right">预约上门日期：</td>
            <td width="30%">
                <input id="onDoorTime" style="width:150px;"
                       placeholder="预约上门时间" class="easyui-datebox" name="onDoorTime" type="text" value="${order.onDoorTime}" data-options="required:true"/>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">

    $("#province").combobox({
        onChange: function (newprovinceId,oldprovinceId) {
            $.ajax({
                url: "region/getCitys?provinceId=" + newprovinceId,
                dataType: 'json',
                method: 'get',
                success: function (data) {
                    $("#city").combobox('clear');
                    $("#city").append("<option> </option>");
                    $("#city").combobox('loadData',data.body.citys);
                }
            });
        }
    });
    $("#city").combobox({
        onChange: function (newCityId,oldCityId) {
            $.ajax({
                url: "region/getCountys?cityId=" + newCityId,
                dataType: 'json',
                method: 'get',
                success: function (data) {
                    $("#county").combobox('clear');
                    $("#county").append("<option> </option>");
                    $("#county").combobox('loadData',data.body.countys);
                }
            });
        }
    });

</script>