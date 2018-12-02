<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tiany
  Date: 2014/12/10 0010
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="device_window">
<form id="device_search_form" name="device_search_form">
  <div>
    <span>分类</span>
    <select name="categoryId" class="easyui-combobox" data-options="editable:false">
      <option value="">全部</option>
      <c:forEach items="${categories}" var="cate">
        <option  <c:if test="${cate.fid == -1}">disabled="disabled"</c:if> value="${cate.id}"><c:if test="${cate.fid != -1}">——</c:if>${cate.name}</option>
      </c:forEach>
    </select>
    <span>品牌</span>
    <select name="brandId" class="easyui-combobox" data-options="editable:false">
      <option value="">全部</option>
      <c:forEach items="${brands}" var="brand">
        <option value="${brand.id}">${brand.name}</option>
      </c:forEach>
    </select>
    <span>状态</span>
    <select name="status" id="status" class="easyui-combobox" data-options="editable:false">
      <option value="-2">全部</option>
      <option value="1">启用</option>
      <option value="0">停用</option>
      <%--<option value="-1">删除</option>--%>
    </select>
    <span>设备型号：</span>
    <input type="text" name="model" />
    <a class="easyui-linkbutton" plain="true" id="device_search_btn" href="javascript:;" iconCls="icon-search">搜索</a>
    <a class="easyui-linkbutton" plain="true" id="device_add_btn" href="javascript:;" iconCls="icon-add">新增设备</a>
  </div>
</form>
<div id="device_data_div"></div>
<div id="device_dlg_div"></div>
<div id="device_Service_div"></div>
<div id="device_attr_search" class="easyui-panel"
     data-options="closed:true, cache:false,border:false"></div>
</div>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<script type="text/javascript" src="common/js/common/ajaxupload.js"></script>
<script type="text/javascript" src="common/js/common/uploadFile.js"></script>
<%--<script type="text/javascript" src="${ctx}/resources/easyui/jquery-1.9.0.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctx}/resources/easyui/easyui-lang-zh_CN.js"></script>--%>
<%--<script type="text/javascript" src="${ctx}/resources/easyui/jquery.easyui.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctx}/resources/js/content.js" ></script>--%>
<%--<script type="text/javascript" src="${ctx}/resources/js/function.js"></script>--%>
<script type="text/javascript">

  $(function(){
    $("#device_search_btn").click(loadDeviceList);

    $("#device_add_btn").click(function(){
        showBrandDialog(ctx+"/device/addDevice");
    });

    $("#device_data_div").datagrid({
      url : "goods/getGoodsList",
      pagination : true,
      fitColumns : true,
      singleSelect:true,
      pageSize:20,
      toolbar : "device_search_form",
      columns : [[
        {title : "ID", field :"id", align:"center", width:30},
        {title:"分类",field:"categoryPathName",width:100},
        {title :"品牌",field:"brandName", width:200},
        {title:"型号",field:"model",width:100},
        {title:"排序",field:"sequence",align:"center",width:50},
        {title:"操作",field:"ss", width:200,align:"center",formatter:function(val, row,indx){
          var link = null;
          if(row.status != -1) {
            link = '<a class="easyui-linkbutton" plain="true" href="javascript:editDevice();" iconCls="icon-edit">编辑</a> | ';
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:duplicateDevice();" iconCls="icon-edit">复制</a> | ';
            if(row.status == 0){
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:startDevice();" iconCls="icon-edit"><font color="red">启用</font></a> | ';
            }else{
              link += '<a class="easyui-linkbutton" plain="true" href="javascript:stopDevice();" iconCls="icon-edit">停用</a> | ';
            }
            link += '<a class="easyui-linkbutton" plain="true" href="javascript:deleteDevice();" iconCls="icon-view">删除</a> ';
            link += "<a class='easyui-linkbutton' plain='true' href='javaScript:openRecycleAttrEdit();' iconCls='icon-view'>回收属性设置</a> ";
          }

          return link;
        }}
      ]]
    });
  })

  function openRecycleAttrEdit(){
    var selected = $("#device_data_div").datagrid("getSelected");
    var url = "goods/recycle?id="+selected.id;
    var title=selected.brandName+selected.model+'回收属性设置';
    $.o2m.addTabIframe(url,title);
    /*$("#device_window").hide();
    $("#device_attr_search").panel({title:title, href:url});
    $("#device_attr_search").panel('open');*/
  }

  var showBrandDialog = function (url, id) {
    var title = id ? "修改设备" :"新增设备";

    $("#device_dlg_div").dialog({
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
          $.messager.progress();
          saveDevice();
        }
      },
        {
          text:"关闭",
          iconCls:"icon-cancel",
          handler:closeDevieDlg
        }]
    });
  };

  function saveDevice(){
    $("#device_data_form").form("submit",{
      url : "goods/saveGoods",
      onSubmit:function(param){
        renameDeviceAttributes();
        var isValid = $(this).form('validate');
 	   	var reg = new RegExp("^[0-9]*$");
	   	var supplierPhone =	$('#supplierPhone').val();
	    if (!isValid){
          $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
        }
        return isValid;	// 返回false终止表单提交

      },
      success:function(data){
        $.messager.progress('close');	// 如果提交成功则隐藏进度条
        data = $.parseJSON(data);
        if(data.result == true){
          $.messager.alert("提示","保存成功","info");
          reloadDeviceList();
          closeDevieDlg();
        }
        else {
          $.messager.alert("警告", "保存失败", "warning");
        }
      }
    });
    
  }

  function deleteDevice(){
    var selected = $("#device_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }

    $.messager.confirm("提示","确定删除这条记录？",function(r){
      if(r){
        var url = "goods/deleteGoods?id="+selected.id;
        $.post(url, null, function(data){
          if(data.result == true){
            $.messager.alert("提示","删除设备成功","info");
            reloadDeviceList();
          }
          else {
            $.messager.alert("提示", "删除设备失败", "info");
          }
        },"json");
      }
    });
  }

  function startDevice() {
    editStatus(1);
  }

  function stopDevice() {
    editStatus(0);
  }

  function editStatus(s) {
    var selected = $("#device_data_div").datagrid("getSelected");

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
        var url = "goods/editStatus?id="+selected.id + "&status=" + s;
        $.post(url, null, function(data){
          if(data.result == true){
            $.messager.alert("提示",op+"设备成功","info");
            reloadDeviceList();
          }
          else {
            $.messager.alert("提示", op+"设备失败", "info");
          }
        },"json");
      }
    });
  }

  function editDevice(){
    var selected = $("#device_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }

    var url = "goods/editGoods?id="+selected.id;
    showBrandDialog(url, selected.id);
  }

  function duplicateDevice(){
    var selected = $("#device_data_div").datagrid("getSelected");

    if(selected == null ) {
      $.messager.alert("提示","请选中一条记录" ,"info");
      return;
    }

    $.messager.confirm("提示", "确定复制设备信息吗？", function(r){
      if(r){
        $.post("goods/duplicateGoods?id="+selected.id , null ,function(data){
          if(data.result ==true){
            $.messager.alert("提示","复制成功", "info");
            reloadDeviceList();
          }else{
            $.messager.alert("提示","复制失败","info");
          }
        },"json");
      }
    });
  }

  function reloadDeviceList(){
    $("#device_data_div").datagrid("reload");
  }

  function loadDeviceList(){
    $("#device_data_div").datagrid("load", $("#device_search_form").serializeObject());
  }

  function closeDevieDlg(){
    $("#device_dlg_div").dialog("close");
  }

</script>