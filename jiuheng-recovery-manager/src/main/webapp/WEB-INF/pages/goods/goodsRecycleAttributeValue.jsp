<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/resource.inc"%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/2/20
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        .editbox{position:relative;width:100%;display:block}
        .editbox .add{position:absolute;top:15px;left:300px;}
    </style>
</head>
<body>
<form id="device_data_form" name="device_data_form" class="data_form" method="POST">
    <span>您正在编辑  <strong>${device.categoryPathName} >> ${device.model}</strong> <c:if test="${type==1}">基本</c:if><c:if test="${type==2}">功能</c:if><c:if test="${type==3}">外观</c:if>的属性</span>
    <div><font color="red">如果该属性无值,则无需输入直接保存</font></div>
    <input type="hidden" name="id" id="deviceId" value="${device.id}">
    <input type="hidden" name="categoryId" value="${device.categoryId}">
    <input type="hidden" name="brandId" value="${device.brandId}">
    <br>

    <c:forEach items="${recycleAttributeList}" var="recycleAttribute" varStatus="x">
        <div class="editbox">
            <c:if test="${x.index!=0}">
                <hr style="height: 1px;width: 250px;float: left">
                <br/>
            </c:if>
            <b>${recycleAttribute.name}</b>
            <br/>
            <c:if test="${empty recycleAttribute.goodsRecycleAttributeValueList}">
                <div>
                    <input type="hidden" value="${recycleAttribute.id}" name="attrs.attributeId">
                    <input type="hidden" value="" name="attrs.id">
                    <input type="hidden" value="${type}" name="attrs.attributeType">
                    <input type="text" style="width: 250px;" value="" name="attrs.attributeValue">
                </div>
                <a class="easyui-linkbutton add_device_attribute add" plain="true" iconCls="icon-add" attribute_id="${recycleAttribute.id}" ></a>
            </c:if>
        </div>

        <c:if test="${not empty recycleAttribute.goodsRecycleAttributeValueList}">
            <div class="editbox">
                <c:forEach items="${recycleAttribute.goodsRecycleAttributeValueList}" var="recycleAttributeValue">
                    <%--<c:if test="${x.index!=0}">--%>
                    <%--<hr style="height: 1px;width: 250px;float: left">--%>
                    <%--<br/>--%>
                    <%--</c:if>--%>
                    <%--<br>--%>
                    <div>
                        <input type="hidden" value="${recycleAttribute.id}" name="attrs.attributeId">
                        <input type="hidden" value="${recycleAttributeValue.id}" name="attrs.id">
                        <input type="hidden" value="${recycleAttributeValue.attributeType}" name="attrs.attributeType">
                        <input  type="text" style="width: 250px;" value="${recycleAttributeValue.attributeValue}" name="attrs.attributeValue">
                        <a class="easyui-linkbutton" iconCls="icon-remove" id="delete" href="javascript:void(0)" onclick="deleteAttribute(${recycleAttributeValue.id})"></a>
                    </div>
                </c:forEach>
                <a class="easyui-linkbutton add_device_attribute add" plain="true" iconCls="icon-add"  attribute_id="${recycleAttribute.id}" ></a>
            </div>
        </c:if>
    </c:forEach>
    <br/>
    <input type="button" onclick="saveDevice()" value="提交"/>
