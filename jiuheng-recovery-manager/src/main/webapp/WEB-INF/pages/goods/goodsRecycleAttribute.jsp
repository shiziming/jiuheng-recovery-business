<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: liuyihang
  Date: 2016/2/16
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%--<script type="text/javascript" src="${ctx}/resources/js/common/prototype.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/resources/js/common/uploadFile.js"></script>--%>
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/easyui/themes/default/easyui.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/easyui/themes/icon.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/easyui/demo.css">--%>
    <%--<script type="text/javascript" src="${ctx}/resources/easyui/jquery-1.9.0.min.js"></script>--%>
    <%--<script type="text/javascript" src="${ctx}/resources/easyui/jquery.easyui.min.js"></script>--%>
<script type="application/javascript">
</script>
</head>
<body>
<div style="margin:0px 0 10px 0;"></div>
<div  id="tt" class="easyui-tabs" style="width:1100px;height:800px">
    <div title="基本属性" style="padding:10px" id="bean">
        <iframe src="/jiuheng-recovery-manager/goods/goodsRecycleAttributeValue?id=${device.id}&type=1" width="100%" height="100%" style="border: 0px"></iframe>
    </div>
    <div title="功能属性" style="padding:10px" id="action">
        <iframe src="/jiuheng-recovery-manager/goods/goodsRecycleAttributeValue?id=${device.id}&type=2" width="100%" height="100%" style="border: 0px"></iframe>
    </div>
    <div title="外观属性"  style="padding:10px"  id="appearance">
        <iframe src="/jiuheng-recovery-manager/goods/goodsRecycleAttributeValue?id=${device.id}&type=3" width="100%" height="100%" style="border: 0px"></iframe>
    </div>
</div>
<input type="hidden" value="${device.id}" id="deviceId">
</body>
<script type="application/javascript">
//    $("#tt").tabs({
//        border:true,
//        onSelect:function(title,index){
//            var deviceId = $("#deviceId").val();
//            if(index==1){
//                var url = ctx +"/device/deviceRecycleAttributeValue?id="+deviceId+"&type="+2;
//                $("#action iframe").attr({src:url});
//            }
//            if(index==2){
//                var url = ctx +"/device/deviceRecycleAttributeValue?id="+deviceId+"&type="+3;
//                $("#appearance iframe").attr({src:url});
//            }
//        }
//    });

</script>
</html>
