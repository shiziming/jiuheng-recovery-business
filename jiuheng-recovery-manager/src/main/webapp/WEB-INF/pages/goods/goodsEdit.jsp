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
        <span>您正在编辑  <strong>${device.categoryPathName} >> ${device.brandName}</strong>  的设备</span>
    </div>
    <div>
        <label>
            型号
        </label>
        <input type="hidden" name="id" id="deviceId" value="${device.id}">
        <input type="hidden" name="categoryId" value="${device.categoryId}">
        <input type="hidden" name="brandId" value="${device.brandId}">
        <input type="text" name="model" value="${device.model}" class="easyui-validatebox" data-options="required:true,validType:['length[1,50]']">
    </div>

   <%-- <div>
        <label>
           保修时长
        </label>
       <input id="warrantyTime" name="warrantyTime" value="${device.warrantyTime}"  class="easyui-numberspinner" style="width:80px;" data-options="min:0,editable:true">天
    </div>

    <div>
        <label>
           厂商电话
        </label>
    <input class="easyui-textbox" id="supplierPhone" name="supplierPhone" value="${device.supplierPhone}"   data-options="prompt:'请输入正确的电话号码。',validType:'telNum'" />
    </div>
         <div>
        <label>
         管家商品id
        </label>
       <input type="text"  id="gjMasterGoodsId" name="gjMasterGoodsId" value="${device.gjMasterGoodsId}" class="easyui-numberbox"  data-options="validType:['length[14,14]'],precision:0">
    </div>--%>
    <div style="display: inline-block; ">
    <label>排序</label>
		<input type="text" value="${device.sequence}" name="sequence">&nbsp;&nbsp;&nbsp;<label style="width: 400px;text-align:left;">(填写排序数字，值越小排名越靠前，初始排序值为0)</label>
	</div>
    <div>
        <label>图标</label>
        <a class="easyui-linkbutton" id="device_upload_pic_btn" plain="true" iconCls="icon-add">传图</a>
        <input type="hidden" name="pic" value="${device.pic}" />
        <c:if test="${device.pic != null}">
            <div style="display: inline-block;">
                <img src="${uploadFilePath}${device.pic}" width="90" height="90">
                <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" id="delete_device_pic">删除</a>
            </div>
        </c:if>
    </div>

   <%-- <div>
        <input type="checkbox" value="1" <c:if test="${device.supportRepair ==1}">checked="checked" </c:if> name="supportRepair">是否支持维修&nbsp;&nbsp;&nbsp;
        <input type="checkbox" value="1" <c:if test="${device.supportRecycle==1}">checked="checked" </c:if>  name="supportRecycle">是否支持回收
    </div>--%>

    <c:forEach items="${device.attrs}" var="attr" varStatus="s">
        <c:if test="${(!s.first && lastName != attr.name)}">
            </div>
        </c:if>
        <c:if test="${lastName != attr.name}">
            <div class="editbox">
            <div style="border: 1px solid #95b8e7;"/>
            <label>${attr.name}</label>
            <div style="display: inline-block; ">
                <input type="hidden" value="${attr.id}" name="attrs.id">
                <input type="hidden" value="${attr.attributeId}" name="attrs.attributeId">
                <input type="text"  value="${attr.attributeValue}" name="attrs.attributeValue">
                <input type="checkbox" value="1" <c:if test="${attr.canChoose ==1}">checked="checked" </c:if> name="attrs.canChoose">前台用户可选
            </div>
                <%--<c:if test="${s.index==0}">--%>
                    <a class="easyui-linkbutton add_device_attribute add" plain="true" iconCls="icon-add"></a>
                <%--</c:if>--%>
            </div>
        </c:if>
        <c:if test="${lastName == attr.name}">
            <div class="editbox">
        <div style="display: block; margin-left: 52px;">
            <input type="hidden" value="${attr.id}" name="attrs.id">
            <input type="hidden" value="${attr.attributeId}" name="attrs.attributeId">
            <input type="text"  value="${attr.attributeValue}" name="attrs.attributeValue">
            <input type="checkbox" value="1" <c:if test="${attr.canChoose ==1}">checked="checked" </c:if> name="attrs.canChoose">前台用户可选
        </div>
                <c:if test="${s.index==0}">
                    <a class="easyui-linkbutton add_device_attribute add" plain="true" iconCls="icon-add"></a>
                </c:if>
            </div>
        </c:if>
        <%--<c:if test="${s.first || lastName != attr.name}">--%>
            <%--<a class="easyui-linkbutton add_device_attribute" plain="true" iconCls="icon-add"></a>--%>
        <%--</c:if>--%>
        <c:set var="lastName" property="lastName" scope="page" value="${attr.name}" />
    </c:forEach>
	<div style="border: 1px solid #95b8e7;"/>
    <%--<div style="display: block; margin-left: 80px;">--%>
    	<%--<input type="checkbox" value="0" <c:if test="${state ==1}">checked="checked" </c:if> name="repairState" id="state">仅支持寄修（选中后该型号只支持寄修，请设置支持寄修的维修中心）--%>
    <%--</div>--%>
    <%--<div style="display: block; margin-left: 80px;">--%>
    	 <%--<a href="javaScript:;" class="easyui-linkbutton" onclick="insertDerviceDiv();" id="insertDervice_but">支持维修中心管理</a>--%>
    <%--</div>--%>
    <style>
        .editbox{position:relative;width:100%;display:block}
        .editbox .add{position:absolute;top:8px;left:326px;}

    </style>
</form>
<script type="text/javascript">



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

        $("#device_upload_pic_btn").ajaxUpload({
            fileType:'pic',
            action:ctx+"/imgFileUpload",
            onComplete:function(file,response){
                alert(response.url);
                $("input:hidden[name=pic]").val(response.url);
                if($("input:hidden[name=pic]").siblings("img")[0] != undefined){
                    $("input:hidden[name=pic]").siblings("img").remove();
                }
                $('<img src="${uploadFilePath}'+ response.url+'" width="90" height="90">').insertAfter("input:hidden[name=pic]");
            }
        });

        $(".add_device_attribute").click(function(){
            var $this = $(this);
            var ele = $this.prev().clone();
            ele.children("[name='attrs.id']").val("");
            ele.children("[name='attrs.canChoose']").val("1");
            ele.children("[name='attrs.attributeValue']").val("");
            ele.css({display:"block","margin-left": 52}).append('<a iconcls="icon-remove" plain="true" class="easyui-linkbutton remove-device-attribute l-btn l-btn-small l-btn-plain" group="" id=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text l-btn-empty">&nbsp;</span><span class="l-btn-icon icon-remove">&nbsp;</span></span></a>');
            $this.parent().append(ele);
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

        $("#device_data_form [name='attrs.canChoose']").each(function(i, j){
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
</script>