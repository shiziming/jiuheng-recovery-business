<%--
  Created by IntelliJ IDEA.
  User: weicj
  Date: 2014/12/10
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/tmg/tag" %>
<%@include file="../order/orderStatus.jsp" %>
<script type="text/javascript" src="${ctx}/resources/js/common/prototype.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/uploadFile.js"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/offlights.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/resources/ckplayer/function.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<style type="text/css">
    .recycle_info {
    	width: 950px;
    	
    }
    .recycle_info td {
    	width: 475px;
    }
    .recycle_info td div label {
    	width: 300px;
    	display: inline-block;
    	padding-top: 5px;
    }
	.uploadimg{width:100px;height:100px;}
</style>
<script type="text/javascript" src="${ctx}/resources/js/function.js"></script>
<script type="text/javascript">

	$(function () {
		$("#datelay").append("<option value='-1'>上门日期</option>");
		var date = new Date();
		var Week = date.getDay();
		var Hours = date.getHours();
		var m = date.getMinutes();
		var day = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
		var a = 0, b = 14, w = 1;
		if (m < 10) {
			m = "0" + m;
		}
		var current_time = Hours + "." + m;

		if (current_time > 19) {
			a = 1, b = 8, Week = Week + 1;
		}
		for (i = a; i < b; i++) {
			var dat = new Date((+date) + i * 24 * 3600 * 1000);
			Week = Week + 1;
			if (Week % 7 == 0) {
				var week = "六";
			}
			if (Week % 7 == 1) {
				var week = "日";
			}
			if (Week % 7 == 2) {
				var week = "一";
			}
			if (Week % 7 == 3) {
				var week = "二";
			}
			if (Week % 7 == 4) {
				var week = "三";
			}
			if (Week % 7 == 5) {
				var week = "四";
			}
			if (Week % 7 == 6) {
				var week = "五";
			}
			var dataStr = dat.getFullYear() + "-";
			if (dat.getMonth() < 9) {
				dataStr += "0";
			}
			dataStr += (dat.getMonth() + 1) + "-";
			if (dat.getDate() < 10) {
				dataStr += "0";
			}
			dataStr += dat.getDate();
			if (i == 0) {
				$("#datelay").append("<option value='" + dataStr + "'>" + dat.getFullYear() + "-" + (dat.getMonth() + 1) + "-" + dat.getDate() + " 周" + week + "</option>");
			} else if (i == 1) {
				$("#datelay").append("<option value='" + dataStr + "'>" + dat.getFullYear() + "-" + (dat.getMonth() + 1) + "-" + dat.getDate() + " 周" + week + "</option>");
			} else {
				$("#datelay").append("<option value='" + dataStr + "'>" + dat.getFullYear() + "-" + (dat.getMonth() + 1) + "-" + dat.getDate() + " 周" + week + "</option>");
			}
		}
		$("#datelay").bind("change", function () {
			$("#beginTime").empty();
			$("#beginTime").append("<option value='-1' selected='selected'>开始时间</option>");
			$("#endTime").empty();
			$("#endTime").append("<option value='-1' selected='selected'>结束时间</option>");
			var date = new Date();
			var day = date.getDate();//当天
			var Hours = date.getHours();//当前小时数
			var selOption = $("#datelay").children("option:selected");
			var dateD =selOption.attr("value").split("-");//选择日期
			if(dateD[2] == day){
				var timeDate = Hours+1;
				for(; timeDate < 20 ; ++ timeDate) {
					$("#beginTime").append("<option value='"+timeDate+":00:00' >"+timeDate+":00</option>")
				}
			}else{
				var timeDate = 9;
				for(; timeDate < 20 ; ++ timeDate) {
					if(timeDate==9){
						$("#beginTime").append("<option value='0"+timeDate+":00:00' >0"+timeDate+":00</option>");
					}else{
						$("#beginTime").append("<option value='"+timeDate+":00:00' >"+timeDate+":00</option>");
					}
				}
			}
		});

		$("#beginTime").bind("change", function () {
			$("#endTime").empty();
			$("#endTime").append("<option value='-1' selected='selected'>结束时间</option>");
			var selOption = $("#beginTime").children("option:selected");
			var beginTime =selOption.attr("value");
			if(beginTime!="-1"){
				var timeNum = beginTime.split(":");
				var timeDate = parseInt(timeNum[0])+1;
				for(; timeDate < 21 ; ++ timeDate) {
					$("#endTime").append("<option value='"+timeDate+":00:00' >"+timeDate+":00</option>")
				}
			}
		});

		//获取市
		var ServiceCentercity = "${recycle.userExinfo.cityName}".split(" ");
		var ServiceCenterNew = new Array();
		var j = 0;
		for (var i = 0; i < ServiceCentercity.length; i++) {
			if (null != ServiceCentercity[i] && "" != ServiceCentercity[i].trim()) {
				ServiceCenterNew[j] = ServiceCentercity[i];
				j++;
			}
		}
		//  $("#serCenterNameDoor").text("【" + ServiceCenterNew[1] + "/上门清洗】");
		$("#serCenterNameDoor").text("【" +"${recycle.serCenterName}"+ "/上门清洗】");
//        $("#serCenterName").text("【" + ServiceCenterNew[1] + "/到店清洗】");

		/**增加客户修改时间*/
		$("#repairForm").form({
			url: "updateOrderOnsiteRepair",
			onSubmit: function (param) {
				if($("#datelay").children("option:selected").val()!=-1 ){
					if($("#beginTime").children("option:selected").val()!=-1 ){
						if ($("#endTime").children("option:selected").val()!=-1){
							param.startDate = $("#datelay").children("option:selected").val() + ' ' + $("#beginTime").children("option:selected").val();
							param.endDate = $("#datelay").children("option:selected").val() + ' ' + $("#endTime").children("option:selected").val();
							return true;
						}else{
							$.messager.alert("提示", "请选择结束时间!");
							return false;
						}
					}else{
						$.messager.alert("提示", "请选择开始时间!");
						return false;
					}
				}else{
					$.messager.alert("提示", "请选择上门日期!");
					return false;
				}
			},
			success: function (data) {
				$.messager.progress("close");
				data = $.parseJSON(data);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "修改上门时间成功!"
					});
					$("#updateOrderOnsiteRepairDiv").dialog("close");
					parent.showOrderInfo("${recycle.id}");
				} else {
					$.messager.alert("提示", "服务器发送异常错误,请联系系统管理员!", "error");
				}
			}
		});

		$("#updateOrderExForm").form({
			url: "updateOrderEx",
			onSubmit: function () {
			},
			success: function (data) {
				$.messager.progress("close");
				data = $.parseJSON(data);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "快递单号修改成功!"
					});
					$("#updateOrderExDiv").dialog("close");
					parent.showOrderInfo("${recycle.id}");
				} else {
					$.messager.alert("提示", "服务器发送异常错误,请联系系统管理员!", "error");
				}
			}
	});
		$("#cityToorByEng").combobox({
			valueField: 'id',
			textField: 'name',
			url: ctx + '/engineer/getServiceCenter.json',
			editable: false,
			loadFilter: function (data) {
				return data.rows;
			}, onSelect: function (data) {
				$('#startToorRepairEquipment').combobox('clear');
				var url = ctx + '/engineer/getEngineeByServiceCenter.json?serviceCenterId=' + data.id + "&orderId=${recycle.id}";
				$('#startToorRepairEquipment').combobox('reload', url);
			}
		});

		$("#startToorRepairEquipment").combobox({
			editable: false,
			valueField: 'id',
			textField: 'name',
			onSelect: function (record) {
				$("#startToorRepairEquipment").combobox("setText", record.name.split('<')[0]);
			},
			loadFilter: function (data) {
				return data.rows
			},
			onHidePanel: function () {
				try {
					$("#engineer_door_info_div_cls").panel("close");
				} catch (e) {
				}
				$(".engineer_door_info_div_cls").remove();
				$("#engineer_door_info_div_cls").remove();
			},
			onItemMouseover: function (value, obj) {
				$(".engineer_door_info_div_cls").remove();
				$("#engineer_door_info_div_cls").remove();
				var engineerDoorInfoDiv = window.document.createElement("div");
				engineerDoorInfoDiv.className = "selectTime engineer_door_info_div_cls";
				engineerDoorInfoDiv.id = 'engineer_door_info_div_cls';
				window.document.body.appendChild(engineerDoorInfoDiv);
				var $obj = $(obj);
				var position = $obj.offset();
				var left = position.left + 2 + $obj.width();
				var top = position.top;
				$(engineerDoorInfoDiv).panel({
					id: "engineer_door_info_div_cls",
					method: "post",
					queryParams: {
						orderId: "${recycle.id}",
						engineerId: value
					},
					href: window.ctx + "/recycle/showDoorInfo",
					cache: false,
					loadingMessage: "加载中....",
					noheader: true,
					left: left,
					top: top,
					cls: "position_absolute",
					width: 458
				});
			}
		});

		/*$("#cityByEng").combobox({
			valueField: 'id',
			textField: 'name',
			url: ctx + '/engineer/getEngineeCity.json',
			editable: false,
			loadFilter: function (data) {
				return data.rows;
			}, onSelect: function (data) {
				$('#startRepairEquipment').combobox('clear');
				var url = ctx + '/recycle/getEngineeByCity.json?cityId=' + data.id + "&orderId=${recycle.id}";

				$('#startRepairEquipment').combobox('reload', url);
			}
		});*/

		$("#cityUpdateDoorCity").combobox({
			valueField: 'id',
			textField: 'name',
			url: ctx + '/engineer/getServiceCenter.json',
			editable: false,
			loadFilter: function (data) {
				return data.rows;
			}, onSelect: function (data) {
				$('#cityUpdateDoorEng').combobox('clear');
				var url = ctx + '/engineer/getEngineeByServiceCenter.json?serviceCenterId=' + data.id + "&orderId=${recycle.id}";
				$('#cityUpdateDoorEng').combobox('reload', url);

			}
		});

		$("#cityUpdateDoorEng").combobox({
			editable: false,
			valueField: 'id',
			textField: 'name',
			onSelect: function (record) {
				console && console.log(record.name);
				$("#cityUpdateDoorEng").combobox("setText", record.name.split('<')[0]);
			},
			loadFilter: function (data) {
				return data.rows
			},
			onHidePanel: function () {
				try {
					$("#engineer_door_info_div_cls").panel("close");
				} catch (e) {
				}
//                $(".engineer_door_info_div_cls").remove();
				$("#engineer_door_info_div_cls").remove();
			},
			onItemMouseover: function (value, obj) {
//                $(".engineer_door_info_div_cls").remove();
				$("#engineer_door_info_div_cls").remove();
				var engineerDoorInfoDiv = window.document.createElement("div");
				engineerDoorInfoDiv.className = "selectTime engineer_door_info_div_cls";
				engineerDoorInfoDiv.id = 'engineer_door_info_div_cls';
				window.document.body.appendChild(engineerDoorInfoDiv);
				var $obj = $(obj);
				var position = $obj.offset();
				var left = position.left + 2 + $obj.width();
				var top = position.top;
				$(engineerDoorInfoDiv).panel({
					id: "engineer_door_info_div_cls",
					method: "post",
					queryParams: {
						orderId: "${recycle.id}",
						engineerId: value
					},
					href: window.ctx + "/recycle/showDoorInfo",
					cache: false,
					loadingMessage: "加载中....",
					noheader: true,
					left: left,
					top: top,
					cls: "position_absolute",
					width: 458
				});
			}
		});

		$("#insertOrderExForm").form({
			url: "insertOrderEx",
			onSubmit: function () {
			},
			success: function (data) {
				$.messager.progress("close");
				data = $.parseJSON(data);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "快递单号添加成功!"
					});
					$("#insertOrderExDiv").dialog("close");
					parent.showOrderInfo("${recycle.id}");
				} else {
					$.messager.alert("提示", "服务器发送异常错误,请联系系统管理员!", "error");
				}
			}
		});
		getBankList();

		$("#updateOrderUser_form_").form({
			url: "updateOrderUser",
			onSubmit: function () {
				var isValid = $(this).form('validate');
				if (isValid) {
					$.messager.progress();
				}
				return isValid;
			},
			success: function (data) {
				$.messager.progress("close");
				data = $.parseJSON(data);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "成功修改用户信息!"
					});
					$("#updateOrderUserInfoDiv").dialog("close");
					parent.showOrderInfo("${recycle.id}");
					// $("#orderInfo").window("refresh");

					parent.showOrderInfo("${recycle.id}");
					//$("#orderInfo").window("refresh");
				} else {
					$.messager.alter("提示", "服务器发送异常错误,请联系系统管理员!", "error");
				}
			}
		});

		$("#updateOrder_form_").form({
			url: "updateOrderInfo",
			onSubmit: function () {
				var isValid = $(this).form('validate');
				if (isValid) {
					$.messager.progress();
				}
				return isValid;
			},
			success: function (data) {
				$.messager.progress("close");
				data = $.parseJSON(data);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "成功修改订单信息!"
					});
					$("#updateOrderInfoDiv").dialog("close");
					parent.showOrderInfo("${recycle.id}");
					// $("#orderInfo").window("refresh");
				} else {
					$.messager.alter("提示", "服务器发送异常错误,请联系系统管理员!", "error");
				}
			}
		});

		$('#orderType').combobox({
			valueField: "id",
			editable: false,
			textField: "text",
			data: [
//                {
//                id: 2,
//                text: "到店清洗",
//                selected: true
//            },
				{
					id: 1,
					text: "上门清洗",
					selected: true
				}],
			onChange: function (newValue, oldValue) {
				if (newValue == 1) {
					$("#orderStatus1").empty();
					$("#orderStatus1").append('<option value="1000" >下单成功,待审核</option>');
					$("#orderStatus1").append('<option value="1100" >已审核，待指派上门</option>');
					$("#orderStatus1").append('<option value="1300" >已指派，待确认方案并清洗</option>');
					$("#orderStatus1").append('<option value="1800" >清洗完成,待付款</option>');
					/*$("#orderStatus1").append('<option value="2300" >订单完成</option>');*/
					$("#orderStatus1").append('<option value="2301" >订单取消</option>');
					$("#orderStatus1").append('<option value="2500" >订单关闭</option>');
				} else if (newValue == 2){
					$("#orderStatus1").empty();
					$("#orderStatus1").append('<option value="1300" >已指派，待客户到店</option>');
					$("#orderStatus1").append('<option value="1800" >清洗完成,待付款</option>');
					/*$("#orderStatus1").append('<option value="2300" >订单完成</option>');*/
					$("#orderStatus1").append('<option value="2301" >订单取消</option>');
					$("#orderStatus1").append('<option value="2500" >订单关闭</option>');
				}
			}
		});


		$("#closeOrderDiv_form_").form({
			url: "closeOrder",
			onSubmit: function () {
				if ($.trim($("#closeOrderDiv_form_").children("[name='orderId']").val()) != '${recycle.id}') {
					$.messager.alert("提示", "提交订单ID错误,请联系系统开发人员!", "error");
					return false;
				}
				/*var val = $("#remarkMessage").val();
				 if (val.trim() == "") {
				 $.messager.alert("提示", "内容为空!", "error");
				 $.messager.progress('close');
				 return false;
				 }*/
				var isValid = $(this).form('validate');
				if (!isValid) {
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
					return isValid;	// 返回false终止表单提交
				}
			},
			success: function (data) {
				$.messager.progress("close");
				data = $.parseJSON(data);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "您已关闭该订单!"
					});
					$("#closeOrderDiv").dialog("close");
					parent.showOrderInfo("${recycle.id}");
				} else {
					$.messager.alert("提示", "服务器发送异常错误,请联系系统管理员!", "error");
				}
			}
		});
	});

