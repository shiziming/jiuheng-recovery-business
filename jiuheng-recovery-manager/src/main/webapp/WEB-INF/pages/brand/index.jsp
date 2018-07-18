<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/10 0010
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="brand_search_form" name="brand_search_form">
  <div>
    <span>品牌名称</span>
    <input type="text" class="text_sketch" name="name" />
    <span>状态</span>
    <select name="status" class="easyui-combobox" data-options="editable:false">
      <option value="-2">全部</option>
      <option value="1"  selected>启用</option>
      <option value="0">停用</option>
      <%--<option value="-1">删除</option>--%>
    </select>
    <a class="easyui-linkbutton" plain="true" id="brand_search_btn" href="javascript:;" iconCls="icon-search">搜索</a>
    <a class="easyui-linkbutton" plain="true" id="brand_add_btn" href="javascript:;" iconCls="icon-add">新增品牌</a>
  </div>
</form>
<div id="brand_data_div"></div>
<div id="brand_dialog_div"></div>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<%--
<script type="text/javascript" src="common/js/common/uploadFile.js"></script>
--%>
<script type="text/javascript">
  $(function(){
    $("#brand_search_btn").click(loadBrandList);

    $("#brand_add_btn").click(function(){
        showBrandDialog(ctx+"/brand/addBrand");
    });

    $("#brand_data_div").datagrid({
      url : "brand/getAllBranch",
      pagination : true,
      fitColumns : true,
      singleSelect:true,
        pageSize:50,
      toolbar : "brand_search_form",
      columns : [[
        {title : "ID", field :"id", align:"center", width:30},
        {title:"品牌名称",field:"name",width:200},
        {title:"拥有设备",field:"categories",width:400, align:"center",formatter:function(val, row, index){
          if(val){
            var cs = [];
            $(val).each(function(i, j){
              cs.push(j.categoryName);
            });

            return cs.join(",");
          }
        }},
        {title:"操作",field:"ss", width:200,align:"center",formatter:function(val, row,indx){
          var link = null;

          if (row.status != -1) {
            link = '<a class="easyui-linkbutton" plain="true" href="javascript:editBrand();" iconCls="icon-edit">编辑</a> | ';
            if (row.status == 0) {
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:startBrand();" iconCls="icon-edit"><font color=red>启用</font></a> | ';
            } else {
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:stopBrand();" iconCls="icon-edit">停用</a> | ';
            }
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:deleteBrand();" iconCls="icon-view">删除</a> ';
          }

          return link;
        }}
      ]]
    });
  })

  var showBrandDialog = function (url, id) {
    var title = id ? "修改品牌" :"新增品牌";
    $("#brand_dialog_div").dialog({
      title:title,
      width : 700,
      height : $.o2m.centerHeight,
      cache: false,
      modal : true,
      maximizable:true,
      resizable :true,
      href : url,
      buttons:[{
        text :"保存",
        iconCls:"icon-save",
        handler:function(){
          var namelength = $("#name").val();
          if(namelength.length<=0){
            $.messager.alert("提示","请填写品牌名！");
            return false;
          }
          if(namelength.length>20){
            $.messager.alert("提示","品牌名输入过长！");
            return false;
          }
          $.messager.progress();
          $("#brand_data_form").form("submit",{
            url : "brand/saveBrand",
            onSubmit:function(param){
              renameCategories();
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
                $.messager.alert("提示","保存成功","info");
                reloadBrandList();
                closeBrandDlg();
              }
              else {
//                $.messager.alert("提示","新增品牌保存成功","info");

                $.messager.alert("提示", "保存失败", "warning");
              }
            }
          });
        }
      },
        {
          text:"关闭",
          iconCls:"icon-cancel",
          handler:closeBrandDlg
        }]
    });
  };

  function deleteBrand(){
    var selected = $("#brand_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }

    $.messager.confirm("提示","确定删除这条记录？",function(r){
      if(r){
        var url = ctx +"/device/deleteBrand?id="+selected.id;
        $.post(url, null, function(data){
          if(data.result == 1){
            $.messager.alert("提示","删除品牌成功","info");
            reloadBrandList();
          }
          else {
            $.messager.alert("提示", "删除品牌失败", "info");
          }
        },"json");
      }
    });
  }

  function startBrand() {
    editStatus(1);
  }

  function stopBrand() {
    editStatus(0);
  }

  function editStatus(s) {
    var selected = $("#brand_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }
    var op = "";
    switch (s){
      case 0:
        op = "停用";break;
      case 1:
        op = "启用";break;
      default :
        return false;
    }

    $.messager.confirm("提示","确定"+op+"这条记录？",function(r){
      if(r){
        var url = ctx +"/device/editBrandStatus?id="+selected.id + "&status=" + s;
        $.post(url, null, function(data){
          if(data.result == 1){
            $.messager.alert("提示",op+"品牌成功","info");
            reloadBrandList();
          }
          else {
            $.messager.alert("提示", op+"品牌失败", "info");
          }
        },"json");
      }
    });
  }

  function editBrand(){
    var selected = $("#brand_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }
    var url = ctx +"/brand/editBrand?id="+selected.id;
    showBrandDialog(url, selected.id);
  }

  function reloadBrandList(){
    $("#brand_data_div").datagrid("reload");
  }

  function loadBrandList(){
    $("#brand_data_div").datagrid("load", $("#brand_search_form").serializeObject());
  }

  function closeBrandDlg(){
    $("#brand_dialog_div").dialog("close");
  }
</script>