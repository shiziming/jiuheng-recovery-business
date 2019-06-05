<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liubh
  Date: 2016/2/20
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <script type="text/javascript" src="common/js/common/function.js"></script>
    <script type="text/javascript" src="common/js/common/prototype.js"></script>
    <script type="text/javascript" src="common/js/common/admin.js"></script>
    <title></title>
<form id="device_search_form" name="device_search_form">
    <div>
        <span>分类</span>
        <select name="categoryId" id="categoryId">
            <option value="">全部</option>
            <%--<c:forEach items="${categories}" var="cate">--%>
                <%--<option value="${cate.id}"><c:if test="${cate.fid != -1}">——</c:if>${cate.name}</option>--%>
            <%--</c:forEach>--%>
        </select>
        <span>品牌</span>
        <select id="brandId" name="brandId">
        </select>
        <select id="deviceId" name="deviceId">
        </select>
        <span>状态</span>
        <select name="status" class="easyui-combobox" data-options="editable:false">
            <option value="-2" selected>全部</option>
            <option value="1">启用</option>
            <option value="0">停用</option>
        </select>
        <a class="easyui-linkbutton" plain="true" id="device_search_btn" href="javascript:;" onclick="loadDeviceList()" iconCls="icon-search">搜索</a>
        <s:privilege ifAny="rec_quot_manage_add">
        <a href="javaScript:" class="easyui-linkbutton" onclick="openSourceOrder()" iconCls="icon-add" plain="true" id="btnAdd" >新增报价</a>
        </s:privilege>
    </div>
</form>
<div id="data_div"></div>
<script type="application/javascript">
    $("#categoryId").change(function () {
        var categoryId = $("#categoryId").val();
        $.ajax({
            url:"brand/getBranchByCategoryId?id="+categoryId,
            dataType : 'json',
            method:'post',
            success : function(data) {
                $("#brandId option").remove();
                $("#brandId").append("<option> </option>");
                for (var i=0;i<data.rows.length;i++){
                    $("#brandId").append("<option value="+data.rows[i].id+">"+data.rows[i].name+"</option>");
                }
            }
        });
    });
    $("#brandId").change(function () {
        var brandId = $('#brandId').val();
        var categoryId = $('#categoryId').val();
        $.ajax({
            url:'goods/getGoodsList?',
            dataType : 'json',
            data:{
                brandId:brandId,
                categoryId:categoryId,
            },
            method:'post',
            success : function(data) {
                $("#deviceId option").remove();
                $("#deviceId").append("<option> </option>");
                for (var i=0;i<data.rows.length;i++){
                    $("#deviceId").append("<option  value="+data.rows[i].id+">"+data.rows[i].model+"</option>");
                }
            }
        });
    });
    function loadDeviceList(){
        $("#data_div").datagrid("load", $("#device_search_form").serializeObject());
    }
    function openSourceOrder(){
//        var selected = $("#device_data_div").datagrid("getSelected");
        var url = "recovery/editRecycleQuotation";
        var title='报价方案';
        try{
            $.o2m.addTabIframe(url,title);
        }catch(e){
            <%--processOrder('${info.sourceOrderId}');--%>
        }
    }
    function editJump(id){
        if(id!=null&&id!=undefined){
            var url = "recovery/editRecycleQuotation?id="+id;
            var title='报价方案'+id;
            $.o2m.addTabIframe(url,title);
        }else{
            alert('请选择');
        }



    }
  $(function(){
      var categories=new Array();
      var brands=new Array();
      var devices=new Array();
      var cpList=new Array();
      var device = "";
      $.ajax({
          url:"recovery/getProduct",
          dataType : 'json',
          method:'post',
          success : function(data) {
             for (var i=0;i<data.categories.rows.length;i++){
                  categories[data.categories.rows[i].id]=data.categories.rows[i].name;
                  $("#categoryId").append("<option value='"+data.categories.rows[i].id+"'>"+data.categories.rows[i].name+"</option>")
              }
              for (var i=0;i<data.brands.rows.length;i++){
                  brands[data.brands.rows[i].id]=data.brands.rows[i].name;
              }
              for (var i=0;i<data.devices.rows.length;i++){
                  devices[data.devices.rows[i].id]=data.devices.rows[i].model;
              }

              $("#data_div").datagrid({
                  url :"recovery/list",
                  pagination : true,
                  fitColumns : true,
                  pageSize:20,
                  singleSelect:true,
                  toolbar : "search_form",
                  columns : [[
                      {title : "ID", field :"id", align:"center", width:10},
                      {title : "deviceId", field :"deviceId", align:"center", width:10,hidden:true,formatter: function (value) {
                           device = devices[value];
                          return device;
                      }},
                      {title:"分类",field:"categoryId",width:50,
                          formatter: function (value) {
                              var category = categories[value];
                              return category;
                          }
                      },
                      {title:"品牌型号",field:"brandId",width:50,
                          formatter: function (value) {
                              var brand = brands[value];
                              brand+="/"+device;
                              return brand;
                          }
                      },
                      {title:"基础价格",field:"basicPrice",align:"left"},
                      {title:"状态",field:"status",align:"center",
                          formatter : function(value) {
                              return value==1?"<font color='darkgreen'>启用</font>":"<font color='red'>停用</font>";
                          }
                      },
                      {title:"操作",field:"op",width:50,align:"center",formatter:function(val, row,indx){
                          if(row.status!='admin'){
                              var link = "";
                              link = '<a class="easyui-linkbutton" plain="false" href="javascript:void(0)" onclick="javascript:editJump(\''+row.id+'\');" iconCls="icon-edit"><s:privilege ifAny="rec_quot_manage_edit">编辑</s:privilege><s:privilege ifNot="rec_quot_manage_edit">查看</s:privilege></a> ';
                              if(row.status==1){
                                  link += '<a class="easyui-linkbutton" plain="false" href="javascript:void(0)" onclick="javascript:stop(\''+row.id+'\');" iconCls="icon-edit">停用</a> ';
                              }else{
                                  link += '<a class="easyui-linkbutton" plain="false" href="javascript:void(0)" onclick="javascript:static(\''+row.id+'\');" iconCls="icon-edit">启用</a> ';
                              }
                              return link;
                          }else
                              return "";
                      }
                      }
                  ]]
              });
          }
      });


  });

    function static(id){
        $.ajax({
            url:'recovery/updateStatus?id='+id+'&status='+1,
            method:'post',
            success : function(data) {
                if(data.result == true){
                    $("#data_div").datagrid("reload");
                    $.messager.alert("提示","启用成功","info");//                data = $.parseJSON(data);
                }else{
                    $.messager.alert("提示","启用失败","info");//                data = $.parseJSON(data);
                }
            }
        });
    }
    function stop(id){
        $.ajax({
            url:'recovery/updateStatus?id='+id+'&status='+0,
            method:'post',
            success : function(data) {
                if(data.result == true){
                    $("#data_div").datagrid("reload");
                    $.messager.alert("提示","停用成功","info");//                data = $.parseJSON(data);
                }else{
                    $.messager.alert("提示","停用失败","info");//                data = $.parseJSON(data);
                }
            }
        });
    }


</script>