</script>





<div id="order_info" style="width: 950px;background-color: #cccccc; margin-left: auto;margin-right: auto;padding-left: 20px;padding-bottom: 10px;" >
	<input type="hidden" id="recycleId" value="${recycle.id}"/>
	<table width="100%">
		<tr>
			<td style="width: 25%;height: 40px;">
	            <label style="line-height: 40px;">回收金额: ${recycle.priceTotal}</label>
	        </td>
	        <td style="width: 25%;height: 40px;">
	            <label style="line-height: 40px;">客户: ${recycle.userExinfo.userName}/${recycle.userExinfo.mobile}</label>
	        </td>
	    </tr>
	    <tr>
	        <td style="width: 25%;"><label style="line-height: 20px;">回收人: ${recycle.engineer.name}/${recycle.engineer.mobile}</label>
	        <s:privilege ifAny="tel_mobile">
				<c:if test="${recycle.engineer.name}!=null">
					<a href="javascript:;" onclick="call9(${recycle.engineer.mobile});" >+9拨打</a>
					<a href="javascript:;" onclick="call90(${recycle.engineer.mobile});" >+90拨打</a>
				</c:if>
			</s:privilege>
	        </td>
			<%--<td style="width: 25%;height: 40px;">
				下单时间:<fmt:formatDate value="${recycle.createTime}" pattern="yyyy-MM-dd  HH:mm"/>
			</td>--%>
			<td style="width: 25%;height: 40px;">
			<c:if test="${recycle.method==1}">
				<%--上门时间:<fmt:formatDate value="${recycle.orderOnsiteRepair.onsiteDate}" pattern="yyyy-MM-dd  HH:mm"/>--%>
					<label> 上门时间: ${recycle.orderOnsiteRepair.onsiteDate}  </label>
				<a href="javaScript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="updateOrderOnsiteRepair('${recycle.id}');">修改上门时间</a>
			</c:if>
			</td>
	    </tr>
    </table>
</div>

<div id="fillReason" style="display: none">
	<div id="fillReasonTextarea_div">
		<textarea id="fillReasonTextarea" class="" data-options="missingMessage:'请输入关闭订单原因',required:true" style="width: 380px;height: 100px;"></textarea>
	</div>
</div>




<div style="width: 950px;margin-top: 20px;background-color: #efefef;border: 1px #CCCCCC solid;margin-left: auto;margin-right: auto;padding-left: 20px;padding-bottom: 20px;">
	<div style="margin-top: 20px;">
		<c:if test="${recycle.status == refuseSuccess}">
			<%--<c:if test="${recycle.method==0 }">
			当前订单状态:<label style="font-weight: bold;">交易失败,待回寄</label>
			</c:if>--%>
			<%--<c:if test="${recycle.method!=0 }">--%>
				当前订单状态:<label style="font-weight: bold;">订单取消</label>
			<%--</c:if>--%>
		</c:if>
		<c:if test="${recycle.status == waitDistributeToCp || recycle.status == failDistributeToCp}">
			当前订单状态:<label style="font-weight: bold;">下单成功,待分配合作商！</label>
		</c:if>
		<c:if test="${recycle.status == pendingAudit || recycle.status == quickPendingAudit}">
			当前订单状态:<label style="font-weight: bold;">下单成功,待审核</label>
		</c:if>
		<c:if test="${recycle.status == hasAudit}">
			<c:if test="${recycle.method == 0}">
				当前订单状态:<label style="font-weight: bold;">订单已核实,待收货</label>
			</c:if>
			<c:if test="${recycle.method == 1}">
				当前订单状态:<label style="font-weight: bold;">已审核，待指派上门回收</label>
			</c:if>
		</c:if>
		<c:if test="${recycle.status == engineersDoor}">
			<c:if test="${recycle.method == 0}">
				当前订单状态:<label style="font-weight: bold;">已指派,待评估</label>
			</c:if>
		</c:if>


		<c:if test="${recycle.status == harvest}">
			当前订单状态:<label style="font-weight: bold;">
			<c:if test="${recycle.method == 0}">
				已收货，待指派
			</c:if>
			<c:if test="${recycle.method == 1}">
				已审核，等待上门回收
			</c:if>
			</label>
		</c:if>
		<c:if test="${recycle.status == waitPayment}">
			当前订单状态:<label style="font-weight: bold;">
			<%--<c:if test="${recycle.method == 0}">--%>
				评估完成，待确支付
			<%--</c:if>
			<c:if test="${recycle.method == 1 || recycle.method == 2}">
				确认方案，待确认回收
			</c:if>--%></label>
		</c:if>
		<c:if test="${recycle.status == waitRepair}">
			当前订单状态:<label style="font-weight: bold;">已付款，等待回收</label>
		</c:if>
		<c:if test="${recycle.status == 1300}">
			<c:if test="${recycle.method == 1}">
				当前订单状态:<label style="font-weight: bold;">已安排上门，待评估并回收</label>
			</c:if>
			<c:if test="${recycle.method == 2}">
				当前订单状态:<label style="font-weight: bold;">客户到店回收，待评估并回收</label>
			</c:if>
		</c:if>
		<c:if test="${recycle.status == repair}">
			当前订单状态:<label style="font-weight: bold;">正在回收</label>
		</c:if>
		<c:if test="${recycle.status==repairCompletion || recycle.status == 2101}">
			当前订单状态:<label style="font-weight: bold;">待回寄设备</label>
		</c:if>
		<c:if test="${recycle.status == sendBack}">
			当前订单状态：<label style="font-weight: bold;">已回寄设备，待客户收货</label>
		</c:if>
		<c:if test="${recycle.status == success}">
			当前订单状态：<label style="font-weight: bold;">订单已完成！</label>
		</c:if>
		<c:if test="${recycle.status == close}">
			当前订单状态：<label style="font-weight: bold;">订单已关闭！</label>
		</c:if>
		<c:if test="${recycle.status == doorEepairFailure}">
			当前订单状态：<label style="font-weight: bold;">无法完成！</label>
		</c:if>
	</div>
	<div style="margin-top: 20px;">
<%--待审核--%>

 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
		<c:if test="${recycle.status == pendingAudit || recycle.status == quickPendingAudit}">
			<a class="easyui-linkbutton" id="audiRecycle">审核通过</a>

			<%--<s:privilege ifAny="order_cannot_complete">--%>
				<%--<a class="easyui-linkbutton" id="failRecycle">无法完成</a>--%>
			<%--</s:privilege>--%>
		<%-- 	<s:privilege ifAny="order_cannot_complete">
				<a class="easyui-linkbutton" id="failRecycle">无法完成</a>
			</s:privilege> --%>
			<%--<c:if test="${recycle.method != 0}">
				<a class="easyui-linkbutton"  style="width:70px;" id="updateSendRecycle">转邮寄</a>
			</c:if>--%>
		</c:if>
	</c:if>

	<%--审核通过--%>
	<c:if test="${recycle.status == hasAudit}">
		<c:if test="${recycle.method == 0}">
			<%--邮寄--%>
			<a class="easyui-linkbutton" id="confirmRecycle">确认收货</a>
		</c:if>
		<c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
		<c:if test="${recycle.method == 1}">
			<%--上门--%>
			<input id="cityToorByEng" type="text" value="维修中心" style="width:100Px">
			<input id="startToorRepairEquipment" style="width:180px;"/>
			<a class="easyui-linkbutton" onclick="
			<c:if test="${recycle.orderOnsiteRepair == null}">$.messager.alert('提示', '请修改上门时间,然后再指派工程师!','info', function(){updateOrderOnsiteRepair('${recycle.id}');});</c:if>
			<c:if test="${recycle.orderOnsiteRepair != null}">assignDoor('${recycle.id}');</c:if>">指派上门</a>
			<%--<a class="easyui-linkbutton"  style="width:70px;" id="updateSendRecycle">转邮寄</a>--%>
		</c:if>
		<%--<s:privilege ifAny="order_cannot_complete">--%>
			<%--<a class="easyui-linkbutton" id="failRecycle">无法完成</a>--%>
		<%--</s:privilege>--%>
		</c:if>
	<%-- 	<s:privilege ifAny="order_cannot_complete">
			<a class="easyui-linkbutton" id="failRecycle">无法完成</a>
		</s:privilege> --%>
	</c:if>

	<%--邮寄确认收货--%>
	<c:if test="${recycle.status == harvest }">
		<c:if test="${recycle.method == 0}">

			<input id="cityToorByEng" type="text" value="维修中心" style="width:100Px">
			<input id="startToorRepairEquipment" style="width:180px;"/>
			<a class="easyui-linkbutton" onclick="assignDoorRecycle('${recycle.id}');">指派工程师</a>
			<%--<s:privilege ifAny="order_cannot_complete">--%>
				<%--<a class="easyui-linkbutton" id="failRecycle">无法完成</a>--%>
			<%--</s:privilege>--%>
			<%-- <s:privilege ifAny="order_cannot_complete">
				<a class="easyui-linkbutton" id="failRecycle">无法完成</a>
			</s:privilege> --%>
		</c:if>
	</c:if>

	<%--待付款--%>
<c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
	<c:if test="${recycle.status == waitPayment }">
		<a class="easyui-linkbutton" id="successRecycle">完成回收</a>
		<%-- <s:privilege ifAny="order_cannot_complete">
			<a class="easyui-linkbutton" id="failRecycle">无法完成</a>
		</s:privilege> --%>
		<%--<s:privilege ifAny="order_cannot_complete">--%>
			<%--<a class="easyui-linkbutton" id="failRecycle">无法完成</a>--%>
		<%--</s:privilege>--%>
	</c:if>
