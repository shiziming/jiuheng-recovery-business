<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/10 0010
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form id="power_search_form" name="power_search_form">
  <div>
    <span>账号</span>
    <input type="text" class="text_sketch" name="account" />
    <span>状态</span>
    <select name="status" class="easyui-combobox" data-options="editable:false">
      <option value="-2">全部</option>
      <option value="1"  selected>启用</option>
      <option value="0">停用</option>
      <%--<option value="-1">删除</option>--%>
    </select>
    <a class="easyui-linkbutton" plain="true" id="power_search_btn" href="javascript:;" iconCls="icon-search">搜索</a>
    <a class="easyui-linkbutton" plain="true" id="power_add_btn" href="javascript:;" iconCls="icon-add">新增账号</a>
  </div>
</form>
<div id="power_data_div"></div>
<div id="power_dialog_div"></div>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<%--
<script type="text/javascript" src="common/js/common/uploadFile.js"></script>
--%>
<script type="text/javascript">
  $(function(){
    $("#power_search_btn").click(loadBrandList);

    $("#power_add_btn").click(function(){
        showBrandDialog("brand/addBrand");
    });

    $("#power_data_div").datagrid({
      url : "power/getPowers",
      pagination : true,
      fitColumns : true,
      singleSelect:true,
      pageSize:20,
      toolbar : "power_search_form",
      columns : [[
        {title : "ID", field :"userId", align:"center", width:30},
        {title:"账号",field:"account",width:200},
        {title:"密码",field:"password",width:200},
        {title:"操作",field:"ss", width:200,align:"center",formatter:function(val, row,indx){
          var link = null;

          if (row.status != -1) {
            link = '<a class="easyui-linkbutton" plain="true" href="javascript:resetPassword();" iconCls="icon-edit">重置密码</a> | ';
            if (row.status == 0) {
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:startBrand();" iconCls="icon-edit"><font color=red>启用</font></a> | ';
            } else {
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:stopBrand();" iconCls="icon-edit">停用</a> | ';
            }
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:deleteBrand();" iconCls="icon-view">删除</a> | ';
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:deleteBrand();" iconCls="icon-view">权限修改</a>';
          }

          return link;
        }}
      ]]
    });
  })

  var showResetPasswordDialog = function (url) {
    $("#power_dialog_div").dialog({
      title:'重置密码',
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
          var namelength = $("#account").val();
          if(namelength.length<=0){
            $.messager.alert("提示","请填写品牌名！");
            return false;
          }
          if(namelength.length>20){
            $.messager.alert("提示","品牌名输入过长！");
            return false;
          }
          $.messager.progress();
          $("#power_data_form").form("submit",{
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
    var selected = $("#power_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }

    $.messager.confirm("提示","确定删除这条记录？",function(r){
      if(r){
        var url = "brand/deleteBrand?id="+selected.id;
        $.post(url, null, function(data){
          if(data.result == true){
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
    var selected = $("#power_data_div").datagrid("getSelected");

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
        var url = "brand/editBrandStatus?id="+selected.id + "&status=" + s;
        $.post(url, null, function(data){
          if(data.result == true){
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

  function resetPassword(){
    var selected = $("#power_data_div").datagrid("getSelected");
    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }
    var url = "power/resetPassword?userId="+selected.userId;
    showResetPasswordDialog(url);
  }

  function reloadBrandList(){
    $("#power_data_div").datagrid("reload");
  }

  function loadBrandList(){
    $("#power_data_div").datagrid("load", $("#power_search_form").serializeObject());
  }

  function closeBrandDlg(){
    $("#power_dialog_div").dialog("close");
  }
</script>