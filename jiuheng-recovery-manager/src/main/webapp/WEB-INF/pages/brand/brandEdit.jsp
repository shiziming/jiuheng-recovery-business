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
<style type="text/css">
    .sub_category {
        display: inline-block;
        padding-left: 1px;
    }
    .x{
        padding-left: -5em;
    }
    .category {
        padding-left: 5em;
    }

    .category label {
        cursor: pointer;
    }
</style>
<form id="brand_data_form" name="brand_data_form" class="data_form" method="POST">
    <div>
        <label>
            品牌名
        </label>
        <input type="hidden" name="id" value="${brand.id}">
        <input type="text" name="name" id="name" value="${brand.name}" class="easyui-validatebox"
               data-options="required:true,validType:['length[1,20]']">
    </div>
    <%--<div>--%>
        <%--<label>图标</label>--%>
        <%--<a class="easyui-linkbutton" id="brand_upload_pic_btn" plain="true" iconCls="icon-add">上传logo</a>--%>
        <%--<input type="hidden" name="pic" value="${brand.pic}"/>--%>
        <%--<c:if test="${brand.pic != null}">--%>
            <%--<div>--%>
                <%--<img src="${uploadFilePath}${brand.pic}" width="90" height="90">--%>
                <%--<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" id="delete_brand_pic_btn">删除</a>--%>
            <%--</div>--%>
        <%--</c:if>--%>
    <%--</div>--%>
    <div>
        <label>拥有设备</label>
        <div class="category">
            <c:forEach items="${deviceCategories}" var="deviceCategory" varStatus="d">
                <div <c:if test="${deviceCategory.fid != -1}">class="sub_category" </c:if>class="x">
                    <c:if test="${deviceCategory.fid == -1}">
                    <span   for="category_checkbox_${deviceCategory.id}" ><b>${deviceCategory.name}</b></span>
                    </c:if>
                    <c:if test="${deviceCategory.fid != -1}">
                        <input id="category_checkbox_${deviceCategory.id}" type="checkbox" name="categories.categoryId"
                               fid="${deviceCategory.fid}" pathname="${deviceCategory.name}" value="${deviceCategory.id}">
                        <span   for="category_checkbox_${deviceCategory.id}" >${deviceCategory.name}</span>
                        <%--<input type="hidden" name="categories.categoryPathName" value="${deviceCategory.name}">--%>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</form>
<script type="text/javascript">
    var cat = eval("(" + '${json}' + ")")[0];
    for (var j = 0; j < cat.length; j++) {
        $("#category_checkbox_" + cat[j].categoryId).attr({checked: "checked"});
    }
    $(function () {
        $("#brand_data_form input:checkbox[name='categories.categoryId']").click(function () {
            var $this = $(this);
            //记录pathname
            if ($this.is(":checked")) {
                if ($("input:hidden[name='categories.categoryPathName'][value='" + $this.attr("pathname") + "']")[0] == undefined) {
                    var ipthtml = '<input type="hidden" name="categories.categoryPathName" value="' + $this.attr("pathname") + '" />';
                    $(ipthtml).insertAfter($this);
                }
            } else {
                $this.siblings("input:hidden[name='categories.categoryPathName']").remove();
            }
        });

        $("#delete_brand_pic_btn").click(function () {
            var $t = $(this);
            $.messager.confirm("提示", "确定删除上传的logo吗？", function (r) {
                if (r) {
                    $t.siblings("input:hidden[name=pic]").val("").siblings("img").remove();
                }
            });
        });

    })

    function renameCategories() {
        $("#brand_data_form input:checkbox[name='categories.categoryId']:checked").each(function (i, j) {
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function (a, b, c, d) {
                if (a) {
                    return b + "[" + i + "]." + d;
                }
                else {
                    return a;
                }
            });
        });

        $("#brand_data_form input:hidden[name='categories.categoryPathName']").each(function (i, j) {
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