</c:if>
	<c:if test="${recycle.status == 2101 || recycle.status == repairCompletion}">
		<c:if test="${recycle.method==0 }">
		<%--邮寄，回寄设备--%>
		<a class="easyui-linkbutton" id="returnDevice">回寄设备</a>
			</c:if>
		<%--<s:privilege ifAny="order_close">
			&lt;%&ndash;<a class="easyui-linkbutton"  style="width:70px;" id="closeRecycle">关闭订单</a>&ndash;%&gt;
			<a class="easyui-linkbutton"  style="width:70px;" id="failRecycle">无法完成</a>
		</s:privilege>--%>
	</c:if>

	<%--上门维修 维修失败,待客户核实--%>
	<c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
	<c:if test="${recycle.status == doorEepairFailure }">
	<%--<c:if test="${recycle.status == doorEepairFailure || recycle.status == 2301}">--%>
		<%--<s:privilege ifAny="order_confirm_fail">&lt;%&ndash;平台管理员才有最终确认失败的权限&ndash;%&gt;--%>
		<%--<a class="easyui-linkbutton"  style="width:70px;" id="realyfailRecycle">确认失败</a>--%>
		<%--</s:privilege>--%>
		<%--&lt;%&ndash;<a class="easyui-linkbutton" onclick="updateDoorEng('${recycle.id}');">重新指派</a>&ndash;%&gt;--%>

		<s:privilege ifAny="order_distribute_to_cp"><%--平台管理员才有分配服务商的权限--%>
			<a class="easyui-linkbutton" onclick="distributeToCp('${recycle.id}');">分配服务商</a>
		</s:privilege>

		<%--&lt;%&ndash;<c:if test="${recycle.method != 0}">--%>
			<%--<a class="easyui-linkbutton"  style="width:70px;" id="updateSendRecycle">转邮寄</a>--%>
		<%--</c:if>&ndash;%&gt;--%>
	</c:if>
	</c:if>
 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
	<%--上门维修:已指派工程师上门,待确认方案或等待客户上门,待确认方案 到店维修:已指派工程师,待客户到店--%>
		<c:if test="${recycle.status == 1300}">
			<c:if test="${recycle.method == 1 || recycle.method == 2}">

				<a class="easyui-linkbutton" onclick="updateDoorEng('${recycle.id}');">重新指派</a>
				<%--<s:privilege ifAny="order_cannot_complete">--%>
					<%--<a class="easyui-linkbutton" id="failRecycle">无法完成</a>--%>
				<%--</s:privilege>--%>

			<%-- 	<s:privilege ifAny="order_cannot_complete">
					<a class="easyui-linkbutton" id="failRecycle">无法完成</a>
				</s:privilege> --%>
				<a class="easyui-linkbutton" id="program">评估完成</a>
			</c:if>
			<c:if test="${recycle.method == 0}">
				<%--	评估完成订单状态转为  waitPayment  待付款--%>
				<a class="easyui-linkbutton" id="assessSuccess">评估完成</a>

				<a class="easyui-linkbutton" onclick="updateDoorEng('${recycle.id}');">重新指派</a>
				<%--<s:privilege ifAny="order_cannot_complete">--%>
					<%--<a class="easyui-linkbutton" id="failRecycle">无法完成</a>--%>
				<%--</s:privilege>--%>
			<%-- 	<s:privilege ifAny="order_cannot_complete">
					<a class="easyui-linkbutton" id="failRecycle">无法完成</a>
				</s:privilege> --%>
			</c:if>
		</c:if>
</c:if>
		<c:if test="${recycle.status == sendBack}">
			<a class="easyui-linkbutton" onclick="clientConfirmReceipt('${recycle.id}');">客户已收货</a>
		</c:if>
 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
		<c:if test="${recycle.status == 500 || recycle.status == 501}">
			<s:privilege ifAny="order_distribute_to_cp"><%--平台管理员才有分配服务商的权限--%>
			<a class="easyui-linkbutton" onclick="distributeToCp('${recycle.id}');">分配服务商</a>
			</s:privilege>
		</c:if>
</c:if>
		<s:privilege ifAny="todo_manage">
			<%--<c:if test="${todo == null}">--%>
			<%--<a onclick="addTodo('${recycle.id}');" style="float: right;margin-right: 10px;" class="easyui-linkbutton">新增待办事项</a>--%>
			<%--</c:if>--%>
			<c:if test="${todo != null}">
				<a onclick="showTodoInfo('${recycle.id}');" style="float: right;margin-right: 10px;"
				   class="easyui-linkbutton"><c:if test="${todo.handle == 1}">事项已完成</c:if><c:if
						test="${todo.handle != 1}">查看待办事项</c:if></a>
			</c:if>
		</s:privilege>

<c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
		<a id="addRamark" style="float: right;margin-right: 20px;margin-top: -20px;" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加备注</a>
	<c:if test="${recycle.status != close && recycle.status != success && recycle.status != refuseSuccess }">
		<c:if test="${recycle.status >= 1000  || recycle.status == 501 || recycle.status == 500 || recycle.status == 100}">
			<%--<s:privilege ifAny="order_confirm_fail">--%>
				<a class="easyui-linkbutton" id="realyfailRecycle">取消订单</a>
			<%--</s:privilege>--%>
		</c:if>
		<%--<s:privilege ifAny="order_close">--%>
			<%--<a class="easyui-linkbutton" id="closeRecycle">关闭订单</a>--%>
		<%--</s:privilege>--%>
	</c:if>
</c:if>
	<s:privilege ifAny="complaint_order_customer">
		<c:if test="${recycle.status != 0 && recycle.status != 500 && recycle.status != 2600 && recycle.cpId != 0 && recycle.cpId != null}">
			<a class="easyui-linkbutton" onclick="editJump('${recycle.id}')">创建投诉</a>
			 <input  type="hidden" id="source"  value="${source}"></input>
			<div id="addComplaintView"></div>
		</c:if>
	</s:privilege>
	</div>
	<c:if test="${recycle.status == engineersDoor}">
		<c:if test="${recycle.method == 0}">
			注:收到设备后请仔细评估设备，如与用户描述不符请重新评估，如无回收价值点击回收失败后回寄设备.
		</c:if>
	</c:if>
	<%--<div style="margin-top: 20px;">
		<c:if test="${recycle.status == 1000}"></c:if>
		<c:if test="${recycle.status == 1010}">提醒：请根据提交的回收单核对信息，无异议后想客户支付。</c:if>
		<c:if test="${recycle.status == 1020}">提醒：已支付回收金，等待回收人交回设备。</c:if>
		<c:if test="${recycle.status == 1030}">提醒：回收设备已经入库，设备卖出后请将资金支付入账。</c:if>
		<c:if test="${recycle.status == 1040}">提醒：已卖出设备，卖出款项未还给还公司。</c:if>
		<c:if test="${recycle.status == 1050}">醒：完成，卖出款项已还给还公司</c:if>
		<c:if test="${recycle.status == 1100}">提醒：请仔细核实信息后再重启回收单。</c:if>
	</div>--%>
</div>

<div style="width: 950px;border: 1px #CCCCCC solid;margin-left: auto;margin-right: auto;padding-left: 20px;padding-bottom: 20px;">
	<table  style="width:950px">
		<tr  style="height:20px;">
            <td colspan="4" width="100%" ></td>
        </tr>
		<c:forEach items="${recycle.logs}" var="recycleLog" varStatus="status">
			<tr <c:if test="${status.index == 0}">class="firth_li"</c:if>>
				<td style="width: 25%;word-wrap:break-word;word-break:break-all;"><fmt:formatDate value="${recycleLog.createTime}" pattern="MM-dd  HH:mm:ss"/></td>
                <td style="width: 25%;word-wrap:break-word;word-break:break-all;">
					<c:if test="${recycleLog.trackStatus ==1 }">
						<font style="color: red;">备注信息</font>
					</c:if>
					<c:if test="${recycleLog.trackStatus !=1 }">
						${recycleLog.content }
					</c:if>
				</td>

                <td style="width: 25%;word-wrap:break-word;word-break:break-all;">备注:${recycleLog.remark}</td>
                <td style="width: 25%;word-wrap:break-word;word-break:break-all;">操作人:${recycleLog.operatorName}<c:if test="${recycleLog.type == 3}">(工程师)</c:if></td>
			</tr>
		</c:forEach>
	</table>
</div>

<div style="width: 950px;margin-left: auto; margin-right: auto;margin-top: 10px; padding-left: 20px;padding-bottom: 20px;">
	<table class="recycle_info">
		<tr>
			<td valign="top">
				<div style="font-weight: bold;padding: 10px;">回收价信息</div>
		        <div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
		            <label>回收单号:&nbsp;${recycle.id}</label>
					<label>下单时间:<fmt:formatDate value="${recycle.createTime}" pattern="MM-dd  HH:mm:ss"/> </label>
					<label>回收方式:
						<c:if test="${recycle.method==1}">上门</c:if>
						<c:if test="${recycle.method==2}">到店</c:if>
						<c:if test="${recycle.method==0}">邮寄
							<c:if test="${recycle.sendLogistics.type == 0}">
								/${recycle.sendLogistics.express.name}：${recycle.sendLogistics.expressSn}
							</c:if>
						</c:if>
					</label>
				<c:if test="${recycle.method==1}">
					<label>上门时间:<%--<fmt:formatDate value="${recycle.assignTime}" pattern="MM-dd  HH:mm:ss"/>--%> ${recycle.orderOnsiteRepair.onsiteDate}</label>
				</c:if>

	<%--，0：web 1：电话--%>
					<label>来源渠道:&nbsp;<c:if test="${recycle.source==0}">WEB</c:if><c:if test="${recycle.source==1}">WAP</c:if><c:if test="${recycle.source==2}">微信</c:if><c:if test="${recycle.source==3}">系统</c:if><c:if test="${recycle.source==4}">电话</c:if>/${recycle.channelName}</label>
					<label>订单类型:&nbsp;<c:if test="${recycle.orderCategory==0}">普通订单</c:if><c:if test="${recycle.orderCategory==1}">二次回收订单</c:if></label>

		        </div>
			</td>
			<td valign="top">
				<div style="font-weight: bold;padding: 10px;">服务信息</div>
				<div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
					<label>服务商:&nbsp;${recycle.cp.name}</label>
		            <label>服务网点:&nbsp;${recycle.serCenterName}</label>
		            <label>服务工程师:
						${recycle.engineerNameAndPhone}
		            </label>
				</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<div style="font-weight: bold;padding: 10px;">客户信息&nbsp;
			<c:if test="${recycle.status !=2500 && recycle.status !=2400 && recycle.status !=2301 && recycle.status!=2300}">
					<a href="javaScript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit'"
					   onclick="updateOrderUserInfo('${recycle.userExinfo.userName}','${recycle.userExinfo.mobile}',
							   '${recycle.userExinfo.cityName}',
							   '${recycle.userExinfo.id}', '${recycle.id}', '${recycle.userExinfo.cityId} ') ">修改</a>
			</c:if>
                </div>
				<div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
					<label>客户姓名:&nbsp;${recycle.userExinfo.userName}</label>
					<label>客户电话:&nbsp;${recycle.userExinfo.mobile}</label>
					<label>所在地址:&nbsp;${recycle.userExinfo.cityName} ${recycle.userExinfo.address}</label>
				</div>
			</td>
			<td valign="top">
				<div style="font-weight: bold;padding: 10px;">收款信息&nbsp;
<c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
					<c:if test="${recycle.status !=2500 && recycle.status !=2400 && recycle.status !=2301 && recycle.status!=2300}">
						<a class="easyui-linkbutton" id="updateRecycleReceiving" style="width:60px;" data-options="iconCls:'icon-edit'">修改</a>
					</c:if>
</c:if>
				</div>
				<div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
					<label>收款方式:
						<%--PayMethodTypeConstant.java--%>
						<c:if test="${recycle.userPayment.payMethod==0}">支付宝</c:if>
						<c:if test="${recycle.userPayment.payMethod==4}">现金支付</c:if>
						<c:if test="${recycle.userPayment.payMethod==3}">银行卡</c:if>
						<c:if test="${recycle.userPayment.payMethod==5}">优惠券</c:if>
					</label>

					<c:if test="${recycle.userPayment.payMethod==3}">
						<label>开户银行:&nbsp;${recycle.userPayment.bank}</label>
						<label>开户姓名:&nbsp;${recycle.userPayment.accountName}</label>
						<label>银行卡号:&nbsp;${recycle.userPayment.account}</label></c:if>

					<c:if test="${recycle.userPayment.payMethod!=3}">
						<label>账号姓名:&nbsp;${recycle.userPayment.accountName}</label>
						<label>账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:&nbsp;${recycle.userPayment.account}</label></c:if>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div style="font-weight: bold;padding: 10px;">订单处理信息</div>
				<div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
					<label style="width: 500px;display: inline-block;">
						责任客服:
						<c:if test="${firstAdmin!=null}">
							${firstAdmin.username}/ <fmt:formatDate value="${recycle.firstAssignTime}" pattern="yyyy-MM-dd  HH:mm"/>
						</c:if>
					</label>
					<br>
					<label style="width: 500px;display: inline-block;">
						收货状态:${recycle.harvestStatus}
					</label>
					<br>
					<label style="width: 310px;display: inline-block;">
						回寄状态:${recycle.sendBackStatus}
					</label>
					<br>
					<label style="width: 500px;display: inline-block;">
						付款状态:
						<c:choose>
							<c:when test="${recycle.payStatus==1}">
								已付款
								<c:forEach items="${recycle.paylogs}" var="log" varStatus="status">
									<c:if test="${status.index>0 }">&nbsp;|&nbsp;</c:if>
									<fmt:formatDate value="${recycle.gmtPaymentTime}" pattern="yyyy-MM-dd  HH:mm"/>/
									<c:if test="${log.type==0 }">
										支付宝
									</c:if>
									<c:if test="${log.type==1 }">
										微信
									</c:if>
									<c:if test="${log.type==2 }">
										后台
									</c:if>:${log.buyerEmail }
								</c:forEach>
							</c:when>
							<c:when test="${recycle.payStatus==2}">
								已退款:
								<c:forEach items="${recycle.refundlogs}" var="log" varStatus="status">
									<c:if test="${status.index>0 }">&nbsp;|&nbsp;</c:if>
									<fmt:formatDate value="${log.refundTime}" pattern="yyyy-MM-dd  HH:mm"/>/
									${log.refundAccount }/${log.price}
								</c:forEach>
							</c:when>
							<c:when test="${recycle.payStatus==3}">
								<c:if test="${recycle.userPayment.payMethod==4}">已付款</c:if>
								<c:if test="${recycle.userPayment.payMethod==5}">已发券</c:if>
							</c:when>
							<c:otherwise>
								未付款
							</c:otherwise>
						</c:choose>
					</label>
			</td>
			<td valign="top">
				<div style="font-weight: bold;padding: 10px;">设备信息&nbsp;
 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
				<c:if test="${recycle.status !=2500 && recycle.status !=2400 && recycle.status !=2301 && recycle.status!=2300}">
					<a class="easyui-linkbutton" id="updateRecycleDevice" style="width:110px;" data-options="iconCls:'icon-edit'">重新评估</a>
				</c:if>
