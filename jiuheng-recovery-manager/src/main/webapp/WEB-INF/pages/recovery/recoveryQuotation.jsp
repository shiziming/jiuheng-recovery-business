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
    <script type="text/javascript" src="common/js/ckplayer/ckplayer.js" charset="utf-8"></script>
    <script type="text/javascript" src="common/js/ckplayer/offlights.js" charset="utf-8"></script>
    <script type="text/javascript" src="common/js/ckplayer/function.js" charset="utf-8"></script>
<form id="device_data_form" name="device_data_form" class="data_form" method="POST">
    <div>
        <select id="updateCategoryId" name="categoryId">
            <option value="">全部</option>
            <c:if test="${recycleQuotation.categoryId!=null}">
                <option selected="selected" value="${recycleQuotation.categoryId}"></option>
            </c:if>
            <c:forEach items="${categories.rows}" var="cate">
                <option value="${cate.id}" <c:if test="${cate.fid==-1}"> disabled="true" </c:if>
                        <c:if test="${categoryId == cate.id}">selected="selected" </c:if> pathname="${cate.pathName}">
                    <c:if test="${cate.fid != -1}">——</c:if> ${cate.name}</option>
            </c:forEach>
        </select>
        <%--<select id="brand_sel" name="brandId" class="easyui-combobox" data-options="editable:false,onSelect:function(rec){--%>
        <%--var brandId = $('#brand_sel').combobox('getValue');--%>
         <%--var url =ctx+ '/order/showDevice?brandId='+brandId;--%>
          <%--$('#device_sel').combobox('clear');--%>
          <%--if(brandId != 0){--%>
            <%--$('#device_sel').combobox('reload', url);--%>
          <%--}--%>

        <%--}">--%>
            <select id="updateBrandId" name="brandId" >
                <c:if test="${null != recycleQuotation.brandId}">
                    <option value="${recycleQuotation.brandId}"></option>
                </c:if>
            </select>
         <select id="updateDeviceId" name="deviceId" >
             <c:if test="${null != recycleQuotation.deviceId}">
                 <option value="${recycleQuotation.deviceId}"></option>
             </c:if>
         </select>
            <%--<option value="">全部</option>--%>
            <%--<c:forEach items="${brands}" var="brand">--%>
                <%--<option value="${brand.id}">${brand.name}</option>--%>
            <%--</c:forEach>--%>
        </select>
        <%--<input id="device_sel" class="easyui-combobox" name="deviceId" data-options="editable:false,valueField:'id',textField: 'model'  , loadFilter:function(data){--%>
        	<%--return data.deviceList}"/>--%>
        &nbsp;
        <input type="button" onclick="toload();" value="确定"/>
    </div>
    <br/>
    <div >
        <table>
           <%-- <tr>
                <td style="align:right;text-align: right"><span>回收最低基础价格：</span></td>
                <td style="align:left"><input <c:if test="${not empty cpId && cpId >0 }"> disabled="disabled" style="background: #C8C8C8" </c:if> type="text" onkeyup="clearNoNum(this)" id="minBasicPrice" class="verification" name="minBasicPrice" value="${recycleQuotation.minBasicPrice}"></td>
                <td style="align:left"><span>提示：服务商设置的基础价格不能低于回收最低基础价格。</span></td>
            </tr>--%>
            <tr>
            <input type="hidden" name="id" id="id" value="${recycleQuotation.id}">
                <td style="align:right;text-align: right"><span>基础价格：</span></td>
                <td style="align:left" ><input type="text" onkeyup="clearNoNum(this)" id="basicPrice" class="verification" name="basicPrice" value="${recycleQuotation.basicPrice}"></td>
                <td style="align:left"><span>提示：最终回收价会根据不同设备属性、功能、故障情况在基础价格上做计算。</span></td>
            </tr>
               <tr>
                   <td valign="top" style="align:right;text-align: right"><span>计算方式：</span></td>
                   <td style="align:left;text-align: left" colspan="2">
                      	 最终回收价=结果1-结果2
                       <div>结果1=基础价格[+|-]基础属性中的启用项</div>
                       <div>结果2=结果1 × (功能属性中的启用项 + 外观属性中的启用项）</div>
                   </td>
               </tr>

        </table>
    </div>
    <br/>
    <table style="width: 640px" class="bean">
        <tbody id="bean">

        </tbody>
    </table>
    <s:privilege ifAny="rec_quot_manage_edit">
    <div id="sub">
        <%--<input id="verificationId" type="button" onclick="verification()" value="保存"/>--%>
    </div>
    </s:privilege>
</div>
</form>
<script type="application/javascript">
    //金额输入验证
    function clearNoNum(obj) {
        obj.value = obj.value.replace(/[^\d.]/g, ""); //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
    }
    $(document).ready(function(){
        var categoryId = $("#updateCategoryId").val();
        var brandId = $("#updateBrandId").val();
        var deviceId = $("#updateDeviceId").val();
        if(deviceId!=null&&deviceId!=undefined){
            $.ajax({
                url:"recovery/getProduct?categoryId="+categoryId+"&brandId="+brandId+"&deviceId="+deviceId,
                dataType : 'json',
                method:'post',
                success : function(data) {
                    toload();
                    $("#updateCategoryId option").remove();
                    $("#updateBrandId option").remove();
                    $("#updateDeviceId option").remove();
                    $("#updateCategoryId").attr({disabled:"disabled"});
                    $("#updateBrandId").attr({disabled:"disabled"});
                    $("#updateDeviceId").attr({disabled:"disabled"});
                    $("#updateCategoryId").append("<option value="+categoryId+">"+data.category.name+"</option>");
                    $("#updateBrandId").append("<option value="+brandId+">"+data.brand.name+"</option>");
                    $("#updateDeviceId").append("<option value="+deviceId+">"+data.device.model+"</option>");
//                    for (var i=0;i<data.json.length;i++){
//                        $("#brandId").append("<option value="+data.json[i].id+">"+data.json[i].name+"</option>");
//                    }

                }
            });
        }
    });
    function verification(){
        $("#verificationId").attr("disabled","disabled");
        var myarr = new Array();
        var myarr1 = new Array();
        var myarr2 = new Array();
        var myarr3 = new Array();
        var flag=true;
        var flag1=true;
        var flag2=true;
        var flag3=true;
        var reg =new RegExp("^[0-9]*$");
        $(".verification").each(function () {
            if($(this).attr('attributeType')==1){
                myarr1.push($(this).val());
            }else if($(this).attr('attributeType')==2){
                myarr2.push($(this).val());
            }else if($(this).attr('attributeType')==3){
                myarr3.push($(this).val());
            }else{
                myarr.push($(this).val());
            }

        });
       for(var i=0;i<myarr1.length;i++){// 只支持正数，不支持小数
            if(myarr1[i]==""||myarr1[i]==null||myarr1[i]==undefined||myarr1[i]==''){
                flag1=false;
                break;
            }
            if(!reg.test(myarr1[i])){
                console.log(myarr1[i] +'不是数字');
                flag1=false;
                break;
            }
            if(myarr1[i]<0){
                console.log(myarr1[i]+"小于0");
                flag1=false;
                break;
            }
        }
        if(!flag1){
            $.messager.alert('警告','基础属性只支持输入整数数字!');
            $("#verificationId").removeAttr("disabled");
            return ;
        }
        for(var i=0;i<myarr2.length;i++){// 支持小数
            if(myarr2[i]==""||myarr2[i]==null||myarr2[i]==undefined||myarr2[i]==''){
                flag2=false;
                break;
            }
//            if(myarr2[i]!=0 && !reg.test(myarr2[i])){
//                console.log(myarr2[i] +'不是数字');
//                flag2=false;
//                break;
//            }
            if(myarr2[i]<0){
                console.log(myarr2[i]+"小于0");
                flag2=false;
                break;
            }
        }
        if(!flag2){
            $.messager.alert('警告','请输入功能异常的正确比例数字!');
            $("#verificationId").removeAttr("disabled");
            return ;
        }

        for(var i=0;i<myarr3.length;i++){
            if(myarr3[i]==""||myarr3[i]==null||myarr3[i]==undefined||myarr3[i]==''){
                flag3=false;
                break;
            }
//            //判断是否为数字
//            if(myarr3[i]!=0 && !reg.test(myarr3[i])){
//                console.log(myarr3[i] +'不是数字');
//                flag3=false;
//                break;
//            }
            //判断是否小于0
            if(myarr3[i]<0){
                console.log(myarr3[i]);
                flag3=false;
                break;
            }
        }
        if(!flag3){
            $.messager.alert('警告','请输入外观/现象的正确比例数字!');
            $("#verificationId").removeAttr("disabled");
            return ;
        }
        for(var i=0;i<myarr.length;i++){
            if(myarr[i]==""||myarr[i]==null||myarr[i]==undefined||myarr[i]==''){
                flag=false;
                break;
            }
            //判断是否为数字
            if(!reg.test(myarr[i])){
                console.log(myarr[i] +'不是数字');
                flag=false;
                break;
            }
            //判断是否小于0
            if(myarr[i]<0){
                console.log(myarr[i]);
                flag=false;
                break;
            }
        }
        if(!flag){
            $.messager.alert('警告','请输入正确的数字!');
            $("#verificationId").removeAttr("disabled");
            return ;
        }
        //add start 20170818 验证其功能属性和外观属性百分比相加后不能超过1-100%
        if(checkPercent()){
            $.messager.alert('警告','功能异常属性和外观/现象属性百分比相加后不能超过100%.');
            $("#verificationId").removeAttr("disabled");
            return ;
        }
//        // 基础价格+-基础属性金额 >=0
//        var basePrice = $("#basicPrice").val();
//        var baseItems = $("input[attributeType='1']");//基础属性
//        var baseCountPrice = 0;
//        baseItems.each(function (index, ele) {
//            var op = $(this).parent().prev().children().val();
//            if(Number(op)==1){
//                baseCountPrice = baseCountPrice + Number($(this).val());
//            }else if(Number(op)==2){
//                baseCountPrice = baseCountPrice - Number($(this).val());
//            }
//        });
//        console.log("基础价格:"+basePrice+";基础属性金额结果:"+baseCountPrice);
//        if(Number(basePrice) + baseCountPrice<0){
//            $.messager.alert('警告','基础价格[+|-]基础属性的金额其结果不能为负数.');
//            $("#verificationId").removeAttr("disabled");
//            return ;
//        }
        //add end 20170818
        saveQuotation();
    }
    $("#updateCategoryId").change(function () {

        var categoryId = $("#updateCategoryId").val();
        $("#updateBrandId option").remove()
        $("#updateDeviceId option").remove()
        $.ajax({
            url:"brand/getBranchByCategoryId?id="+categoryId,
            dataType : 'json',
            method:'post',
            success : function(data) {
                $("#updateBrandId option").remove();
                for (var i=0;i<data.rows.length;i++){
                    $("#updateBrandId").append("<option value="+data.rows[i].id+">"+data.rows[i].name+"</option>");
                }
            }
        });
    });
    $("#updateBrandId").change(function () {
        var brandId = $('#updateBrandId').val();
        var categoryId = $("#updateCategoryId").val();
        $.ajax({
            url:'goods/getGoodsList?brandId='+brandId+"&categoryId="+categoryId,
            dataType : 'json',
            method:'post',
            success : function(data) {
                $("#updateDeviceId option").remove();
                for (var i=0;i<data.rows.length;i++){
                    $("#updateDeviceId").append("<option value="+data.rows[i].id+">"+data.rows[i].model+"</option>");
                }
            }
        });
    });
    function saveQuotation(){
        var id = $("#id").val();
        $("#device_data_form").form("submit",{url : "recovery/saveRecycleQuotation", onSubmit:function(param){
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
                $.messager.alert("提示","保存成功","info");//                data = $.parseJSON(data);
                <%--if(1 == 1){--%>
                    <%--$.messager.alert("提示","保存成功","info");--%>
                    <%--var url = ctx +"/device/recycle?id="+${device.id};--%>
                    <%--window.location.reload();--%>
                <%--}--%>
            }
        });
    }
    /**
     * 组拼回收项目
     * @param recycleQuotationItem
     * @returns {string}
     */
    function  generateRecycleQuotationItem(recycleQuotationItem,flag){
        var type = recycleQuotationItem.type;
        var str = "<tr  style='width: 620px'><td><strong>" + recycleQuotationItem.attributeName + "</strong></td><td>" + recycleQuotationItem.attributeValue + "</td><td>";

        str += "<select name='recycleQuotationItemList.type' id='"+recycleQuotationItem.id+"_"+recycleQuotationItem.attributeType+"'>";
        if(type == null){
            for(var i=1 ;i<=4 ;i++){
                var typeSign = "";
                if(recycleQuotationItem.attributeType == 3){
//                    外观/现象
                    switch (i){
//                        case 1:
//                            typeSign="+";
//                            break;
//                        case 2:
//                            typeSign="-";
//                            break;
//                        case 3:
//                            typeSign="=";
//                            break;
                        case 4:
                            typeSign="×";
                            break;
                        default:typeSign="";
                    }
                }else if(recycleQuotationItem.attributeType == 2){
//                    功能异常
                    switch (i){
//                        case 1:
//                            typeSign="+";
//                            break;
//                        case 2:
//                            typeSign="-";
//                            break;
//                        case 3:
//                            typeSign="=";
//                            break;
                        case 4:
                            typeSign="×";
                            break;
                        default:typeSign="";
                    }
                }else if(recycleQuotationItem.attributeType == 1){
//                    基础属性
                    switch (i){
                        case 1:
                            typeSign="+";
                            break;
                        case 2:
                            typeSign="-";
                            break;
                        case 3:
//                            typeSign="=";
                            break;
                        case 4:
                            break;
                        default:typeSign="";
                    }
                }
                if(typeSign==''){
                    continue;
                }
                str += "<option value='"+i+"'>"+typeSign+"</option>";
            }
            if(recycleQuotationItem.attributeType==2 || recycleQuotationItem.attributeType==3){
                str += "</select></td><td><input operatorCharact='"+recycleQuotationItem.id+"_"+recycleQuotationItem.attributeType+"' attributeType='"+recycleQuotationItem.attributeType+"' onkeyup='clearNoNum(this)' type='text' class='verification' name='recycleQuotationItemList.price' value=''/>%</td></tr>";
            }else{
                str += "</select></td><td><input operatorCharact='"+recycleQuotationItem.id+"_"+recycleQuotationItem.attributeType+"'  attributeType='"+recycleQuotationItem.attributeType+"' onkeyup='clearNoNum(this)' type='text' class='verification' name='recycleQuotationItemList.price' value=''/></td></tr>";
            }
        }else{
            for(var i=1 ;i<=4 ;i++){

                var typeSign = "";
                if(recycleQuotationItem.attributeType == 3){
//                    外观/现象
                    switch (i){
                        case 1:
//                            typeSign="+";
                            break;
                        case 2:
//                            typeSign="-";
                            break;
                        case 3:
//                            typeSign="=";
                            break;
                        case 4:
                            typeSign="×";
                            break
                        default:typeSign="";
                    }
                }else if(recycleQuotationItem.attributeType == 2){
//                    功能异常
                    switch (i){
                        case 1:
//                            typeSign="+";
                            break;
                        case 2:
//                            typeSign="-";
                            break;
                        case 3:
//                            typeSign="=";
                            break;
                        case 4:
                            typeSign="×";
                            break
                        default:typeSign="";
                    }
                }else if(recycleQuotationItem.attributeType == 1){
//                    基础属性
                    switch (i){
                        case 1:
                            typeSign="+";
                            break;
                        case 2:
                            typeSign="-";
                            break;
//                        case 3:typeSign="=";
                        case 4:
                            break;
                        default:typeSign="";
                    }
                }
                if(typeSign==''){
                    continue;
                }
                var selected = type == i ? "selected='selected'":"";
                if((recycleQuotationItem.attributeType == 2 || recycleQuotationItem.attributeType == 3) && i != 4 ){
                    str += "<option value='"+i+"' "+selected+" disabled>"+typeSign+"</option>";
                }else{
                    str += "<option value='"+i+"' "+selected+">"+typeSign+"</option>";
                }
            }
            if(recycleQuotationItem.attributeType==2 || recycleQuotationItem.attributeType==3){
                str += "</select></td><td><input operatorCharact='"+recycleQuotationItem.id+"_"+recycleQuotationItem.attributeType+"' attributeType='"+recycleQuotationItem.attributeType+"' onkeyup='clearNoNum(this)' type='text' class='verification' name='recycleQuotationItemList.price' value='"+recycleQuotationItem.price+"'/>%</td></tr>";
            }else{
                str += "</select></td><td><input operatorCharact='"+recycleQuotationItem.id+"_"+recycleQuotationItem.attributeType+"' attributeType='"+recycleQuotationItem.attributeType+"' onkeyup='clearNoNum(this)' type='text' class='verification' name='recycleQuotationItemList.price' value='"+recycleQuotationItem.price+"'/></td></tr>";
            }

        }
        console.log(str);
        return str;

    }
    function toload() {
        $("#bean br").remove();
        $("#bean tr").remove();
        $("#bean input").remove();
        $("#sub input").remove();
        var deviceId = $("#updateDeviceId").val();
        var quotationId=0;
        <c:if test="${!empty recycleQuotation.id}">
        quotationId=${recycleQuotation.id};
        </c:if>
        var url = "recovery/recycleQuotation?deviceId=" + deviceId+"&id="+quotationId;
        $.ajax({
            type: "POST",
            url: url,
            dataType: 'JSON',
            success: function (data) {
                $("#content").attr({display:"block"});
                var parse = data;
                var bean=0;
                var action=0;
                var appearance=0;
                if(parse.recycleQuotationItemList.length==0){
                    $.messager.alert('警告','请先设置回收属性');
                }else{
                    if(parse.recycleQuotation!=null){
                        $("#basicPrice").val(parse.recycleQuotation.basicPrice);
                        $("#id").val(parse.recycleQuotation.id);
                    }
                    var len = parse.recycleQuotationItemList.length;
                    for (var i=0;i<len;i++) {
                        var recycleQuotationItem = parse.recycleQuotationItemList[i];
                        var nextItem =recycleQuotationItem;
                        if(i < len-1){
                            nextItem = parse.recycleQuotationItemList[i+1];
                        }
                        var nextAttributeId = nextItem.attributeId;
                        var id = recycleQuotationItem.id;
                        if(id==null || id =='null' || id==undefined ){
                            id='';
                        }
                        var attributeId = recycleQuotationItem.attributeId;
                        var attributeValue = recycleQuotationItem.attributeValue;
                        var attributeValueId = recycleQuotationItem.attributeValueId ;
                        var attributeType = recycleQuotationItem.attributeType;
                        console.log("id:"+id+",attributeId:"+attributeId+",attributeValue:"+attributeValue+",attributeValueId:"+attributeValueId+",attributeType:"+attributeType+",nextAttributeId:"+nextAttributeId);
                        console.log(recycleQuotationItem);
                        $("#bean").append("<input type='hidden' value='"+ attributeId +"' name='recycleQuotationItemList.attributeId'>");
                        $("#bean").append("<input type='hidden' value='"+ id +"' name='recycleQuotationItemList.id'>");
                        $("#bean").append("<input type='hidden' value='"+ attributeValue +"' name='recycleQuotationItemList.attributeValue'>");
                        $("#bean").append("<input type='hidden' value='"+ attributeValueId +"' name='recycleQuotationItemList.attributeValueId'>");
                        //基本属性
                        if (attributeType == 1) {
                            if (bean == 0) {
                                $("#bean").append("<tr><td><h5>基本属性</h5></td></tr>");
                                bean = 1;
                            }
                        }else if (attributeType == 2) {//功能异常
                            if (action == 0) {
                                $("#bean").append("<tr><td><h5>功能异常</h5></td></tr>");
                                action = 1;
                            }
                        }else  if (attributeType == 3) {//外观/现象
                            if (appearance == 0) {
                                $("#bean").append("<tr><td><h5>外观/现象</h5></td></tr>");
                                appearance = 1;
                            }
                        }
                        var flag="";
                        if(i<(len-1)){
                            if(attributeId < nextAttributeId){
                                flag="<br/>";
                            }
                        }

                        $("#bean ").append(generateRecycleQuotationItem(recycleQuotationItem),flag);
                    }
                        $("#sub ").append(" <input id='verificationId' type='button' onclick='verification()' value='保存'/>");
                }
            }
        });
    }
    function renameDeviceAttributes(){
        $("#device_data_form [name='recycleQuotationItemList.attributeValue']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });

        $("#device_data_form [name='recycleQuotationItemList.attributeValueId']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });

        $("#device_data_form input:hidden[name='recycleQuotationItemList.attributeId']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });

        $("#device_data_form [name='recycleQuotationItemList.type']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });
        $("#device_data_form [name='recycleQuotationItemList.price']").each(function(i, j){
            this.name = this.name.replace(/^(\w+)(\[\d+\])*\.(\w+)$/gi, function(a, b, c, d){
                if(a){
                    return b + "["+ i +"]." + d;
                }
                else{
                    return a;
                }
            });
        });
        $("#device_data_form [name='recycleQuotationItemList.id']").each(function(i, j){
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
    $(function(){
        $(".bean").on("click","tr",function(){
             $(this).css("background","#3cb5ec").siblings("tr").css("background","white");
        });
    });

    /**
     * 检查功能异常和外观/现象 百分比不能超过1（100%）
     *
     * @returns {boolean}
     */
    function checkPercent() {

        var funItems = $("input[attributeType='2']");//功能异常
        var countFunItems = Number(0);
        funItems.each(function (index, ele) {
            countFunItems += Number($(this).val());
        });

        var facadeItems = $("input[attributeType='3']");//外观/现象
        var countFacadeItems = Number(0);
        facadeItems.each(function (index, ele) {
            countFacadeItems += Number($(this).val());
        });
        console.log("功能异常：countFunItems=" + countFunItems + ";外观/现象：countFacadeItems=" + countFacadeItems);

        if (countFunItems + countFacadeItems > 100) {
            return true;
        } else {
            return false;
        }
    }



</script>
