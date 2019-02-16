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
<form id="device_data_form" name="device_data_form" class="data_form" method="POST">
    <div>
        <span>选择品牌</span>
        <select id="categoryId" name="categoryId">
            <option value="">全部</option>
            <c:forEach items="${categories}" var="cate">
                <option value="${cate.id}" <c:if test="${cate.fid==-1}"> disabled="true" </c:if>
                        <c:if test="${categoryId == cate.id}">selected="selected" </c:if> pathname="${cate.pathName}">
                    <c:if test="${cate.fid != -1}">——</c:if> ${cate.name}</option>
            </c:forEach>
        </select>
        <select id="brandId" name="brandId">
            <option value="">全部</option>
            <c:forEach items="${brands}" var="brand">
                <option value="${brand.id}"
                        <c:if test="${brandId == brand.id}">selected="selected" </c:if>>${brand.name}</option>
            </c:forEach>
        </select>
        <a class="easyui-linkbutton" plain="true" id="device_confirm_brand_btn" href="javascipt:;"
           iconCls="icon-search">确认品牌并添加设备</a>
    </div>
    <c:if test="${categoryId != null}">
        <div>
            <span>您正在添加<strong id="device_title_container"></strong>的设备</span>
        </div>
        <div>
            <label>
                型号
            </label>
            <input type="hidden" name="id" value="${device.id}">
            <input type="text" name="model" value="${device.model}" class="easyui-validatebox"
                   data-options="required:true,validType:['length[1,50]']">
        </div>
        <%--  <div>
              <label>
                  U8Code
              </label>
              <input type="hidden" name="id" value="${device.id}">
              <input type="text" name="u8Code" value="" class="easyui-validatebox" data-options="required:true,validType:['length[1,15]']">
          </div>--%>
        <div>
            <label>图标</label>
            <a class="easyui-linkbutton" id="device_upload_pic_btn" plain="true" iconCls="icon-add">传图</a>
            <input type="hidden" name="pic" value="${device.pic}"/>
            <c:if test="${device.pic != null}">
                <div style="display: inline-block">
                    <img src="${device.pic}" width="90" height="90">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" id="delete_device_pic">删除</a>
                </div>
            </c:if>
        </div>
        <c:forEach items="${attrs}" var="attr">
            <div style="border: 1px solid #95b8e7;">
                <label>${attr.name}</label>
                <div style="display: inline;">
                    <input type="hidden" value="${attr.id}" name="attrs.attributeId">
                    <input type="text" value="" name="attrs.attributeValue">
                    <input type="checkbox" value="1" name="attrs.canChoose" <%--checked="checked"--%>>前台用户可选
                </div>
                <a class="easyui-linkbutton add_device_attribute" plain="true" iconCls="icon-add"></a>
            </div>
        </c:forEach>
    </c:if>
</form>
<script type="text/javascript">
    $("#categoryId").change(function () {
        var categoryId = $("#categoryId").val();
        $.ajax({
            url:ctx+"/brand/getAllBranch?categoryId="+categoryId,
            dataType : 'json',
            method:'post',
            success : function(data) {
                $("#brandId option").remove();
                for (var i=0;i<data.rows.length;i++){
                $("#brandId").append("<option value="+data.rows[i].id+">"+data.rows[i].name+"</option>");
                }
            }
            });
    });
    $(function () {
        $("#device_confirm_brand_btn").click(function () {
            var cateId = $("#device_data_form select[name=categoryId] option:selected").val();
            var brandId = $("#device_data_form select[name=brandId] option:selected").val();
            if (cateId) {
                $("#device_dlg_div").dialog("refresh", ctx + "/goods/addDevice?categoryId=" + cateId + "&brandId=" + brandId);
            } else {
                $.messager.alert("提示", "请选择分类", "info");
            }
        });

        $("#delete_device_pic").click(function () {
            var $t = $(this);
            $.messager.confirm("提示", "确定删除上传的图标吗？", function (r) {
                if (r) {
                    $t.siblings("input:hidden[name=pic]").val("").siblings("img").remove();
                }
            });
        });

    })

    function renameDeviceAttributes() {
        $("#device_data_form [name='attrs.attributeValue']").each(function (i, j) {
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function (a, b, c, d) {
                if (a) {
                    return b + "[" + i + "]." + d;
                }
                else {
                    return a;

                }
            });
        });

        $("#device_data_form input:hidden[name='attrs.attributeId']").each(function (i, j) {
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function (a, b, c, d) {
                if (a) {
                    return b + "[" + i + "]." + d;
                }
                else {
                    return a;
                }
            });
        });

        $("#device_data_form [name='attrs.canChoose']").each(function (i, j) {
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function (a, b, c, d) {
                if (a) {
                    return b + "[" + i + "]." + d;
                }
                else {
                    return a;
                }
            });
        });
    }

</script>
<c:if test="${categoryId != null}">
    <script type="text/javascript">
        $(function () {

            $("#device_upload_pic_btn").ajaxUpload({
                fileType: 'pic',
                action: ctx + "/imgFileUpload",
                onComplete: function (file, response) {
                    $("input:hidden[name=pic]").val(response.url);
                    if ($("input:hidden[name=pic]").siblings("img")[0] != undefined) {
                        $("input:hidden[name=pic]").siblings("img").remove();
                    }
                    $('<img src="' + response.url + '" width="90" height="90">').insertAfter("input:hidden[name=pic]");
                }
            });

            $(".add_device_attribute").click(function () {
                var $this = $(this);
                var ele = $this.prev().clone();
                ele.css({
                    display: "block",
                    "margin-left": 80
                }).append('<a iconcls="icon-remove" plain="true" class="easyui-linkbutton remove-device-attribute l-btn l-btn-small l-btn-plain" group="" id=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text l-btn-empty">&nbsp;</span><span class="l-btn-icon icon-remove">&nbsp;</span></span></a>');
                $this.parent().append(ele);
            });

            $("#device_data_form").delegate("a.remove-device-attribute", "click.removeDeivce", function () {
                var $this = $(this);
                $this.parent().remove();
            });
        })
    </script>
</c:if>