</c:if>
                </div>
				<div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
					<c:forEach items="${recycle.recycleValuationList}" var="recycleValuation">
						<c:if test="${recycleValuation.isOrig==0}">
							<label>设备分类:&nbsp;${recycle.deviceCategory.name}</label>
							<label>设备品牌:&nbsp;${recycle.brand.name}</label>
							<label>设备型号:&nbsp;${recycle.device.model}</label>
							<label>系统估价:&nbsp;${recycleValuation.price}</label>
							<label>设备评估:&nbsp;${recycleValuation.valuationDesc}</label>
						</c:if>
					</c:forEach>
				</div>
			</td>
		</tr>
		<%-- 代客下单信息 --%>
        <tr>
            <td>
                <div style="font-weight: bold;padding: 10px;">代客下单</div>
                <div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
                    <label style="width: 500px;display: inline-block;">员工姓名:${recycle.employeeName}</label>
				</div>
            </td>
            <td valign="bottom">
                <div style="font-weight: bold;padding: 10px;"></div>
                <div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">
                    <label>员工编号:${recycle.employeeNo}</label>
                </div>
            </td>
        </tr>
		<tr>
			<td valign="top">
				<div style="font-weight: bold;padding: 10px;">重新评估信息&nbsp;
					<%--<a class="easyui-linkbutton" id="updateRecycleReceiving" style="width:60px;" data-options="iconCls:'icon-edit'">修改</a>--%>
				</div>
				<div style="padding-left: 10px; padding-top: 0px;padding-right: 10px;padding-bottom: 10px;">

					<c:forEach items="${recycle.recycleValuationList}" var="recycleValuation">
						<c:if test="${recycleValuation.isOrig==1}">
							<label>设备分类:&nbsp;${recycle.deviceCategory.name}</label>
							<label>设备品牌:&nbsp;${recycle.brand.name}</label>
							<label>设备型号:&nbsp;${recycle.device.model}</label>
							<label>系统估价:&nbsp;${recycleValuation.price}</label>
							<label>设备评估:&nbsp;${recycleValuation.valuationDesc}</label>
						</c:if>
					</c:forEach>
				</div>

			</td>
		</tr>
	</table>

	<c:if test="${files != null}">
		</br>
		<table class="easyui-datagrid" title="图片信息"
			   data-options="fitColumns:true,autoRowHeight:true,rownumbers:true,singleSelect:true,scrollbarSize:0">
			<thead>
			<tr>
				<th data-options="field:'groupId',width:70">ID</th>
				<th data-options="field:'dtCreate',width:60">上传时间</th>
				<th data-options="field:'pictures',width:200">图片</th>
				<th data-options="field:'operator',width:60">操作人</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${enginnerUpload != null}">
				<tr>
					<td>${enginnerUpload.groupId}</td>
					<td><fmt:formatDate value="${enginnerUpload.dtCreate}" pattern="YYYY-MM-dd HH:mm:ss" /></td>
					<td>
						<c:forEach var="path" items="${enginnerUpload.paths}"  varStatus="psindex">
							<%--<img src="${resourcePath}/upload/${path}"/>--%>
							<div style="float:left;margin:1px;">
							<img class="uploadimg" src="${path}"  style="max-width:100px;height:100px;" onclick="openImg('${path}')"/>
							</div>
							<c:if test="${(psindex.index+1)%4 == 0}"></br></c:if>
						</c:forEach>
					</td>
					<td>${enginnerUpload.operatorName}<c:if test="${null!=enginnerUpload.operatorName}">(工程师)</c:if></td>
				</tr>
			</c:if>
			<c:if test="${userUpload != null}">
				<tr>
					<td>${userUpload.groupId}</td>
					<td><fmt:formatDate  value="${userUpload.dtCreate}" pattern="YYYY-MM-dd HH:mm:ss" /></td>
					<td>
						<c:forEach var="path" items="${userUpload.paths}">
							<div style="float:left;margin:1px;">
							<img src="${path}"  style="max-width:100px;height:100px;" onclick="openImg('${path}')"/>
							</div>
						</c:forEach>
					</td>
					<td>${userUpload.operatorName}<c:if test="${null!=enginnerUpload.operatorName}">(普通用户)</c:if></td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</c:if>
</div>

<!-- 添加备注 -->
<div style="display: none">
	<div class="easyui-dialog" title="添加备注" style="width:420px;height: 300px;padding: 10px;"
	     data-options="closed:true,iconCls:'icon-add',editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.saveRecycleRamark();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#recycle_ramark').dialog('close');}}]"
	     id="recycle_ramark">
	    <div>
	        <div style="width:40px;height: 200px;text-align:right;float: left;">备注：</div>
	        <textarea style="width:340px;height: 200px;resize: none;" id="recycle_ramark_content"></textarea>
	    </div>
	</div>
</div>

<%--修改上门时间--%>

<div id="updateOrderOnsiteRepairDiv" class="easyui-dialog" title="修改上门时间" data-options="width:400,height:160,closed:true,modal:true, buttons:[{text:'保存',iconCls:'icon-ok',handler:function(){$('#repairForm').submit();
        }},{text:'取消',iconCls:'icon-cancel',handler:function(){$('#updateOrderOnsiteRepairDiv').dialog('close');} }]">

	<form class="data_form" method="post" id="repairForm" style="margin-left: 10px;">
		下单时间 ：
		<select id="datelay" name="datelay"> </select>-
		<select id="beginTime" name="beginTime">
			<option value="-1">开始时间</option>
		</select>-
		<select id="endTime" name="endTime">
			<option value="-1">结束时间</option>
		</select>
		<!--<select name="repairTime" id="repairTime">
            <option value="9:00:00">9:00 - 10:00</option>
            <option value="10:00:00">10:00 - 11:00</option>
            <option value="11:00:00">11:00 - 12:00</option>
            <option value="12:00:00">12:00 - 13:00</option>
            <option value="13:00:00">13:00 - 14:00</option>
            <option value="14:00:00">14:00 - 15:00</option>
            <option value="15:00:00">15:00 - 16:00</option>
            <option value="16:00:00">16:00 - 17:00</option>
            <option value="17:00:00">17:00 - 18:00</option>
            <option value="18:00:00">18:00 - 19:00</option>
            <option value="19:00:00">19:00 - 20:00</option>
        </select>-->
		<input type="hidden" value="${recycle.id}" id="orderRepairId" name="orderRepairId">
	</form>
	<label style="margin-left: 10px;">提示：操作成功后系统将会向客户、工程师发送短信通知</label>
</div>


<!-- 修改回收价 -->
 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
<div style="display: none">
	<div class="easyui-dialog" title="修改回收价" style="width:420px;height: 300px;padding: 10px;"
	     data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.updatePrice();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#update_price').dialog('close');}}]"
	     id="update_price">
	     <div>
	     	<div style="width:65px;text-align:right;float: left;">修改价格：</div>
	     	<input style="width: 297px;" type="text" name="price" placeholder="请填写修改后价格" tipcontent="请填写修改后价格" 
	     	id="price" class="easyui-numberbox" precision="2" data-options=" required:true" min="0.00"/>
	    </div>
    	<br>
	    <div>
	        <div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
	        <textarea style="width:295px;height: 160px;resize: none;" id="update_price_ramark"></textarea>
	    </div>
	</div>
</div>
</c:if>
<!-- 关闭订单 -->
<div style="display: none">
	<div class="easyui-dialog" title="关闭回收单" style="width:420px;height: 300px;padding: 10px;"
	     data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.closeRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#close_recycle_div').dialog('close');}}]"
	     id="close_recycle_div">
	     <div>
	     	<div style="width:65px;text-align:right;float: left;">关闭原因：</div>
	     	<input id="messageTemp" name="messageTemp" class="easyui-combobox" data-options="width:300,required:true,
                 valueField: 'svalue',
                 textField: 'svalue',
                 url: ctx+ '/settings/getTemp.json?skey=Recycle_Close_Order_Message',
                 loadFilter:function(data){
                    return data.rec
                 },
                 onSelect: function(rec){
                 if(rec.svalue!='其它') {
                    $('#remarkMessage').focus();
                 }else{
                    $('#remarkMessage').focus('');
                 }
                }"/>
	    </div>
    	<br>
	    <div>
	        <div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
	        <textarea style="width:295px;height: 160px;resize: none;" id="close_recycle_ramark"></textarea>
	    </div>
	</div>
</div>



<!-- 回寄设备 -->
<div style="display: none">
	<div class="easyui-dialog" title="回寄设备" style="width:420px;height: 300px;padding: 10px;"
		 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.returnDevice();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#return_recycle_div').dialog('close');}}]"
		 id="return_recycle_div">
		<div>
			<div style="width:100px;text-align:right;float: left;">请选择快递：</div>
			<input id="express" name="express" class="easyui-combobox"  data-options="width:200,required:true,editable:false,
                 valueField: 'id',
                 textField: 'name',
                 url: ctx+ '/common/getExpress.json',
                 loadFilter:function(data){
                    return data.express
                 },
                 onSelect: function(rec){
                 if(rec.svalue!='其它') {
                    $('#remarkMessage').focus();
                 }else{
                    $('#remarkMessage').focus('');
                 }
                }"/>
		</div><br><br>
		<div style="width:100px;text-align:right;float: left;">快递号：</div>
		<input style="width: 200px; height: 20px;" id="expressSn" name="expressSn" placeholder="请填写快递号"><br><br>

		<div style="width:100px;text-align:right;float: left;">备注内容：</div>
		<textarea style="width:200px;height: 100px;resize: none;" id="return_recycle_ramark"></textarea>

	</div>
</div>


<!-- 确认收货 -->
<div style="display: none">
	<div class="easyui-dialog" title="确认收货" style="width:420px;height: 300px;padding: 10px;"
		 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.confirmRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#confirm_recycle_div').dialog('close');}}]"
		 id="confirm_recycle_div">
		<div>
			<div style="width:100px;text-align:right;float: left;">请选择快递：</div>
			<input id="messageTemp2" name="messageTemp2" class="easyui-combobox"  data-options="width:200,required:true,editable:false,
                 valueField: 'id',
                 textField: 'name',
                 url: ctx+ '/common/getExpress.json',
                 loadFilter:function(data){
                    return data.express
                 },
                 onSelect: function(rec){
                 if(rec.svalue!='其它') {
                    $('#remarkMessage').focus();
                 }else{
                    $('#remarkMessage').focus('');
                 }
                }"/>
		</div><br><br>
		<div style="width:100px;text-align:right;float: left;">快递号：</div>
		<input style="width: 200px; height: 20px;" id="expressSn1" name="expressSn" placeholder="请填写快递号">

	</div>
</div>
<!-- 审核 -->
<div style="display: none">
	<div class="easyui-dialog" title="审核订单" style="width:420px;height: 300px;padding: 10px;"
		 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.audiRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#audi_recycle_div').dialog('close');}}]"
		 id="audi_recycle_div">
		<div>
		<div>
			<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
			<textarea style="width:295px;height: 160px;resize: none;" id="audi_recycle_ramark"></textarea>
		</div>
	</div>
