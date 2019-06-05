<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/10 0010
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="device_category_search_form" name="device_category_search_form">
</form>
<table id="device_category_data_div"></table>
<div id="device_category_dlg_div"></div>
<script type="text/javascript" src="common/js/common/ajaxupload.js"></script>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<script type="text/javascript" src="common/js/common/uploadFile.js"></script>
<script type="text/javascript">
    $(function(){
        var dg, currentRow;
        dg = $("#device_category_data_div").datagrid({
            url : "category/getCategoryList",
            pagination : true,
            fitColumns : true,
            pageSize :20,
            singleSelect:true,
            toolbar : [{text:"新增分类",iconCls:"icon-add",handler:function(){
                if(currentRow != undefined){
                    dg.datagrid("cancelEdit", currentRow);
                }
                dg.datagrid("appendRow", {fid:-1,ss:"","categoryPic":null});
            }}],
            queryParams:$("#device_category_search_form").serializeObject(),
            columns : [[
                {title : "ID", field :"id", align:"center", width:30},
                {title:"分类名称",field:"name",width:100,formatter:function(val, row){
                    var pathId = row.pathId;
                    if(!pathId) return "";
                    var space="";
                    for(var i= 1,j=pathId.split(",").length;i<j; i++){
                        space += "&nbsp;&nbsp;";
                    }
                    return space + row.name;
                },editor:{type:"validatebox",options:{required:true}}
                },
                {title:"分类图标地址",field:"categoryPic",width:100, align:"center",formatter:function(val, row, idx){
                    if(val){
                        return '<img src="'+val+'" width="90px" height="90px" >'+
                                '<a class="easyui-linkbutton" onmouseover="uploadCategoryPic(this,'+idx+')" onmouseenter="uploadCategoryPic(this,'+idx+')" iconCls="icon-edit" href="javascript:;">编辑</a>  '+
                                '<a class="easyui-linkbutton" onclick="deleteCategoryPic('+idx+')" href="javascript:;">删除</a>';
                    }else{
                        return '<a class="easyui-linkbutton fileupload" onmouseover="uploadCategoryPic(this,'+idx+')" onmouseenter="uploadCategoryPic(this,'+idx+')" iconCls="icon-add" href="javascript:;">+添加图片</a>';
                    }
                }},
                {title:"排序",field:"sort",width:100,align:"center",editor:{type:"numberbox",options:{min:0,value:1}}
                },
                {title:"操作",field:"ss", width:200,align:"center",formatter:function(val, row,index){
                    var link = "";
                    if(row.editing){
                        link = '<a class="easyui-linkbutton" href="javascript:;" onclick="javascript:saveEdit('+index+');" iconCls="icon-save">保存</a>  ';
                        link += '<a class="easyui-linkbutton" href="javascript:;" onclick="javascript:cancelEdit('+index+');" iconCls="icon-cancel">取消</a>  ';
                    }else{
                        if(row.fid == -1){
                            link = '<a class="easyui-linkbutton" href="javascript:addSubDeviceCategory('+index+');" iconCls="icon-edit">添加子分类</a>  ';
                        }
                        if(row.fid!=-1){
                            link += '<a class="easyui-linkbutton" href="javascript:selectCategoryAttribute(1);" iconCls="icon-add">选择基本属性</a> ';
                            link += '<a class="easyui-linkbutton" href="javascript:selectCategoryAttribute(2);" iconCls="icon-remove">选择功能异常属性</a> ';
                            link += '<a class="easyui-linkbutton" href="javascript:selectCategoryAttribute(3);" iconCls="icon-remove">选择外观异常属性</a> ';
                            link += '<a class="easyui-linkbutton" href="javascript:deleteCategory();" iconCls="icon-remove">删除</a> ';
                        }
                    }

                    return link;
                }}
            ]],
            onDblClickRow: function (rowIndex, rowData) {
                //双击开启编辑行
                if (currentRow != undefined) {
                    dg.datagrid("cancelEdit", currentRow);
                }

                dg.datagrid("beginEdit", rowIndex);
                currentRow = rowIndex;
            },
            onBeforeEdit:function(index, row){
                row.editing=1;
                currentRow = index;
                flushRow(index);
            },
            onCancelEdit:function(index, row){
                row.editing=0;
                currentRow = undefined;
                flushRow(index);
            },
            onAfterEdit:function(index, row, changes){
                row.editing = 0;
                currentRow = undefined;
                flushRow(index);
                $.messager.progress();
                $.post("category/saveCategory", row, function(data){
                    $.messager.progress("close");
                    if(data.result=true){
                        $.messager.alert("提示", "保存成功", "info");
                        reloadDeviceCategory();
                    }else{
                        $.messager.alert("提示", "保存失败", "info");
                    }
                },"json");
            }
        });
    });

    function uploadCategoryPic(obj,index){
        $(obj).ajaxUpload({
            fileType: "pic",
            action: "imgFileUpload",
            onComplete: function (file, response) {
                if (response != null) {
                    $("#device_category_data_div").datagrid('updateRow',{
                        index: index,
                        row:{categoryPic:response.url}
                    });
                    $("#device_category_data_div").datagrid("beginEdit", index);
                } else {
                    $.messager.alert("图片上传", "图片上传出错，请重新上传！", "info");
                }
            }
        });

        $(obj).unbind("onmouseenter");
        $(obj).unbind("onmouseover");
    }

    var flushRow = function (index){
        $("#device_category_data_div").datagrid('updateRow',{
            index: index,
            row:{}
        });
    }

    function getRowByIndex(index){
        return $('#device_category_data_div').datagrid('getRows')[index];
    }

    function saveEdit(idx){
        $("#device_category_data_div").datagrid("acceptChanges", idx);
    }

    function cancelEdit(idx){
        $("#device_category_data_div").datagrid("cancelEdit", idx);
    }

    function addSubDeviceCategory(idx){
        if(idx != undefined){
            var row = getRowByIndex(idx);
            $("#device_category_data_div").datagrid("insertRow",{
                index :idx +1,
                row:{fid:row.id}
            });
        }
    }

    function deleteCategoryPic(index){
        if(index != undefined){
            $("#device_category_data_div").datagrid("updateRow",{
                index :index,
                row:{categoryPic:""}
            });
            $("#device_category_data_div").datagrid("beginEdit",index);
        }
    }

    function deleteCategory() {
        var selected = $("#device_category_data_div").datagrid("getSelected");
        if (selected == null) return false;

        var msg = null;
        if (selected.fid == -1){
            msg = "确定删除这个分类吗?<br>删除父分类，子分类下的所有分类同时会被删除！";
        }else{
            msg = "确定删除这个分类吗?";
        }
        if ($.messager.confirm("提示", msg, function (r) {
                    if (r) {
                        $.messager.progress();
                        $.post("attribute/deleteDeviceCategory?id=" + selected.id, null, function (data) {
                            if (data.result == true) {
                                $.messager.alert("提示", "删除成功", "info");
                                reloadDeviceCategory();
                            } else {
                                $.messager.alert("提示", "删除失败", "info");
                            }
                            $.messager.progress("close");
                        }, "json");

                    }
                }));
    }

    function selectCategoryAttribute(type){
        var selected = $("#device_category_data_div").datagrid("getSelected");
        if(selected == null ) return false;
        $("#device_category_dlg_div").dialog({
            title:"选择基本属性",
            width : 700,
            height : $.o2m.centerHeight,
            cache: false,
            modal : true,
            maximizable:true,
            resizable :true,
            href : "category/selectAttribute?categoryid="+selected.id+ "&type=" + type
        });
    }

    function reloadDeviceCategory(){
        $("#device_category_data_div").datagrid("reload");
    }

    function loadEngineer(){
        $("#device_category_data_div").datagrid("load", $("#device_category_search_form").serializeObject());
    }

    function closeCategoryDlg(){
        $("#device_category_dlg_div").dialog("close");
    }
</script>