</form>
<script type="text/javascript">
    function saveDevice(){
        $("#device_data_form").form("submit",{url : "saveRecycle", onSubmit:function(param){
            renameDeviceAttributes();
            var isValid = $(this).form('validate');
            if (!isValid){
                $.messager.progress('close');
                // 如果表单是无效的则隐藏进度条
            }
            return isValid;	// 返回false终止表单提交

        },
            success:function(data){
                $.messager.progress('close');
                // 如果提交成功则隐藏进度条
                if(1 == 1){
                    $.messager.alert("提示","保存成功","info");
                }
            }
        });
    }
    function insertDerviceDiv() {
        if($('#state').is(':checked')){
            var deviceid = $("#deviceId").val();
            showDeviceService(deviceid);
        }else{
            $.messager.alert("提示", "请选择仅支持寄修！");
        }
    }

    function insertOrderex() {
        var falge= false;
        var serviceIds = "";
        for(var idx= 0,j= '${listsize}'; idx < j;idx++){
            if($('#server_'+idx).is(':checked')){
                falge =true;
                serviceIds += $('#server_'+idx).val()+",";
            }
        }
        if(!falge){
            $.messager.alert("提示", "请选择维修中心！");
            return false;
        }
        var deviceid = $("#deviceId").val();
        var state = $("#state").val();
        $.messager.progress();
        $.ajax({
            url: 'insertDeviceServiceRepair',
            type: 'POST',
            data: {
                deviceId: deviceid,
                serviceIds: serviceIds,
                state: state
            },
            dataType: 'JSON',
            success: function (rdata) {
                if (rdata.status == 0) {
                    $.messager.show({
                        title: "提示",
                        msg: "添加成功"
                    });
                    closeDeviceService();
                }else {
                    $.messager.alert("提示", "添加失败!", "error");
                }
                $.messager.progress('close');
            }
        });
    }

    function showDeviceService (id) {
        $("#device_Service_div").dialog({
            title:"支持维修中心管理",
            width : 510,
            height : 330,
            cache: false,
            modal : true,
            maximizable:true,
            resizable :true,
            href :ctx +"/device/showDeviceServiceRepair?deviceId="+id,
            buttons:[{
                text :"保存",
                iconCls:"icon-save",
                handler:function(){
                    insertOrderex();
                }
            },
                {
                    text:"关闭",
                    iconCls:"icon-cancel",
                    handler:closeDeviceService
                }]
        });
    };


    $(function(){
        $("#delete_device_pic").click(function(){
            var $t = $(this);
            $.messager.confirm("提示", "确定删除上传的logo吗？",function(r){
                if(r){
                    $t.siblings("input:hidden[name=pic]").val("").siblings("img").remove();
                }
            });
        });

        $(".add_device_attribute").click(function(){
            var $this = $(this);
            var attributeId = $this.attr("attribute_id");
            var ele = $this.prev().clone();
            ele.children("[name='attrs.attributeId']").val(attributeId);
            ele.children("[name='attrs.attributeType']").val("${type}");
            ele.children("[name='attrs.id']").val("");
            ele.children("[name='attrs.attributeValue']").val("");
            ele.css({display:"block"}).append('<a iconcls="icon-remove" plain="true" class="easyui-linkbutton remove-device-attribute l-btn l-btn-small l-btn-plain Subtract" group="" id=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text l-btn-empty">&nbsp;</span><span class="l-btn-icon icon-remove">&nbsp;</span></span></a>');
            $this.parent().append(ele);
            ele.find("#delete").remove();
        });

        $("#device_data_form").delegate("a.remove-device-attribute", "click.removeDeivce", function(){
            var $this = $(this);
            $this.parent().remove();
        });
    })

    function renameDeviceAttributes(){
        $("#device_data_form [name='attrs.attributeValue']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });

        $("#device_data_form [name='attrs.id']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });

        $("#device_data_form input:hidden[name='attrs.attributeId']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });

        $("#device_data_form [name='attrs.attributeType']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });
    }

    function closeDeviceService(){
        $("#device_Service_div").dialog("close");
    }


    function deleteAttribute(id){
        $.messager.confirm('注意：', '确定要删除吗?删除后前台用户将不能选择该属性！', function(r){
            if (r){
                if(id!=""){
                    $.ajax({
                        url:"deleteRecycleAttributeValue",
                        method:"post",
                        data:{id:id},
                        dataType:"json",
                        success:function(data){
                            if(data.status!=1){
                                jQuery.messager.alert("提示：","删除失败!");
                            }else{
                                window.location.reload();
                            }
                        },
                        error:function(XMLHttpRequest){
                            jQuery.messager.alert("提示：","删除失败!");
                        }
                    });
                }else{
                    jQuery.messager.alert("提示：","删除失败!");
                }
            }
        });
    }
</script>
</body>
</html>