</div>

	<!-- 回收失败 -->
	<div style="display: none">
		<div class="easyui-dialog" title="填写回收失败原因" style="width:420px;height: 300px;padding: 10px;"
			 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.failRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#fail_recycle_div').dialog('close');}}]"
			 id="fail_recycle_div">
			<div>
				<div style="width:65px;text-align:right;float: left;">失败原因：</div>
				<input id="message" name="message" class="easyui-combobox" data-options="width:300,required:true,
                 valueField: 'svalue',
                 textField: 'svalue',
                 url: ctx+ '/settings/getTemp.json?skey=Recycle_Close_Order_Message',
                 loadFilter:function(data){
                    return data.rec
                 },
                 onSelect: function(rec){
                 if(rec.svalue!='其它') {
                    $('#remarkMessage').focus();
                 }else{
                    $('#remarkMessage').focus('');
                 }
                }"/>
			</div>
			<br>
			<div>
				<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
				<textarea style="width:295px;height: 160px;resize: none;" id="fail_recycle_ramark"></textarea>
			</div>
		</div>
	</div>
	<div style="display: none">
		<div class="easyui-dialog" title="请填写取消订单原因" style="width:420px;height: 300px;padding: 10px;"
			 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.realyfailRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#fail_realyfailRecycle_div').dialog('close');}}]"
			 id="fail_realyfailRecycle_div">
			<div>
				<div style="width:65px;text-align:right;float: left;">取消原因：</div>
				<input id="overmessage" name="message" class="easyui-combobox" data-options="width:300,required:true,
                 valueField: 'svalue',
                 textField: 'svalue',
                 url: ctx+ '/settings/getTemp.json?skey=Cancel_Recycle_Msg',
                 loadFilter:function(data){
                    return data.rec
                 },
                 onSelect: function(rec){
                 if(rec.svalue!='其它') {
                    $('#remarkMessage').focus();
                 }else{
                    $('#remarkMessage').focus('');
                 }
                }"/>
			</div>
			<br>
			<div>
				<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
				<textarea style="width:295px;height: 160px;resize: none;" id="fail_recycle_ramark_realy"></textarea>
			</div>
		</div>
	</div>
	<!-- 评估完成 -->
	<div style="display: none">
		<div class="easyui-dialog" title="填写评估备注" style="width:420px;height: 300px;padding: 10px;"
			 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.assessSuccess();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#assess_recycle_div').dialog('close');}}]"
			 id="assess_recycle_div">
			<div>
				<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
				<textarea style="width:295px;height: 160px;resize: none;" id="assess_recycle_ramark"></textarea>
			</div>
		</div>
	</div>

	<!-- 确认方案 -->
	<div style="display: none">
		<div class="easyui-dialog" title="填写备注" style="width:420px;height: 300px;padding: 10px;"
			 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.program();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#program_recycle_div').dialog('close');}}]"
			 id="program_recycle_div">
			<div>
				<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
				<textarea style="width:295px;height: 160px;resize: none;" id="program_recycle_ramark"></textarea>
			</div>
		</div>
	</div>
	<!--   完成回收 -->
	<div style="display: none">
		<div class="easyui-dialog" title="请填写备注" style="width:420px;height: 300px;padding: 10px;"
			 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.successRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#success_recycle_div').dialog('close');}}]"
			 id="success_recycle_div">
			<div>
				<div>
					<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
					<textarea style="width:295px;height: 160px;resize: none;" id="success_recycle_ramark"></textarea>
				</div>
			</div>
		</div>

		<!-- 指派上门 -->
		<div style="display: none">
			<div class="easyui-dialog" title="请填写备注" style="width:420px;height: 300px;padding: 10px;"
				 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.assignDoorRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#assignDoor_recycle_div').dialog('close');}}]"
				 id="assignDoor_recycle_div">
				<div>
					<div>
						<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
						<textarea style="width:295px;height: 160px;resize: none;" id="assignDoor_recycle_ramark"></textarea>
					</div>
				</div>
			</div>


			<!-- 指派评估工程师 -->
			<div style="display: none">
				<div class="easyui-dialog" title="请填写备注" style="width:420px;height: 300px;padding: 10px;"
					 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.assignDoorRecycle1();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#assignDoor_recycle_div1').dialog('close');}}]"
					 id="assignDoor_recycle_div1">
					<div>
						<div>
							<div style="width:65px;height:160px;text-align:right;float: left;">备注内容：</div>
							<textarea style="width:295px;height: 160px;resize: none;" id="assignDoor_recycle_ramark1"></textarea>
						</div>
					</div>
				</div>

	<!-- 转邮寄 -->
	<div style="display: none">
		<div class="easyui-dialog" title="转邮寄" style="width:420px;height: 300px;padding: 10px;"
			 data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.updateSendRecycle();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#updateSend_recycle_div').dialog('close');}}]"
			 id="updateSend_recycle_div">
			<div>
				<div style="width:65px;text-align:right;float: left;">选择网点：</div>
				<input id="serviceCenter" name="messageTemp" class="easyui-combobox"   data-options="width:300,required:true,editable:false,
                 valueField: 'id',
                 textField: 'name',
                 url: ctx+ '/order/showServiceCenter',
                 loadFilter:function(data){
                    return data.serviceCenters
                 },
                 onSelect: function(rec){
                 if(rec.svalue!='其它') {
                    $('#remarkMessage').focus();
                 }else{
                    $('#remarkMessage').focus('');
                 }
                }"/>
			</div>
		</div>
	</div>

<!-- 修改收款人信息 -->
<div style="display: none">
	<div class="easyui-dialog" title="修改收款人信息" style="width:350px;height: 300px;padding: 10px;"
	     data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.updateRecycleReceiv();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#update_recycle_receiving_div').dialog('close');}}]"
	     id="update_recycle_receiving_div">
		<div>
	        支付方式：
			<select id="paymentType" name="paymentType" onchange="payment()" style="width: 150px;height: 20px;"data-options="required:true,editable:false">
				<option value="0" <c:if test="${recycle.userPayment.payMethod==0}">selected="selected"</c:if> >支付宝</option>
				<option value="4" <c:if test="${recycle.userPayment.payMethod==4}">selected="selected"</c:if> >现金支付</option>
				<option value="3" <c:if test="${recycle.userPayment.payMethod==3}">selected="selected"</c:if> >银行卡</option>
				<option value="5" <c:if test="${recycle.userPayment.payMethod==5}">selected="selected"</c:if> >优惠券</option>

			</select>
		</div>

		<div class="bank" style="margin-top: 15px;<c:if test="${recycle.userPayment.payMethod!=3}">display: none</c:if>" >
		银行名称：
		<select id="bankName" name="bankName" style="width: 150px;height: 20px;"data-options=" required:true,editable:false">

		</select>
		</div>
		<div class="name" style="margin-top: 15px;" >
			姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
			<input style="width: 150px;height: 20px;" type="text" name="accountName" placeholder="请填姓名" tipcontent="请填姓名"
	     	id="accountName" class="easyui-textbox" data-options="required:true" value="${recycle.userPayment.accountName}"/>
		</div>
		<div class="num" style="margin-top: 15px;" >
			支付账户：
			<input style="width: 150px;height: 20px;" type="text" name="fnum" placeholder="请填写账户" tipcontent="请填写账户"
	     	id="fnum" class="easyui-textbox" data-options=" required:true" value="${recycle.userPayment.account}"/>
		</div>

	</div>
</div>
<%--修改客户信息--%>

		<div id="updateOrderUserInfoDiv" class="easyui-dialog" title="修改客户信息"
			 data-options="width:460,height:360,closed:true,modal:true,onOpen:function(){$('#updateOrderUserInfoDiv').dialog('center');},
        	buttons:[{text:'保存',iconCls:'icon-ok',handler:function(){$(' #updateOrderUser_form_ ').submit();
            }},{text:'取消',iconCls:'icon-cancel',handler:function(){$('  #updateOrderUserInfoDiv'  ).dialog('close');} }]">
			<form class="data_form" method="post" id="updateOrderUser_form_">
				<input type="hidden" id="tmpAddress" value="${recycle.userExinfo.address}">

				姓名 ：<input type="text" name="userName" id="userName" class="easyui-validatebox" data-options=" required:true">
				<br>
				电话 ：<input type="text" name="telPhone" id="telPhone" class="easyui-validatebox" data-options=" required:true">
				<br>
				<input type="hidden" name="userid" id="userid" value="">
				<input type="hidden" name="orderid" id="orderid" value="">
				<br>
				省：
				<input id="provinceId" name="provinceId" class="easyui-combobox" data-options=" required:true,editable: false,
                valueField: 'name',
                textField: 'name',
                url: '/order/showPrivince',
                loadFilter:function(data){
                    return data.rec
                },
                onSelect: function(rec){
                    var url =ctx+ '/order/showCity?provinceId='+rec.id;
                    $('#city').combobox('clear');
                    $('#city').combobox('reload', url);}    "/>
				<br>
				市：
				<input id="city" class="easyui-combobox" name="city" data-options="required:true,editable: false,
                valueField:'id',
                textField: 'name',
                loadFilter:function(data){
                    return data.city
                },
                onSelect: function(city){
                    var url =ctx+ '/order/showDist?cityId='+city.id;
                    $('#dist').combobox('clear');
                    $('#dist').combobox('reload', url);
                }"/>
				<br>
				县： <input id="dist" name="dist" class="easyui-combobox" data-options=" required:true, editable: false,valueField:'name',textField: 'name', loadFilter:function(data){  return data.dist  }"/>
				地址：<input type="text" name="addRess" id="addRess" value="${recycle.userExinfo.address}">
			</form>
		</div>


		<%--重新指派--%>
 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
		<div id="updateDoorEngDiv" class="easyui-dialog" title="重新指派工程师"
			 data-options="width:430,height:150,closed:true,modal:true">
			<form class="data_form" method="post" id="updateDoorEngForm" style="margin-left: 10px;">
				<input id="cityUpdateDoorCity" type="text" value="维修中心" style="width:100Px">
				<input id="cityUpdateDoorEng" style="width:180px;"/>
				<a class="easyui-linkbutton" onclick="assignDoorByUpdate();">指派上门</a>
				<input type="hidden" value="${recycle.id}" id="orderUpdatDoorId">
			</form>
			<label style="margin-left: 10px;">提示：操作成功后系统将会向客户、原工程师、现工程师发送短信通知</label>
		</div>
</c:if>
			<!-- 分配服务商 -->
 <c:if test="${source!='myTaskMain'}"><%--代客下单不可显示 --%>
			<div id="distributeToCpDiv" class="easyui-dialog" title="分配服务商"
				 data-options="width:460,height:400,closed:true,modal:true,onOpen:function(){$('#distributeToCpDiv').dialog('center');},
        	buttons:[{text:'保存',iconCls:'icon-ok',handler:function(){my_submit();
            }},{text:'取消',iconCls:'icon-cancel',handler:function(){$('  #distributeToCpDiv'  ).dialog('close');} }]">

				<input type="hidden" name="order_id" id="my_order_id" value="${recycle.id}">
				<br/><br/>
				　　　  选择合作商： <select name="my_cplist" id="my_cplist" style="width: 250px;"></select>
			</div>
</c:if>
			<!-- 修改设备信息 -->
<div style="display: none" id="deviceInfo">
	<div class="easyui-dialog" title="修改设备信息" style="width:600px;height: 400px;padding: 10px;"
	     data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.updateRecycleDevice();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#update_recycle_device_div').dialog('close');}}]"
	     id="update_recycle_device_div">
	    <div style="margin-left: 5px;margin-top: 5px;">

			<label>设备型号</label><br/>
			<select id="deviceCategoryId" name="deviceCategoryId" style="width: 145px;height: 23px;" data-options=" required:true,editable:false">
					<option selected="selected" >${recycle.deviceCategory.name}</option>
			</select>&nbsp;&nbsp;&nbsp;
			<select id="brandId" name="brandId" style="width: 145px;height: 23px;" data-options=" required:true,editable:false">
				<%--<c:forEach items="${brands}" var="brand">
					<option value="${brand.brandId}" <c:if test='${recycle.brand.id==brand.brandId}'>selected="selected" </c:if> >${brand.brandName}</option>
				</c:forEach>--%>
			</select>&nbsp;&nbsp;&nbsp;
			<select id="deviceId" name="deviceId" style="width: 145px;height: 23px;"data-options=" required:true,editable:false">

			</select>
		</div>
		<div style="margin-left: 5px;margin-top: 15px;">
			<label>基本属性</label><br/>
			<div  id="baseAttr"></div>
		</div>
		<div style="margin-left: 5px;margin-top: 15px;" >
			<label>外观/现象</label><br/>
			<div  id="waigaunAttr"></div>
		</div>
		<div style="margin-left: 5px;margin-top: 15px;">
			<label>功能异常</label><br/>
			<div  id="gongnengAttr" ></div>
		</div>
		<br/><br/>
			<input name='完成修改,重估价格' type='button' onclick='getValuation()' value='重估价格'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		重估价格:<input  name="valuation" id="valuation"/>
	</div>
</div>

