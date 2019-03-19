<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/10 0010
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="power">
  <form id="power_search_form" name="power_search_form">
    <div>
      <span>账号</span>
      <input type="text" class="text_sketch" name="account" />
      <span>状态</span>
      <select name="status" class="easyui-combobox" data-options="editable:false">
        <option value="-2" selected="selected">全部</option>
        <option value="0">启用</option>
        <option value="-1">停用</option>
        <%--<option value="-1">删除</option>--%>
      </select>
      <a class="easyui-linkbutton" plain="true" id="power_search_btn" href="javascript:;" iconCls="icon-search">搜索</a>
      <a class="easyui-linkbutton" plain="true" id="power_add_btn" href="javascript:;" iconCls="icon-add">新增账号</a>
    </div>
  </form>
  <div id="power_data_div"></div>
  <div id="power_dialog_div"></div>
  <div id="power_add_div"></div>
  <!-- 根据职务编码查询权限-->
  <div id="tousersid"></div>
  <%--<div id="tousersid" title="用户所拥有权限" class="easyui-window"
       style="width:650px;height:500px;padding:10px 20px" closed="true" data-options="region:'center',border:false">
    <div id="but1" style="display: none;">
        <a href="javascript:void(0);" class="easyui-linkbutton" id="but"
           data-options="iconCls:'icon-add',plain:true"
           onclick="addfunction();">添加功能</a>
    </div>
    <table class="easyui-datagrid" id="dg2" data-options="border:false"></table>
  </div>--%>
  <!-- 添加功能页面 -->
  <div id="addFunctionView"></div>
</div>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<%--
<script type="text/javascript" src="common/js/common/uploadFile.js"></script>
--%>
<script type="text/javascript">
  $(function(){
    $("#power_search_btn").click(loadBrandList);

    $("#power_add_btn").click(function(){
        addAccountDialog("power/addAccountPanel");
    });

    var addAccountDialog = function (url) {
      var title = "新增账号";
      $("#power_add_div").dialog({
        title:title,
        width : 500,
        height : 300,
        cache: false,
        modal : true,
        maximizable:true,
        resizable :true,
        href : url
      });
    };

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
        {title:"用户名称",field:"userName",width:200},
        {title:"创建人",field:"createUserName",width:200},
        {title:"创建时间",field:"createTime",width:200},
        {title:"操作",field:"ss", width:200,align:"center",formatter:function(val, row,indx){
          var link = null;


            link = '<a class="easyui-linkbutton" plain="true" href="javascript:resetPassword();" iconCls="icon-edit">重置密码</a> | ';
            if (row.status == -1) {
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:startUser();" iconCls="icon-edit"><font color=red>启用</font></a> | ';
            } else {
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:stopUser();" iconCls="icon-edit">停用</a> | ';
            }
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:deleteUser();" iconCls="icon-view">删除</a> | ';
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:updatePower();" iconCls="icon-view">权限修改</a>';

          return link;
        }}
      ]]
    });
  })

  var showResetPasswordDialog = function (url) {
    $("#power_dialog_div").dialog({
      title:'重置密码',
      width : 400,
      height : 200,
      cache: false,
      modal : true,
      maximizable:true,
      resizable :true,
      href : url
    });
  };

  function deleteUser(){
    editStatus(-1);
    /*var selected = $("#power_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }

    $.messager.confirm("提示","确定删除当前用户？",function(r){
      if(r){
        var url = "brand/deleteBrand?id="+selected.id;
        $.post(url, null, function(data){
          if(data.result == true){
            $.messager.alert("提示","删除成功","info");
            reloadBrandList();
          }
          else {
            $.messager.alert("提示", "删除失败", "info");
          }
        },"json");
      }
    });*/
  }

  function startUser() {
    editStatus(0);
  }
  function stopUser() {
    editStatus(1);
  }

  function editStatus(s) {
    var selected = $("#power_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }
    var op = "";
    switch (s){
      case 1:
        op = "停用";break;
      case 0:
        op = "启用";break;
      case -1:
        op = "删除";break;
      default :
        return false;
    }

    $.messager.confirm("提示","确定"+op+"当前用户？",function(r){
      if(r){
        var url = "power/editUserStatus?userId="+selected.userId + "&status=" + s;
        $.post(url, null, function(data){
          if(data.result == true){
            $.messager.alert("提示",op+"成功","info");
            reloadBrandList();
          }
          else {
            $.messager.alert("提示", op+"失败", "info");
          }
        },"json");
      }
    });
  }

  function updatePower(){
    var selected = $("#power_data_div").datagrid("getSelected");
    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }
    $('#tousersid').dialog({
      title:"用户所拥有权限",
      width : 700,
      height : 500,
      cache: false,
      modal : true,
      maximizable:true,
      resizable :true,
      href : "power/functionShow?userId="+selected.userId+"&currtime=" + new Date()
    });

    /*$('#tousersid').window('open');
    $('#dg2').datagrid({
      url:'power/queryAllMenu?userId='+selected.xiu'gai+'&currtime='+ new Date(),
      title : "功能展示",
      striped : true,
      collapsible : true,
      autoRowHeight : true,
      remoteSort : false,
      idField : 'userId',
      rownumbers : true,
      fitColumns : true,
      nowrap : true,
      checkOnSelect : false,
      selectOnCheck : false,
      fit : true,
      toolbar:'#but',
      columns : [ [ {
        field : 'menuId',
        title : '菜单编码',
        width : 100,
        align : 'center'
      },{
        field : 'menuName',
        title : '菜单名称',
        width : 100,
        align : 'center'
      },{
        field : 'action',
        title : '操作',
        width : 40,
        align : 'center',
        formatter : function(value, row, index) {
          return '<a href="#" onclick="delPower(\'' + row.menuId+'\', \''+row.userId +'\');">删除</a>';
        }
      }
      ] ]

    });*/
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
  function closePowerDlg(){
    $("#power_add_div").dialog("close");
  }
  function delPower(menuId,userId) {
    if(menuId.length == 1){
      $.messager.confirm("提示", "确认删除此功能权限？\删除当前主菜单权限后，子菜单权限将全部删除！", function (r) {
      if (r) {
        type = 1;
        $.ajax({
          url: 'power/delPower?menuId=' + menuId + '&userId=' + userId + '&type=' + type
          + '&currtime=' + new Date(),
          type: 'get',
          success: function (data) {
            if (data.result == true) {
              $('#dg2').datagrid('load');
              $.messager.alert("提示", "删除成功", "info");
            } else {
              $.messager.alert("提示", "删除失败", "info");
            }
          }
        });
      }
    });
  }else{
      $.messager.confirm("提示", "确认删除此功能权限？", function (r) {
        if (r) {
          type = 2;
          $.ajax({
            url: 'power/delPower?menuId=' + menuId + '&userId=' + userId + '&type=' + type
            + '&currtime=' + new Date(),
            type: 'get',
            success: function (data) {
              if (data.result == true) {
                $('#dg2').datagrid('load');
                $.messager.alert("提示", "删除成功", "info");
              } else {
                $.messager.alert("提示", "删除失败", "info");
              }
            }
          });
        }
      });
    }
  }

  function addfunction(){
    $('#addFunctionView').window({
      width: 500,
      height: 300,
      modal: true,
      method:'post',
      href: "power/addFunction?currtime=" + new Date(),
      queryParams: {
        power:$('#GWDM_And_XTCXID').val()
      },
      title: "添加职位功能"
    });


  }
</script>