<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/15 0015
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form name="select_attribute_search_form" id="select_attribute_search_form">
    属性名称：
    <input type="text" name="name">
    <a class="easyui-linkbutton" plain="true" iconCls="icon-search" id="select_attribute_search_btn">搜索</a>
    <a class="easyui-linkbutton" plain="true" iconCls="icon-add" id="select_attribute_save_btn">保存</a>
</form>
<div id="select_attribute_data_container"></div>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<script type="text/javascript" src="common/js/common/jslist.js"></script>
<script type="text/javascript">
    $(function () {
        var list = new jslist();

        $("#select_attribute_search_btn").click(loadSelectAttribut);

        $("#select_attribute_save_btn").click(function () {
            var checked = list.getJson();
            if (checked.key.length) {
                $.messager.progress();
                $.post("attribute/saveCategoryAttributes", {
                    categoryId: '${categoryId}',
                    attributes: checked.key,
                    type:${type}
                }, function (data) {
                    $.messager.progress("close");
                    if (data.result == true) {
                        $.messager.alert("提示", "分类属性保存成功", "info");
                    } else {
                        $.messager.alert("提示", "分类属性保存失败", "info");
                    }
                }, "json");
            } else {
                $.messager.alert("提示", "请选择属性", "info");
            }

        });

        $("#select_attribute_data_container").datagrid({
            url: "attribute/getAttributeList?type="+${type},
//            pagination: true,
            fitColumns: true,
            toolbar: "select_attribute_search_form",
            queryParams: {categoryId: ${categoryId}},
            columns: [[
                {field: "id", checkbox: true},
                {field: "name", title: "属性名称", width: "200"}
            ]],
            onSelect: function (index, row) {
                list.addItem(row.id, row.name);
            },
            onUnselect: function (index, row) {
                list.removeItem(row.id);
            },
            onSelectAll: function (rows) {
                $.each(rows, function (i, j) {
                    list.addItem(this.id, this.name);
                });
            },
            onUnselectAll: function (rows) {
                $.each(rows, function (i, j) {
                    list.removeItem(this.id);
                });
            },
            onLoadSuccess: function (data) {
                var items = list.getItems();
                var rows = data.rows;
                var exist = data.exist;
                $(rows).each(function (m,x) {
                    $(exist).each(function (i,n) {
                        if (x.id == n.id) {
                            $("#select_attribute_data_container").datagrid("checkRow", m);
                        }
                    });
                });
            }
        });
    })

    function loadSelectAttribut() {
        $("#select_attribute_data_container").datagrid("load", $("#select_attribute_search_form").serializeObject());
    }
</script>