<!-- 填写回收支付记录 -->
<div style="display: none">
	<div class="easyui-dialog" title="填写回收支付记录" style="width:420px;height: 360px;padding: 10px;"
	     data-options="closed:true,editable:false,modal:true,buttons:[
	     {text:'保存',iconCls:'icon-ok',handler:function(){window.recyclePaymentRecord();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#recycle_payment_record_div').dialog('close');}}]"
	     id="recycle_payment_record_div">
		<div style="background-color: #efefef;width: 405px;height: 60px;margin-left: -10px;margin-top: -10px; margin-bottom: 15px;">
	     	<table width="100%">
				<tr>
					<td style="width: 25%;height: 25px;padding-left: 15px">
			            <label>收款人名：
			            ${recycle.userExinfo.userName}</label>
			        </td>
			        <td style="width: 25%;">
			            <label>联系电话：
			            ${recycle.userExinfo.mobile}</label>
			        </td>
			    </tr>
			    <tr>
			       <%-- <td style="width: 25%;height: 20px;padding-left: 15px">
			        	<label>收款方式：
			        	<c:if test="${recycle.payMethod==1}">支付宝</c:if>
	            		<c:if test="${recycle.payMethod==2}">银行卡/${recycle.recyclePayment.bank}</c:if>
	            		<c:if test="${recycle.payMethod==3}">现金</c:if></label>
			        </td>--%>
			        <td style="width: 25%;">
			            <label>收款账号：
			          <%--  ${recycle.recyclePayment.account}</label>--%>
			        </td>
			    </tr>
		    </table>
		</div>
		<!-- <div>
	        <div style="width:65px;text-align:right;float: left;">支付方式：</div>
			<select id="record_paymentType" name="record_paymentType" onchange="recordPayment()" style="width: 300px;height: 23px;"data-options=" required:true,editable:false">
				<option value="1" >支付宝</option>
				<option value="2" >银行卡</option>
				<option value="3" >现金</option>
			</select>
		</div> -->
		<div style="margin-top: 15px;">
			<div style="width:65px;text-align:right;float: left;">流&nbsp;&nbsp;水&nbsp;号：</div>
			<input style="width: 297px;height: 20px;" type="text" name="serialNum" placeholder="请输入银行或支付宝交易流水号(选填)" tipcontent="请输入银行或支付宝交易流水号(选填)" 
	     	id=serialNum class="easyui-textbox" data-options=" required:true" />
		</div>
		<div style="margin-top: 15px;">
			<div style="width:65px;text-align:right;float: left;">支付截图：</div><br>
			<a id="uploadAccessPic" class="easyui-linkbutton" iconCls="icon-upload" >上传</a>
      	<%--	<input type="hidden" id="pic" name="pic" value="${recycle.recyclePayment.payPic}"/>--%>
		</div><br >
	</div>
</div>

				<div id="imgDialog"></div>
<!-- 扫码支付-->
<div style="display: none">
	<div class="easyui-dialog" title="扫码支付" style="width:420px;height: 300px;padding: 10px;"
	     data-options="closed:true,iconCls:'icon-add',editable:false,modal:true,buttons:[
	     {text:'支付成功',iconCls:'icon-ok',handler:function(){window.recyclePay();}},
	     {text:'取消',iconCls:'icon-cancel',handler:function(){$('#recycle_pay_div').dialog('close');}}]"
	     id="recycle_pay_div">
	    <div>
	        <div style="width:100%;height: 200px;text-align:center;">请使用支付宝扫码支付</div>
	    </div>
	</div>
</div>
<script type="text/javascript">
    var orderTF = true;
	function editJump(id){
//		if(id!=null&&id!=undefined){
//			var url = ctx+"/complaint/addComplaintOrderByPage?orderId="+id;
//			var title='创建新的投诉';
//			window.parent.parent.addTabIframe(url,title);
//		}
		window.open(ctx+"/complaint/addComplaintOrderByPage?orderId="+id+"&source="+$("#source").val());
	}
	function openImg(url){
		$('#imgDialog').dialog({
			title: '图片',
			width: 800,
			height: 500,
			closed: false,
			cache: false,
			content: "<img style=\"width:100%;\" src='"+url+"'>",
			modal: true
		});
	}


//生成支付二维码
function buildQrCod(){
	var sellprice = $("#sellprice").val();
	if(sellprice<=0){
		 $.messager.alert('提示', '卖出价格必须大于0');
		 return;
	}
	$("#recycle_pay_div").parent().show();
    $("#recycle_pay_div").dialog("open");
}

//上传图片
$("#uploadAccessPic").ajaxUpload({
    action:window.ctx + "/imgFileUpload" ,
    fileType : "pic",
    fileNum : 1,
    onComplete : function(file, data) {
       //alert("上传完成");
       initUploadButton();
       $uploadAccessPicParent = $("#uploadAccessPic").parent();
       var div = document.createElement("div");
       div.className="accessoryPic_divCls";

       var label = document.createElement("label");
       label.innerHTML="&nbsp;";
       div.appendChild(label);
       var img = document.createElement("img");
       $(img).attr("width", "60px").attr("height", "60px").attr("id", "displayimg1");
       img.src=data.lisitPath+data.url;

       $("#pic").val(data.url);
       div.appendChild(img);
       var a = document.createElement("a");
       a.id = "delete_article_img";
       div.appendChild(a);
       $uploadAccessPicParent.append(div);
       $("#uploadAccessPic").hide();
       $(a).linkbutton({
           iconCls: 'icon-remove',
           text : "删除",
           onClick: deleteUploadImg
       });
   }
}); 

//
function initUploadButton() {
    $("#uploadAccessPic").linkbutton({
        iconCls:'icon-upload'
    }); 
}

//删除图片
function deleteUploadImg(){
    $.messager.confirm("提示", "确定删除上传的头像吗？",function(r){
        if(r){
        	$("#pic").val("");
            $("#displayimg1").remove();
            $("#delete_article_img").remove();
            $("#uploadAccessPic").show();
        }
    });
}

//设备卖出
function recyclePay(){
	var sellprice = $("#sellprice").val();
	if(sellprice<=0){
		 $.messager.alert('提示', '卖出价格必须大于0');
		 return;
	}
	var recycleId = $.trim($("#recycleId").val());
	var sellprice = $("#sellprice").val();
	$.ajax({
		url: 'recyclePay',
	    type: 'post',
	    data: {
	  		sellprice: sellprice,
	      	recycleId: recycleId
	    },
	    dataType: 'JSON',
	    success: function (data) {
	        if (data.status == 0) {
			$('#recycle_pay_div').dialog('close');
				parent.showOrderInfo(recycleId);
			$.messager.show({
				title: '提示',
				msg: '设备卖出成功!'
			});
	        } else {
	            $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
	        }
	    }
	});
}



//填写回收支付记录
$("#paymentRecord").click(function () {
    $("#recycle_payment_record_div").parent().show();
    $("#recycle_payment_record_div").dialog("open");
});


//填写回收支付记录
function recyclePaymentRecord(){

	var recycleId = $.trim($("#recycleId").val());
	//var paymentType = $("#record_paymentType").children("option:selected").val();
	var serialNum = $.trim($("#serialNum").val());
	var pic = $.trim($("#pic").val());
	if(pic==''){
		$.messager.alert('提示', '请上传支付截图');
		return;
	}

	$.ajax({
		url: 'recyclePaymentRecord',
	    type: 'post',
	    data: {
	    	payPic: pic,
	  		serialNum: serialNum,
	    	payType: 0,
	      	recycleId: recycleId
	    },
	    dataType: 'JSON',
	    success: function (data) {
	        if (data.status == 0) {
			$('#update_recycle_receiving_div').dialog('close');
				parent.showOrderInfo(recycleId);
			$.messager.show({
				title: '提示',
				msg: '填写回收支付记录成功!'
			});
	        } else {
	            $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
	        }
	    }
	});
}



var categoryId= '${recycle.deviceCategory.id}';
var deviceId= '${recycle.deviceId}';
var brandId='${recycle.brand.id}';
var color= '${recycle.color}';
var bankName= '${recycle.userPayment.bank}';
//修改设备信息
$("#updateRecycleDevice").click(function () {
    $("#update_recycle_device_div").parent().show();
    $("#update_recycle_device_div").dialog("open");
	getDeviceCategory();
	getBrands(categoryId);
	getDevices(brandId,categoryId);
	getAttribute(categoryId,deviceId);
   /* getDevices('${recycle.brand.id}');*/
  /*  getColors('${recycle.brand.id}','${recycle.deviceId}');*/
});
//重新估价
function getValuation(){

	var waigaunSelects=$("#waigaunAttr select");
	var baseSelects=$("#baseAttr select");
	var gongnengSelects=$("#gongnengAttr select");
	var attributeValues="";
	var isValue=true;

	if(waigaunSelects.length>0){
		for(var i=0;i<waigaunSelects.length;i++){
			var id=	waigaunSelects[i].options[waigaunSelects[i].options.selectedIndex].value;
			if(id!=""){
				attributeValues+=id;
				attributeValues+=",";
			}else{
				isValue=false;
			}
		}
	}

	if(baseSelects.length>0){
		for(var i=0;i<baseSelects.length;i++){
			var id=	baseSelects[i].options[baseSelects[i].options.selectedIndex].value;
			if(id!=""){
				attributeValues+=id;
				attributeValues+=",";
			}else{
				isValue=false;
			}
		}
	}
	if(gongnengSelects.length>0){
		for(var i=0;i<gongnengSelects.length;i++){
			var id=	gongnengSelects[i].options[gongnengSelects[i].options.selectedIndex].value;
			if(id!=""){
				attributeValues+=id;
				attributeValues+=",";
			}
		}
	}
	var recycleId = $.trim($("#recycleId").val());
	var deviceId = $("#deviceId").children('option:selected').val();

	var box=document.getElementsByName("checkbox");
	for(var i=0;i<box.length;i++){
		if(box[i].checked == true){
			attributeValues+=box[i].value+",";
		}
	}
	if(!isValue){
		$.messager.alert('提示', '请选择所有的基础信息和外观信息!');
		return;
	}
	$.ajax({
        url: 'getValuation',
        type: 'post',
        data: {
        	deviceId: deviceId,
			attributeValues: attributeValues,
            recycleId: recycleId
        },
        dataType: 'JSON',
        success: function (data) {
            if (data.status == 0) {
                console.log("设备报价："+data.price);
                if(Number(data.price) >= 0 ){
                    $("#valuation").val(data.price);
                }else{
                    $.messager.alert('提示', "该设备暂时没有报价", 'error');
                }
            } else {
                $.messager.alert('提示', data.msg, 'error');
            }
        }
    });
}


//修改设备信息
function updateRecycleDevice(){
	var waigaunSelects=$("#waigaunAttr select");
	var baseSelects=$("#baseAttr select");
	var gongnengSelects=$("#gongnengAttr select");
	var attributeValues="";
	var desc="";
	var isValue=true;
	if(waigaunSelects.length>0){
		for(var i=0;i<waigaunSelects.length;i++){
			var id=	waigaunSelects[i].options[waigaunSelects[i].options.selectedIndex].value;
			var text=	waigaunSelects[i].options[waigaunSelects[i].options.selectedIndex].text;
			if(id!=""){
				attributeValues+=id;
				attributeValues+=",";
				desc+=text;
				desc+="|";
			}else{
				isValue=false;
			}
		}
	}

	if(baseSelects.length>0){
		for(var i=0;i<baseSelects.length;i++){
			var id=	baseSelects[i].options[baseSelects[i].options.selectedIndex].value;
			var text=	baseSelects[i].options[baseSelects[i].options.selectedIndex].text;
			if(id!=""){
				attributeValues+=id;
				attributeValues+=",";
				desc+=text;
				desc+="|";
			}else{
				isValue=false;
			}
		}
	}
	if(gongnengSelects.length>0){
		for(var i=0;i<gongnengSelects.length;i++){
			var id=	gongnengSelects[i].options[gongnengSelects[i].options.selectedIndex].value;
			var text=	gongnengSelects[i].options[gongnengSelects[i].options.selectedIndex].text;
			if(id!=""){
				attributeValues+=id;
				attributeValues+=",";
				desc+=text;
				desc+="|";
			}
		}
	}
	var recycleId = $.trim($("#recycleId").val());
	var deviceId = $("#deviceId").children('option:selected').val();
	var deviceName = $("#deviceId").children('option:selected').text();
	var price = $.trim($("#valuation").val());
	var box=document.getElementsByName("checkbox");
	for(var i=0;i<box.length;i++){
		if(box[i].checked == true){
			attributeValues+=box[i].value+","
			desc+=box[i].alt+"|";
		}
	}

	if(price==""){
		$.messager.alert('提示', '请先进行估价!');
		return;
	}
	if(!isValue){
		$.messager.alert('提示', '请选择所有的基础信息和外观信息!');
		return;
	}
		$.ajax({
			url: 'updateRecycleDevice',
			type: 'post',
			data: {
				deviceId: deviceId,
				deviceName: deviceName,
				desc: desc,
				price:price,
				attributeIds:attributeValues,
				recycleId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#update_recycle_receiving_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '修改设备信息成功!'
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
}


$("select[name='deviceCategoryId']").change(function(){
	getBrands($(this).children('option:selected').val());
});

$("select[name='brandId']").change(function(){
    getDevices($(this).children('option:selected').val(),$("select[name='deviceCategoryId']").children('option:selected').val());
});

$("select[name='deviceId']").change(function(){
	getAttribute($("select[name='deviceCategoryId']").children('option:selected').val(),$(this).children('option:selected').val());
});


//获取银行信息
function getBankList(){
	$.ajax({
		type: "POST",
		url:"getBankList",
		dataType: "json",
		success: function(data) {
			var banks=data.banks;
			$("select[name='bankName']").empty();
			if(null!=banks && banks.length>0){
				for(var i=0;i<banks.length;i++){
					if(bankName==banks[i]){
						$("select[name='bankName']").append("<option categoryId='"+1+"' selected='selected' value='"+banks[i]+"'>"+banks[i]+"</option>");
					}else{
						$("select[name='bankName']").append("<option categoryId='"+1+"' value='"+banks[i]+"'>"+banks[i]+"</option>");
					}
				}
			}
		}
	});
}

//获取分类
function getDeviceCategory(){
    $.ajax({
        type: "POST",
        url:"getCategory.json",
        dataType: "json",
        success: function(data) {
            var deviceCategoryList=data.deviceCategoryList;
            $("select[name='deviceCategoryId']").empty();
            //$("select[name='brandId']").empty();
            if(null!=deviceCategoryList && deviceCategoryList.length>0){
                for(var i=0;i<deviceCategoryList.length;i++){
					if(deviceCategoryList[i].fid!=-1){
						if(categoryId==deviceCategoryList[i].id){
							$("select[name='deviceCategoryId']").append("<option deviceCategoryId='"+1+"' selected='selected' value='"+deviceCategoryList[i].id+"'>"+deviceCategoryList[i].name+"</option>");
						}else{
							$("select[name='deviceCategoryId']").append("<option deviceCategoryId='"+1+"' value='"+deviceCategoryList[i].id+"'>"+deviceCategoryList[i].name+"</option>");
						}
					}
                }
            }
        }
    });
}


//根据设备分类获取品牌
function getBrands(categoryId){
	$.ajax({
		type: "POST",
		url:"geBrands",
		dataType: "json",
		data:{categoryId:categoryId},
		success: function(data) {
			var brands=data.brands;
			$("select[name='brandId']").empty();
			//$("select[name='deviceId']").empty();
			if(null!=brands && brands.length>0){
				for(var i=0;i<brands.length;i++){
					if(brandId==brands[i].id){
						$("select[name='brandId']").append("<option categoryId='"+categoryId+"' selected='selected' value='"+brands[i].id+"'>"+brands[i].name+"</option>");
					}else{
						$("select[name='brandId']").append("<option categoryId='"+categoryId+"' value='"+brands[i].id+"'>"+brands[i].name+"</option>");
					}
				}
			}
		}
	});
}


//根据品牌Id获取设备型号
function getDevices(brandId,categoryId){
	$.ajax({
		type: "POST",
		url:"getDevices.json",
		dataType: "json",
		data:{brandId:brandId,categoryId:categoryId},
		success: function(data) {
			var devices=data.devices;
			$("select[name='deviceId']").empty();
		/*	$("select[name='color']").empty();*/
			if(null!=devices && devices.length>0){
				for(var i=0;i<devices.length;i++){
					if(deviceId==devices[i].id){
						$("select[name='deviceId']").append("<option brandId='"+brandId+"' selected='selected' value='"+devices[i].id+"'>"+devices[i].model+"</option>");
					}else{
						$("select[name='deviceId']").append("<option brandId='"+brandId+"' value='"+devices[i].id+"'>"+devices[i].model+"</option>");
					}
				}
			}
		}
	});
}


//设备属性值
function getAttribute(categoryId,deviceId){
	$.ajax({
		type: "POST",
		url:"attribute",
		dataType: "json",
		data:{categoryId:categoryId,deviceId:deviceId},
		success: function(data) {
			var recycleAttributeList=data.recycleAttributeList;
			if(recycleAttributeList.length>0){
				$("#waigaunAttr").empty();
				$("#baseAttr").empty();
				$("#gongnengAttr").empty();
				for(var i=0 ;i<recycleAttributeList.length;i++){
					var attr = recycleAttributeList[i];
					if(attr.type==1){
						var html = generateSelect(attr);
						$("#baseAttr").append(html);

					}else if(attr.type==3){
						var html = generateSelect(attr);
						$("#waigaunAttr").append(html);
					}else if(attr.type==2){
						var html = generateCheckbox(attr);
						$("#gongnengAttr").append(html);
					}
				}
			}
		}
	});
}
function generateSelect(attr){
	var attrId = attr.id;
	var attrName = attr.name;
	var attrType = attr.type;
	var attrVals = attr.deviceRecycleAttributeValueList;
	if(attrVals.length==0){
		return "";
	}
	var select = "<select  style='width: 145px;height: 23px;'data-options=' required:true,editable:false'><option value=''>"+attrName+"</option>";
	for(var i=0;i<attrVals.length;i++){
		select += "<option value='"+attrVals[i].id+"'>"+attrVals[i].attributeValue+"</option>";
	}
	select +="</select>";
	return select;
}
function generateCheckbox(attr){
	var attrId = attr.id;
	var attrName = attr.name;
	var attrType = attr.type;
	var attrVals = attr.deviceRecycleAttributeValueList;
	if(attrVals.length==0){
		return "";
	}
	var checkbox = "";
	for(var i=0;i<attrVals.length;i++){
		checkbox += "<input type='checkbox' name='checkbox'alt='"+attrVals[i].attributeValue +"' value='"+attrVals[i].id+"'>"+attrVals[i].attributeValue+"</input>";
	}
	return checkbox;
}

//根据设备型号和品牌Id获取设备颜色
function getColors(brandId,deviceId){
    $.ajax({
        type: "POST",
        url:"getColors",
        dataType: "json",
        data:{brandId:brandId,deviceId:deviceId},
        success: function(data) {
            var colirs=data.colors;
            $("select[name='color']").empty();
            if(colirs.length>0){
                for(var i=0;i<colirs.length;i++){
                	if(color==colirs[i]){
                		$("select[name='color']").append("<option value='"+colirs[i]+"' selected='selected' >"+colirs[i]+"</option>");
                	}else{
                		$("select[name='color']").append("<option value='"+colirs[i]+"'>"+colirs[i]+"</option>");
                	}
                }
            }
        }
    });
}

//修改收款人信息
$("#updateRecycleReceiving").click(function () {
    $("#update_recycle_receiving_div").parent().show();
    $("#update_recycle_receiving_div").dialog("open");
});

//选择支付方式   控制显示隐藏的内容
function payment(){
	var paymentType = $("#paymentType").children("option:selected").val();
	if(paymentType==3){
		getBankList();
		$(".bank").show();
	}else{
		$(".bank").hide();
	}
}

//修改收款人信息
function updateRecycleReceiv(){
	var recycleId = $.trim($("#recycleId").val());
	var paymentType = $("#paymentType").children("option:selected").val();
	var accountName = $.trim($("#accountName").val());
	var fnum = $.trim($("#fnum").val());
	var bankName = $.trim($("#bankName").val());

	//银行
	if(paymentType==3) {
		if (bankName == '') {
			$.messager.alert('提示', '请填写收款银行');
			return;
		}
	}
	if (accountName == '') {
		$.messager.alert('提示', '请填写姓名');
		return;
	}

	if (fnum == '') {
		$.messager.alert('提示', '请填写账号');
		return;
	}

	$.ajax({
        url: 'updateRecycleReceiv',
        type: 'post',
        data: {
        	account: fnum,
			accountName: accountName,
        	bankName: bankName,
        	paymentType: paymentType,
            recycleId: recycleId
        },
        dataType: 'JSON',
        success: function (data) {
            if (data.status == 0) {
				$('#update_recycle_receiving_div').dialog('close');
					parent.showOrderInfo(recycleId);
				$.messager.show({
					title: '提示',
					msg: '修改收款人信息成功!'
				});
            } else {
                $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
            }
        }
    });
}

/**增加客户修改时间*/
$("#repairForm").form({
	url: "updateOrderOnsiteRepair",
	onSubmit: function (param) {
		if($("#datelay").children("option:selected").val()!=-1 ){
			if($("#beginTime").children("option:selected").val()!=-1 ){
				if ($("#endTime").children("option:selected").val()!=-1){
					param.startDate = $("#datelay").children("option:selected").val() + ' ' + $("#beginTime").children("option:selected").val();
					param.endDate = $("#datelay").children("option:selected").val() + ' ' + $("#endTime").children("option:selected").val();
					return true;
				}else{
					$.messager.alert("提示", "请选择结束时间!");
					return false;
				}
			}else{
				$.messager.alert("提示", "请选择开始时间!");
				return false;
			}
		}else{
			$.messager.alert("提示", "请选择上门日期!");
			return false;
		}
	},
	success: function (data) {
		$.messager.progress("close");
		data = $.parseJSON(data);
		if (data.status == 0) {
			$.messager.show({
				title: "提示",
				msg: "修改上门时间成功!"
			});
			$("#updateOrderOnsiteRepairDiv").dialog("close");
			parent.showOrderInfo("${recycle.id}");
		} else {
			$.messager.alert("提示", "服务器发送异常错误,请联系系统管理员!", "error");
		}
	}
});


//关闭订单
$("#closeRecycle").click(function () {
    $("#close_recycle_div").parent().show();
    $("#close_recycle_div").dialog("open");
});

//回收失败
$("#failRecycle").click(function () {
	$("#fail_recycle_div").parent().show();
	$("#fail_recycle_div").dialog("open");
});
//客服确认失败 gome-取消订单
$("#realyfailRecycle").click(function () {
	$("#fail_realyfailRecycle_div").parent().show();
	$("#fail_realyfailRecycle_div").dialog("open");
});

//评估完成
$("#assessSuccess").click(function () {
	$("#assess_recycle_div").parent().show();
	$("#assess_recycle_div").dialog("open");
});
//确认方案
$("#program").click(function () {
	$("#program_recycle_div").parent().show();
	$("#program_recycle_div").dialog("open");
});

//审核
$("#audiRecycle").click(function () {
	$("#audi_recycle_div").parent().show();
	$("#audi_recycle_div").dialog("open");
});
//指派上门
$("#assignDoorRecycle").click(function () {
	$("#assignDoor_recycle_div").parent().show();
	$("#assignDoor_recycle_div").dialog("open");
});

//指派评估工程师
$("#assignDoorRecycle1").click(function () {
	$("#assignDoor_recycle_div1").parent().show();
	$("#assignDoor_recycle_div1").dialog("open");
});
//完成回收
$("#successRecycle").click(function () {
	$("#successr_recycle_div").parent().show();
	$("#success_recycle_div").dialog("open");
});


//转邮寄
$("#updateSendRecycle").click(function () {
	$("#updateSend_recycle_div").parent().show();
	$("#updateSend_recycle_div").dialog("open");
});

//完成回收
$("#confirmRecycle").click(function () {
	$("#confirm_recycle_div").parent().show();
	$("#confirm_recycle_div").dialog("open");
});
//回寄设备
$("#returnDevice").click(function () {
	$("#return_recycle_div").parent().show();
	$("#return_recycle_div").dialog("open");
});
//关闭回收订单
function closeRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#close_recycle_ramark').val());
	var msg = $('#messageTemp').combobox('getValue');
    if(msg==''){
		 $.messager.alert('提示', '请选择关闭原因');
		 return;
	}else{
		$.ajax({
            url: 'closeRecycle',
            type: 'post',
            data: {
            	msg: msg,
                remark: ramark,
                recycleId: recycleId
            },
            dataType: 'JSON',
            success: function (data) {
                if (data.status == 0) {
					$('#close_recycle_div').dialog('close');
 					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '关闭订单成功!'
					});
                } else {
                    $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
                }
            }
        });
	}
}


//回收失败
function failRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#fail_recycle_ramark').val());
	var msg = $('#message').combobox('getValue');
	if(msg ==''){
		$.messager.alert('提示', '请选择回收失败原因');
		return;
	}else{
		$.ajax({
			url: 'failRecycle',
			type: 'post',
			data: {
				msg: msg,
				remark: ramark,
				recycleId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#fail_recycle_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '修改为回收失败成功!'
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
	}
}

function realyfailRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#fail_recycle_ramark_realy').val());
	var msg = $('#overmessage').combobox('getValue');
	if(msg ==''){
		$.messager.alert('提示', '请选择回收失败原因');
		return;
	}else{
        if(orderTF) {
            orderTF = false;
            $.ajax({
                url: 'realyfailRecycle',
                type: 'post',
                data: {
                    msg: msg,
                    remark: ramark,
                    recycleId: recycleId
                },
                dataType: 'JSON',
                success: function (data) {
                    if (data.status == 0) {
                        $('#fail_realyfailRecycle_div').dialog('close');
                        parent.showOrderInfo(recycleId);
                        $.messager.show({
                            title: '提示',
                            msg: '修改为回收失败成功!'
                        });
                    } else {
                        $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
                    }
                    orderTF = true;
                }
            });
        }
	}
}

//确认方案
function program() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#program_recycle_ramark').val());
	$.ajax({
		url: 'program',
		type: 'post',
		data: {
			remark: ramark,
			orderId: recycleId
		},
		dataType: 'JSON',
		success: function (data) {
			if (data.status == 0) {
				$('#program_recycle_div').dialog('close');
				parent.showOrderInfo(recycleId);
				$.messager.show({
					title: '提示',
					msg: '修改成功!'
				});
			} else {
				$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
			}
		}
	});
}
//评估完成
function assessSuccess() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#assess_recycle_ramark').val());
		$.ajax({
			url: 'assessSuccess',
			type: 'post',
			data: {
 				remark: ramark,
				orderId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#assess_recycle_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '修改成功!'
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
}


//审核通过
function audiRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#audi_recycle_ramark').val());
		$.ajax({
			url: 'audiRecycle',
			type: 'post',
			data: {
				remark: ramark,
				recycleId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#audi_recycle_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '审核订单成功!'
					});
				} else if(data.status == -2){
                    layer.alert('订单已审核，请勿重复操作!', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                    }, function(){
                        window.location.reload();
                    });
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
}

//确认收货
function confirmRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var expressSn = $.trim($('#expressSn1').val());
	var expriessId = $('#messageTemp2').combobox('getValue');
	if(expressSn==''){
		$.messager.alert('提示', '请输入快递号');
		return;
	}else{
		$.ajax({
			url: 'confirmReceipt',
			type: 'post',
			data: {
				express: expriessId,
				expressSn: expressSn,
				orderId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#confirm_recycle_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '修改为回收失败成功!'
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
	}
}

//回寄设备
function returnDevice() {
	var recycleId = $.trim($("#recycleId").val());
	var expressSn = $.trim($('#expressSn').val());
	var expriessId = $('#express').combobox('getValue');
	var ramark = $.trim($('#return_recycle_ramark').val());
	if(expressSn==''){
		$.messager.alert('提示', '请输入快递号');
		return;
	}else{
		$.ajax({
			url: 'returnDevice',
			type: 'post',
			data: {
				express: expriessId,
				expressSn: expressSn,
				orderId: recycleId,
				ramark:ramark
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#return_recycle_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '回寄成功!'
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
	}
}

//转邮寄
function updateSendRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#updateSend_recycle_ramark').val());
	var serviceCenter = $('#serviceCenter').combobox('getValue');
	if(serviceCenter==''){
		$.messager.alert('提示', '请选择回收中心');
		return;
	}else{
		$.ajax({
			url: 'updateSendRecycle',
			type: 'post',
			data: {
				serviceId: serviceCenter,
				recycleId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					$('#updateSend_recycle_div').dialog('close');
					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '转邮寄成功!'
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
		});
	}
}
function assignDoor(recycleId){
	$("#assignDoor_recycle_div").parent().show();
	$("#assignDoor_recycle_div").dialog("open");
}
parent.showOrderInfo = showOrderInfo =function (orderId) {
	window.location.reload();
}

//指派上门
function assignDoorRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#assignDoor_recycle_ramark').val());
	var equipmentId = $.trim($("#startToorRepairEquipment").combobox("getValue"));
	if (equipmentId == '' || equipmentId == '请选择工程师') {
		$.messager.alert("提示", "请选择回收工程师");
	}else{
		$.messager.progress();
		var assginState = $("#assginState").val();
		$.post("assignDoor", {
			orderId: recycleId,
			engineerId: equipmentId,
			remark: ramark,
			assginState : assginState
		}, function (data) {
			$.messager.progress("close");
			$("#assginState").val(0);
			if (data.status == 0) {
				$.messager.show({
					title: "提示",
					msg: "修改成功"
				});
				parent.showOrderInfo(recycleId);
			} else {
				$.messager.alert("提示", "服务器发生错误,请联系系统管理员!", "error");
			}
		}, "JSON");
	}
}


//指派评估工程师
function assignDoorRecycle1() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#assignDoor_recycle_ramark1').val());
	var equipmentId = $.trim($("#startToorRepairEquipment").combobox("getValue"));
	if (equipmentId == '' || equipmentId == '请选择工程师') {
		$.messager.alert("提示", "请选择回收工程师");
	}else{
		$.messager.progress();
		var assginState = $("#assginState").val();
		$.post("assess", {
			orderId: recycleId,
			engineerId: equipmentId,
			remark: ramark,
			assginState : assginState
		}, function (data) {
			$.messager.progress("close");
			$("#assginState").val(0);
			if (data.status == 0) {
				$.messager.show({
					title: "提示",
					msg: "修改成功"
				});
				parent.showOrderInfo(recycleId);
			} else {
				$.messager.alert("提示", "服务器发生错误,请联系系统管理员!", "error");
			}
		}, "JSON");
	}
}

//完成回收
function successRecycle() {
	var recycleId = $.trim($("#recycleId").val());
	var ramark = $.trim($('#success_recycle_ramark').val());
		$.messager.progress();
		$.post("successRecycle", {
			recycleId: recycleId,
			remark: ramark,
			status : 2300
		}, function (data) {
			$.messager.progress("close");
			$("#assginState").val(0);
			if (data.status == 0) {
				$.messager.show({
					title: "提示",
					msg: "修改成功"
				});
				parent.showOrderInfo(recycleId);
			} else {
				$.messager.alert("提示", "服务器发生错误,请联系系统管理员!", "error");
			}
		}, "JSON");
}


//修改上门时间

function updateOrderOnsiteRepair(orderId) {
	$("#updateOrderOnsiteRepairDiv").window("open");
}


//改价
$("#updatePrice").click(function () {
    $("#update_price").parent().show();
    $("#update_price").dialog("open");
});
//修改订单价格
function updatePrice() {
	var recycleId = $.trim($("#recycleId").val());
	var price = $("#price").val();
	var ramark = $.trim($('#update_price_ramark').val());
	if(price<=0){
		 $.messager.alert('提示', '回收价格必须大于0');
		 return;
	}else{
		$.ajax({
            url: 'updateRecyclePrice',
            type: 'post',
            data: {
            	price: price,
                remark: ramark,
                recycleId: recycleId
            },
            dataType: 'JSON',
            success: function (data) {
                if (data.status == 0) {
					$('#update_price').dialog('close');
 					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '修改价格成功!'
					});
                } else {
                    $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
                }
            }
        });
	}
}


//添加备注
$("#addRamark").click(function () {
    $("#recycle_ramark").parent().show();
    $("#recycle_ramark").dialog("open");
});
//保存备注
function saveRecycleRamark() {
	var recycleId = $.trim($("#recycleId").val());
    var ramark = $.trim($('#recycle_ramark_content').val());
	if(ramark==''){
		$.messager.alert('提示', '请输入备注内容');
        return false;
	}else{
		$.ajax({
            url: 'addRecycleRamark',
            type: 'post',
            data: {
                remark: ramark,
                recycleId: recycleId
            },
            dataType: 'JSON',
            success: function (data) {
                if (data.status == 0) {
					$('#recycle_ramark').dialog('close');
 					parent.showOrderInfo(recycleId);
					$.messager.show({
						title: '提示',
						msg: '备注信息保存成功!'
					});
                } else {
                    $.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
                }
            }
        });
	}
}

function updateRecycleStatus(status){
	fillReason("请填写审核通过原因", function (fr) {
		var recycleId = $.trim($("#recycleId").val());
		$.ajax({
			url: 'updateRecycleStatus',
			type: 'post',
			data: {
				status: status,
				recycleId: recycleId
			},
			dataType: 'JSON',
			success: function (data) {
				if (data.status == 0) {
					parent.showOrderInfo(recycleId);
					var remark="";
					if(status==1100){
						remark ="关闭成功!";
					}
					if(status==1030){
						remark ="入库成功!";
					}
					if(status==1010){
						remark ="重启成功!";
					}
					if(status==1020){
						remark ="支付成功!";
					}

					$.messager.show({
						title: '提示',
						msg: remark
					});
				} else {
					$.messager.alert('提示', '服务器发送异常错误,请联系管理员', 'error');
				}
			}
	});
	});
}


function examineOrder(orderId) {
	fillReason("请填写审核通过原因", function (fr) {
		var recycleId = $.trim($("#recycleId").val());
		$.post("updateRecycleStatus", {
			recycleId: recycleId,
			remark: fr,
			status: 1010
		}, function (data) {
			if (data.status == 0) {
				$.messager.show({
					title: '提示',
					msg: '您已审核该订单',
					timeout: 3000,
					showType: 'slide'
				});
				parent.showOrderInfo(orderId);
			} else {
				$.messager.alert("提示", "服务器发送异常错误,请联系系统维护人员!", "error");
			}
		}, "JSON");
	});
}


//加9拨打电话
function call9(mobile) {
	document.title='<BCCMD>BCCMDDIAL,9'+mobile;
	try{
        parent.document.title="<BCCMD>BCCMDDIAL,9"+mobile;
	}catch(e){}
    try {
        parent.parent.document.title="<BCCMD>BCCMDDIAL,9"+mobile;
    }catch(e){}
    setTimeout(function(){parent.parent.document.title="国美管理系统"},3000);
}

//加90拨打电话
function call90(mobile) {
    document.title='<BCCMD>BCCMDDIAL,90'+mobile;
    try{
        parent.document.title="<BCCMD>BCCMDDIAL,90"+mobile;
    }catch(e){}
    try {
        parent.parent.document.title="<BCCMD>BCCMDDIAL,90"+mobile;
    }catch(e){}
    setTimeout(function(){parent.parent.document.title="国美管理系统"},3000);
}

/**
 *
 * @param tip:填写原因的提示信息
 * @param callback:填写完成后的回调
 *                 返回false可阻止弹出原因对话框关闭
 */
function fillReason(tip, callback) {
	if(callback == undefined || callback == null) {
		callback = function(){};
	}
	var $fillReason = $("#fillReason");
	$fillReason.dialog("open");
	var $fillReasonTextarea = $fillReason.find("#fillReasonTextarea");
	$fillReasonTextarea.attr("tipContent", tip);
	$fillReasonTextarea.css("color", "#CCC").val(tip);
	window.fillReasonCallback = callback;
}

/**
 * @param tip:填写原因的提示信息
 * @param callback:填写完成后的回调
 *                 返回false可阻止弹出原因对话框关闭
 *@Param isNull : true:不必填(默认) false:必填
 */
function fillReason(tip, callback, isNull, assginState) {
	if (isNull == undefined || isNull == null) {
		isNull = true;
	}
	if (callback == undefined || callback == null) {
		callback = function () {
		};
	}
	var $fillReason = $("#fillReason");
	$("#fillReasonTextarea_div").empty();
	$("#fillReasonTextarea_div").append("<textarea id='fillReasonTextarea'  class='' style='width: 380px;height: 100px;' ></textarea>");
	if(assginState){
		$("#fillReasonTextarea_div").append("<input type='checkbox' style='display: none' checked='checked' id='qzzp' name='qzzp'  value='2' /><label for='qzzp' class='gray'></label>");
	}
	var $fillReasonTextarea = $fillReason.find("#fillReasonTextarea");
	$fillReasonTextarea.attr("placeholder", tip);
	$fillReasonTextarea.validatebox({
		required: !isNull,
		missingMessage: tip,
		tipPosition: 'left'
	});
	$fillReason.dialog("open");
	$fillReasonTextarea.attr("isNull", isNull);
	if (isNull) {
		$fillReasonTextarea.attr("tipContent", tip);
	} else {
		$fillReasonTextarea.attr("tipContent", "");
	}
	if(assginState){
		$("#qzzp").change(function () {
			if (this.checked) {
				$("#assginState").val(1);
			} else {
				$("#assginState").val(0);
			}
		});
	}
	window.fillReasonCallback = callback;
}


/**
 *  已指派状态到店清洗变更工程师信息
 */
function arriveStorefrontRepairUpdate() {
	var equipmentId = $.trim($("#cityUpdateDoorEng").combobox("getValue"));
	var orderId = $("#orderUpdatDoorId").val();
	if (equipmentId == '' || equipmentId == '请选择工程师') {
		$.messager.alert("提示", "请选择清洗工程师");
	} else {
		fillReason("请输入推送给清洗工程师的消息(如客户要求)...", function (fn) {
			$.messager.progress();
			$.post("arriveStorefrontRepairUpdate", {
				orderId: orderId,
				engineerId: equipmentId,
				remark: fn
			}, function (data) {
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "修改成功"
					});
					$.messager.progress("close");
					$("#updateDoorEngDiv").dialog("close");
					parent.showOrderInfo(orderId);
				} else if(data.status == 1){
					$.messager.alert("提示", "工程师所在清洗中心不支持到店清洗,重新工程师指派失败!", "warning");
					$.messager.progress("close");
				} else {
					$.messager.alert("提示", "服务器发生错误,请联系系统管理员!", "error");
					$.messager.progress("close");
				}
			}, "JSON");
		});
	}
}
/**
 * 修改用户信息
 */
function updateOrderUserInfo(userName, telPhone, city, userid, orderid, cityid) {
	var cityNa = city;
	var cityName = new Array();
	var cityNameNew = new Array();
	cityName = cityNa.split(" ");
	var j = 0;
	for (var i = 0; i < cityName.length; i++) {
		if (null != cityName[i] && "" != cityName[i].trim()) {
			cityNameNew[j] = cityName[i];
			j++;
		}
	}
	var pri = cityNameNew[0];
	var ci = cityNameNew[1];
	var di = cityNameNew[2];

	$('#updateOrderUser_form_ #city').combobox('setValue', cityid.trim());
	$('#updateOrderUser_form_ #city').combobox('setText', ci);

	$('#updateOrderUser_form_ #dist').combobox('setValue', di);
	$('#updateOrderUser_form_ #provinceId').combobox('setValue', pri);

	$("#updateOrderUser_form_ #userName").val(userName.trim());
	$("#updateOrderUser_form_ #telPhone").val(telPhone.trim());
	$("#updateOrderUser_form_ #addRess").val($('#tmpAddress').val());
	$("#updateOrderUser_form_ #userid").val(userid.trim());
	$("#updateOrderUser_form_ #orderid").val(orderid.trim());
	$("#updateOrderUserInfoDiv").window("open");
}
function updateDoorEng() {
	$("#updateDoorEngDiv").window("open");
}
/**
 *已指派工程师变更上门回收
 */
function assignDoorByUpdate() {
	var equipmentId = $.trim($("#cityUpdateDoorEng").combobox("getValue"));
	var orderId = $("#orderUpdatDoorId").val();
	if (equipmentId == '' || equipmentId == '请选择工程师') {
		$.messager.alert("提示", "请选择回收工程师");
	} else {
			$.messager.progress();
			var assginState = $("#assginState").val();
			$.post("assignDoorByUpdate", {
				orderId: orderId,
				engineerId: equipmentId,
				assginState : assginState
			}, function (data) {
				$.messager.progress("close");
				$("#assginState").val(0);
				if (data.status == 0) {
					$.messager.show({
						title: "提示",
						msg: "修改成功"
					});
					$("#updateDoorEngDiv").dialog("close");
					parent.showOrderInfo(orderId);
				} else {
					$.messager.alert("提示", "服务器发生错误,请联系系统管理员!", "error");
				}
			}, "JSON");
	}
}
//客户收货
function clientConfirmReceipt(orderId) {
		$.post("clientConfirmReceipt", {
			orderId: orderId
		}, function (data) {
			var status = data.status;
			if (status == 0) {
				$.messager.show({
					title: "提示",
					msg: "修改状态为顾客已收货成功!"
				});
				parent.showOrderInfo(orderId);
			} else {
				$.messager.alert("提示", "服务器发生错误,请联系系统管理员!", "error");
			}
		}, "JSON");
}

function distributeToCp(orderId) {
	$.ajax({
		url : ctx+"/cpInfo/changeCpBySerType",
		data:{serType:4},
		type:"post",
		dataType:"json",
		success: function (data) {
			$("#my_cplist option").remove();
			/*console.info(data);*/
			$('#my_cplist').html();
			$.each(data.rows,function(i,n) {
				if(n.status==1) {
					$('#my_cplist').append("\<option id\='"+ n.id+"'\>" + n.name + "\<\/option\>");
				}
			});
		}
	});

	$("#distributeToCpDiv").window("open");
}

function my_submit(){
	var cpid = $("#my_cplist option:selected").attr("id");
	$.ajax({
		url : ctx+"/recycle/changeOrderCp",
		data:{
			orderId :'${recycle.id}' ,
			cpId: cpid
		},
		type:"post",
		dataType:"json",
		success: function (data) {
			var status =data.status;
			if(status==1){
				$.messager.show({
					msg : "更新成功",
					title : '成功'
				})
				$('#distributeToCpDiv').dialog('close');
				parent.showOrderInfo('${recycle.id}');
			}else{
				$.messager.show({
					msg : "更新失败",
					title : '失败'
				})
			}

		}
	});
}
</script>