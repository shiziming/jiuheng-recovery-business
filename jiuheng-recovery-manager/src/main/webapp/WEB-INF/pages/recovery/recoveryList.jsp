<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="s" uri="/tmg/tag" %>
<%@ include file="../order/orderStatus.jsp" %>
<div class="panel datagrid" style="width: auto;">
	<div class="datagrid-wrap panel-body panel-body-noheader" title="" style="width: auto; height: auto;">
		<form id="search_form" name="search_form">
			<div id="articleTableSearchId" class="datagrid-toolbar" style="padding:3px">
				<div>
					<span>支付:</span><input name="paymentStartTime" id="paymentStartTime" type="text" style="width:110px">-<input type="text" name="paymentEndTime" id="paymentEndTime" style="width:110px">
				    <span>完成:</span><input name="finishStartDate" id="finishStartDate" type="text" style="width:110px">-<input type="text" name="finishEndDate" id="finishEndDate" style="width:110px">
				    <span>提交时间:</span><input name="startTime" id="startTime" type="text" style="width:110px">-<input type="text" name="endTime"  id="endTime" style="width:110px">
				    <span>订单号:</span><input name="recycleId" id="recycleId" type="text" value="${orderId}">
				    <span>第三方订单号:</span><input name="thirdOrderId" id="thirdOrderId" type="text" onkeyup="value=value.replace(/[^\w\,]/ig,'')" maxlength="36">
				    <%--<span>回收人:</span><input name="engineerName" id="engineerName" type="text" value="${orderId}" style="width:150px">--%>
				    <span>手机:</span><input name="mobile" id="mobile" type="text" value="" style="width:150px">
					<span>姓名:</span><input type="text" name="userName" id="userName" style="width:80px">

					<span>状态:</span><input name="status" id="orderStatus" type="text" style="width:150px">
					<span>品类:</span>
					<select id="category_sel" name="categoryId" class="easyui-combobox" data-options="editable:false">
						<option value="">全部</option>
						<c:forEach items="${deviceCategories}" var="ca">
							<c:if test="${ca.fid!=-1}">
							<option value="${ca.id}">${ca.name}</option>
							</c:if>
						</c:forEach>
					</select>
				    <span>品牌:</span>
				    <select id="brand_sel" name="brandId" class="easyui-combobox" data-options="editable:false,onSelect:function(rec){
				        var brandId = $('#brand_sel').combobox('getValue');
				        var url =ctx+ '/order/showDevice?brandId='+brandId;
				        $('#device_sel').combobox('clear');
				        	if(brandId != 0){
				            	$('#device_sel').combobox('reload', url);
				          	}
				        }">
				        <option value="">全部</option>
				        <c:forEach items="${branceRec}" var="brand">
				            <option value="${brand.id}">${brand.name}</option>
				        </c:forEach>
				    </select>
					<span>责任客服:</span>
					<select name="adminId" style="width:80px">
						<option value="" >全部</option>
						<c:forEach items="${adminlist}" var="admin">
							<option value="${admin.id}">${admin.username}</option>
						</c:forEach>
					</select>
					<span>订单来源:</span>
					<select name="sources" style="width:80px">
						<option value="" >全部</option>
						<c:forEach items="${orderSources}" var="sources">
							<option value="${sources.id}">${sources.name}</option>
						</c:forEach>
					</select>
					<span>渠道:</span>
					<select name="origin">
						<option value="" selected="selected">全部</option>
						<c:forEach items="${orderChangeList}" var="orderChange">
							<option value="${orderChange.id}">${orderChange.name}</option>
						</c:forEach>
					</select>
					<c:if test="${cpId == null || cpId == 0}">
						<span>服务商:</span>
						<select id="cpId" name="cpId" data-options="editable:true" class="easyui-combobox">
							<option value="0">全部</option>
							<c:forEach items="${cpList}" var="cp">
								<option value="${cp.id}">${cp.name}</option>
							</c:forEach>
						</select>
					</c:if>
					<span>支付方式:</span>
					<select name="payMethod">
						<option value="" selected="selected">全部</option>
						<option value="4" >现金</option>
						<option value="5" >优惠券</option>
					</select>
					<%--<input id="device_sel" class="easyui-combobox" name="deviceId" data-options="editable:false,valueField:'id',textField: 'model'  , loadFilter:function(data){return data.deviceList}"/>--%>
				    <a class="easyui-linkbutton" plain="false" id="btnSearch" href="javascipt:;" iconCls="icon-search">查询</a>
					<s:privilege ifAny="order_import_recycle">
						<a id="inputExcel" style="width:70px;" href="javascript:void(0);" class="easyui-linkbutton">导入订单</a>
					</s:privilege>
					<s:privilege ifAny="order_export">
						<a id="orderExportButton" style="width:70px;" href="javascript:void(0);" class="easyui-linkbutton">导出订单</a>
					</s:privilege>
					
					<s:privilege ifAny="order_batchEnd_recycle">
						<a id="inputBatchEndExcel" style="width:70px;" href="javascript:void(0);" class="easyui-linkbutton">批量完成</a>
					</s:privilege>
					
					<s:privilege ifAny="order_batchClose_recycle">
						<a style="width:70px;" href="javascript:void(0);" onclick='$("#excelFileClose").val("");$("#winImportBatchClose").window("open");' class="easyui-linkbutton">批量关闭</a>
					</s:privilege>
				</div>
			</div>
		</form>
		<input type="hidden" id="recycleIdHid" value="">
		<div id="data_div"></div>
		<div id="dlg_div"></div>
		<div id="orderRefundRe_div"></div>
	</div>
</div>
<div id="inputInfo"></div>
<div id="recycleInfo" style="display: none">
    <iframe id="recycle_info_iframe" frameborder="0"  scrolling="yes"  width="992px"  ></iframe>
</div>
<s:privilege ifAny="order_export">
	<div id="winExport" class="easyui-window" title="导出" style="width:600px;height:400px;padding:20px;"
		 data-options="iconCls:'icon-save',modal:true,closed:true">
		<div class="easyui-layout" data-options="fit:true">
			<div style="text-align:center;margin-top:40px;">
				<form id="exportorder" method="post">
					<div style="padding-bottom: 25px">
						<span>下单:</span>
						<input name="orderStartDate" type="text" style="width:110px" class="easyui-datebox"  editable="false">
						-<input type="text" name="orderEndDate" style="width:110px;" class="easyui-datebox"   editable="false">
						<span style="padding-left: 25px">渠道:</span>
						<select name="origin" class="easyui-combobox" style="width:150px">
							<option value="" selected="selected">全部</option>
							<c:forEach items="${orderChangeList}" var="orderChange">
								<option value="${orderChange.id}">${orderChange.name}</option>
							</c:forEach>
						</select>
					</div>
					<div style="padding-bottom: 25px">
						<span>支付:</span>
						<input  type="text" name="paymentStartTime"  style="width:110px" class="easyui-datebox" editable="false">
						-<input type="text" name="paymentEndTime" style="width:110px;" class="easyui-datebox" editable="false">

						<span style="padding-left: 25px">状态:</span><input name="status" type="text" style="width:150px" id="exportOrderStatus">
					</div>

					<div style="padding-bottom: 25px">
						<span>完成:</span>
						<input  type="text" name="finishStartDate"  style="width:110px" class="easyui-datebox" editable="false">
						-<input type="text" name="finishEndDate" style="width:110px;" class="easyui-datebox" editable="false">
					</div>
				</form>
				<a id="orderExportButtonOK" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="margin-right:40px;">开始导出</a>
				<a onclick='$("#winExport").window("close");' class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
</s:privilege>

<s:privilege ifAny="order_batchEnd_recycle">
	<div id="winImportBatch" class="easyui-window" title="批量完成" style="width:400px;height:250px;padding:20px;"
		 data-options="iconCls:'icon-save',modal:true,closed:true">
		<div class="easyui-layout" data-options="fit:true">
			<div style="text-align:center;margin-top:40px;">
				<form id="importBatchEnd" enctype="multipart/form-data" method="post">
				    <!-- 
                    <div style="padding-bottom: 25px">
						<span>订单类型:</span>
						<select style="width: 120px" id="srvType" disabled="disabled">
                        <option selected="selected" value="4">回收</option>
                        </select>
					</div>
				     -->
				
					<div style="padding-bottom: 25px">
						<span>批量完成文件:</span>
						<input id="excelFile" name="excelFile" type="file" style="width: 200px;"/>
					</div>
				</form>
				<a id="orderImportBatchButtonOK" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="margin-right:40px;">开始处理</a>
				<a onclick='$("#winImportBatch").window("close");' class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
</s:privilege>
<s:privilege ifAny="order_batchClose_recycle">
	<div id="winImportBatchClose" class="easyui-window" title="批量关闭" style="width:400px;height:250px;padding:20px;"
		 data-options="iconCls:'icon-save',modal:true,closed:true">
		<div class="easyui-layout" data-options="fit:true">
			<div style="text-align:center;margin-top:40px;">
				<form id="importBatchEndClose" enctype="multipart/form-data" method="post">
					<div style="padding-bottom: 25px">
						<span>批量关闭文件:</span>
						<input id="excelFileClose" name="excelFileClose" type="file" style="width: 200px;"/>
					</div>
				</form>
				<a id="orderImportBatchCloseButtonOK" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="margin-right:40px;">开始处理</a>
				<a onclick='$("#winImportBatchClose").window("close");' class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
			</div>
		</div>
	</div>
</s:privilege>

<input type="hidden" id="firstTime">
<script type="text/javascript" src="${ctx}/resources/js/function.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/prototype.js"></script>
<script type="text/javascript">
	function Jump(id){
//        var selected = $("#device_data_div").datagrid("getSelected");
		if(id!=null&&id!=undefined){
			var url = ctx +"/recycle/showRecycleInfo?recycleId="+id;
			var title='回收订单详情'+id;
			window.parent.parent.addTabIframe(url,title);
		}else{
			alert('请选择');
		}



	}

	$("#orderExportButton").linkbutton({
		iconCls: 'icon-redo',
		onClick: function () {
			$("#winExport").window("open");
		},
		text: "导出"
	});
	$("#orderExportButtonOK").unbind("click").bind("click",function(){
		$('#exportorder').form('submit', {
			url:"${ctx}/recycle/exportOrderList",
			onSubmit: function(){
				var isValid = $(this).form('validate');
				if(isValid){
					$.messager.alert("","正在导出，请耐心等待！切勿重复点击","info",function(){
						$("#winExport").window("close");
					});
				}else{
					$.messager.alert("","下单时间不能为空!","info");
				}
			},
			success:function(data){
				var json = $.parseJSON(data);
				if(json.status == 200){
					$.messager.alert("","导出完成!","info");
				}else if(json.status == 500){
					$.messager.alert("",json.message,"info",function(){
						$(".messager-body").window('close');
					});
				}
			}
		});
	});
	
	$("#inputBatchEndExcel").linkbutton({
		//iconCls: 'icon-redo',
		onClick: function () {
			$("#excelFile").val("");
			$("#winImportBatch").window("open");
		},
		text: "批量完成"
	});
	$("#orderImportBatchButtonOK").unbind("click").bind("click",function(){
		var excelFile = $("#excelFile").val();
        if(excelFile=='') {
    	   $.messager.alert("提示","请选择要批量完成的Excel文件!","info");
    	   return;
        }else if(excelFile.indexOf('.xls')==-1 || excelFile.indexOf('.xlsx')==-1){
    	   $.messager.alert("提示","文件格式不正确，请选择正确的Excel文件(后缀名.xls或.xlsx)！","info");
    	   return;
        }
        
        $.messager.confirm("提示", "确定批量完成吗？",function(r){
            if(r){
		       $('#importBatchEnd').form('submit', {
			   url:"${ctx}/input/excel/processBatchExcel?srvType=4&inputType=0",
			   success:function(data){
				   var json = $.parseJSON(data);
				   if(json.status == 200){
					   $.messager.alert("提示",json.message,"info");
					   
					   $("#winImportBatch").window("close");
					   
					   //刷新列表;
					   $("#data_div").datagrid("reload", $("#search_form").serializeObject());
				   }else if(json.status == 500){
					   $.messager.alert("警告",json.message,"error",function(){
						$(".messager-body").window('close');
					   });
				   }
			   }
		       });
            }
        });
		
	});
	
	$("#orderImportBatchCloseButtonOK").unbind("click").bind("click",function(){
		var excelFile = $("#excelFileClose").val();
        if(excelFile=='') {
    	   $.messager.alert("提示","请选择要批量关闭的Excel文件!","info");
    	   return;
        }else if(excelFile.indexOf('.xls')==-1 || excelFile.indexOf('.xlsx')==-1){
    	   $.messager.alert("提示","文件格式不正确，请选择正确的Excel文件(后缀名.xls或.xlsx)！","info");
    	   return;
        }
        
        $.messager.confirm("提示", "确定批量关闭吗？",function(r){
            if(r){
		       $('#importBatchEndClose').form('submit', {
			   url:"${ctx}/input/excel/processBatchExcel?srvType=4&inputType=1",
			   success:function(data){
				   var json = $.parseJSON(data);
				   if(json.status == 200){
					   $.messager.alert("提示","批量关闭已处理!","info");
					   
					   $("#winImportBatchClose").window("close");
					   
					   //刷新列表;
					   $("#data_div").datagrid("reload", $("#search_form").serializeObject());
				   }else if(json.status == 500){
					   $.messager.alert("警告",json.message,"error",function(){
						$(".messager-body").window('close');
					   });
				   }
			   }
		       });
            }
        });
		
	});

	$("#exportOrderStatus").combobox({
		valueField: "value",
		textField: "label",
		editable: false,
		data: [
			{
				label: "全部",
				value: "0",
				selected: true
			},
			{
				label: "待分配",
				value: orderStatus.waitDistributeToCp,
				selected:${status!=null&&status!=''&&500==status}

			},
			{
				label: "分配失败",
				value: orderStatus.failDistributeToCp,
				selected:${status!=null&&status!=''&&501==status}

			},
			<s:privilege ifAny="order_list_all">
			{
				label: "待审核",
				value: orderStatus.pendingAudit,
				selected:${status!=null&&status!=''&&1000==status}

			},
			<%--{--%>
				<%--label: "快速下单,待审核",--%>
				<%--value: orderStatus.quickPendingAudit,--%>
				<%--selected:${status!=null&&status!=''&&1001==status}--%>

			<%--},--%>
			</s:privilege>
			{
				label: "已审核,待指派",
				value: orderStatus.hasAudit,
				selected:${status!=null&&status!=''&&(1100)==status}
			},
			{
				label: "已指派,待上门",
				value: orderStatus.engineersDoor,
				selected:${status!=null&&status!=''&&(1300)==status}
			},

			/*  {
			 label: "已指派,待客户到店",
			 value: orderStatus.engineersDoor+"02",
			 selected:${status!=null&&status!=''&&(130002)==status}
			 },*/

			{
				label: "评估完成，待确支付",
				value: orderStatus.waitPayment + "01",
				selected:${status!=null&&status!=''&&(180001)==status}
			},
			/*             {
			 label: "维修完成,待付款(到)",
			 value: orderStatus.waitPayment + "02",
			 selected:${status!=null&&status!=''&&(180002)==status}
			 },
			 {
			 label: "已审核,待收货",
			 value: 110000,
			 selected:${status!=null&&status!=''&&110000==status}
			 },
			 {
			 label: "已收货,待检测",
			 value: orderStatus.harvest,
			 selected:${status!=null&&status!=''&&1500==status}
			 }, */
			<%--{--%>
				<%--label: "正在维修",--%>
				<%--value: orderStatus.repair,--%>
				<%--selected:${status!=null&&status!=''&&2000==status}--%>
			<%--}--%>
			/*             {
			 label: "维修完成,待付款(邮)",
			 value: 180000,
			 selected:${status!=null&&status!=''&&180000==status}
			 },{
			 label: "待回寄",
			 value: orderStatus.repairCompletion,
			 selected:${status!=null&&status!=''&&2100==status}
			 },{
			 label: "已回寄,待客户收货",
			 value: orderStatus.sendBack,
			 selected:${status!=null&&status!=''&&2200==status}
			 } */
			{
				label: "订单已完成",
				value: orderStatus.success,
				selected:${status!=null&&status!=''&&2300==status}
			},{
				label: "订单取消",
				value: 2301,
				selected:${status!=null&&status!=''&&2301==status}
			}
			,
			//{
			//  label : "退款",
			//   value : orderStatus.refund
			// },

			{
				label : "无法完成",
				value : 1400
			},
			{
				label: "订单关闭",
				value: orderStatus.close,
				selected:${status!=null&&status!=''&&orderStatus.close==status}
			}
		]
	});

	$("#inputExcel").unbind("click").bind("click",function(){
		$("#inputInfo").window({
			title:"导入订单",
			width:800,
			height:550,
			modal:true,
			href:"${ctx}/input/excel/jumpInputInfo?srvType=4"
		});
	});

var showRecycleInfoa = showRecycleInfo =function (recycleId) {
    var $iframeBody = $(document.getElementById('recycle_info_iframe').contentWindow.document.body);
    $iframeBody.empty();
    $iframeBody.append("<div><img src='"+ctx+"/resources/easyui/themes/default/images/loading.gif'/>正在加载...</div>");
    $("#recycle_info_iframe").attr("src","showRecycleInfo?recycleId=" +recycleId );
    $("#recycleIdHid").val(recycleId);
    var $recycleInfo = $("#recycleInfo");
    $recycleInfo.show();
    $recycleInfo.window("open");
}

	var findNowMaxTime = function(){
		$.ajax({
			url:"${ctx}/newOrderTip/findFirstOrderTime",
			type:"POST",
			async:true,
			data:{srvType:4},
			dataType:"json",
			success:function(data){
				var json = data.jsonValue;
				$("#firstTime").val(json.createTime);
				if(null != json.createTime){
					loopOrderTimeToTip();
				}else{
					setTimeout(findNowMaxTime,1000*60);
				}
			}
		});
	};

	var loopOrderTimeToTip = function(){
		var nowTime = $("#firstTime").val();
		if(null != nowTime && "" != nowTime){
			$.ajax({
				url:"${ctx}/newOrderTip/checkMaxTime",
				type:"POST",
				async:false,
				data:{srvType:4,nowTime:nowTime},
				dataType:"json",
				success:function(data){
					if(data.isHave == 1 ){
						$(".messager-body").window('close');
						$.messager.show({
							title:'订单提醒',
							msg:'尊敬的用户您好,您有一条新增订单,请及时刷新页面处理订单,以免延期服务.',
							timeout:0,
							showType:'slide'
						});
						
						var player = $("#player")[0];                        
                        //if (player.paused){ /*如果已经暂停*/
                            player.play(); /*播放*/
                        //}
						
						setTimeout(findNowMaxTime,1000*60);
						
						
					}else{
						setTimeout(loopOrderTimeToTip,1000*60);
					}
				}
			});
		}else{
			findNowMaxTime();
		}
	};
$(function(){

	loopOrderTimeToTip();

    $("#recycleInfo").window({
        title: "<label style='float: left'>回收详情</label><a onclick=\"showRecycleInfo($('#recycleIdHid').val());\" href='javascript:void(0)' class='refresh_order_a'></a>",
        closed: true,
        onBeforeLoad: function () {
            return true;
        },
        onClose:function(){
        	showRecycleInfo = showRecycleInfoa;
        },
        width: 1008,
        height: getDlgHeight()
    });
	
    $("#recycle_info_iframe").attr("height", (getDlgHeight()-45)+"PX");

	$("#startTime").datebox({
		value:"",
		required : false ,
		editable : false,
		currentText : false,
		formatter : function(date){
			return date.format("yyyy-MM-dd");
		}
	});

	$("#endTime").datebox({
		value:"",
		required : false ,
		editable : false,
		currentText : false,
		formatter : function(date){
			return date.format("yyyy-MM-dd");
		}
	});

	$("#paymentStartTime").datebox({
		value: "",
		required: false,
		editable: false,
		currentText: false,
		formatter: function (date) {
			return date.format("yyyy-MM-dd");
		}
	});


	$("#paymentEndTime").datebox({
		value: "",
		required: false,
		editable: false,
		currentText: false,
		formatter: function (date) {
			return date.format("yyyy-MM-dd");
		}
	});

    $("#finishStartDate").datebox({
        value: "",
        required: false,
        editable: false,
        currentText: false,
        formatter: function (date) {
            return date.format("yyyy-MM-dd");
        }
    });

    $("#finishEndDate").datebox({
        value: "",
        required: false,
        editable: false,
        currentText: false,
        formatter: function (date) {
            return date.format("yyyy-MM-dd");
        }
    });

	$("#btnSearch").click(reloadList);
	
	function reloadList(){
	    $("#data_div").datagrid("load", $("#search_form").serializeObject());
	}
	
	$("#data_div").datagrid({
		url : ctx + "/recycle/getRecycleList.json"+($("#recycleId").val()!=""?("?recycleId="+$("#recycleId").val()):""),
     	pagination : true,
     	fitColumns : true,
     	pageList : [20,50,100],
     	singleSelect:true,
//     	nowrap:false,
		toolbar : "#search_form",
		pageSize: 20,
     	columns : [[
            {title:"第三方订单号", field:"thirdOrderId", align:"center",width:80},
			{title:"回收单号", field:"id", align:"center",width:100},
			{title:"提交时间",  field:"createTime",width:55,formatter : function(value) {
               		return new Date(value).format("MM-dd hh:mm");
           		}
   	       	},
			{title:"客户", field:"userName", align:"center",width:50,formatter: function (value, row, idx) {
				if(row.userExinfo !=null){
					return row.userExinfo.userName;
				}
			}},
			{title:"联系电话", field:"mobile", align:"center",width:50,formatter: function (value, row, idx) {
				if(row.userExinfo !=null){
					return row.userExinfo.mobile;
				}
			}},
			{
				field: "priAndCity",
				title: "省市",
				width: 50,
				align: 'center'
			},
			{title:"回收价", field:"priceTotal",align:"center",width:55,formatter : function(value, row, idx) {
				var str =value;
				switch (row.payStatus) {
					case 0 :
						str += "/未";
	                    break;
					case 1 :
						str += "/已";
	                    break;
					case 2 :
						str += "/退";
	                    break;
					 default:
						str += "/未";
					 	break;
				}
               	return str;
           	}},
           	{title:"设备", field:"title", align:"center",width:50},
			{
				field: "method",
				title: "类型",
				width: 50,
				align: 'center',
				formatter: function (value, row, idx) {
					var statusStr = "";
					switch (value) {
						case 1 :
							statusStr += "上";
							break;
						case 0 :
							statusStr += "邮";
							break;
						case 2 :
							statusStr += "到";
							break;

						default:
							statusStr += "未知类型";
					}
					switch (row.source) {
							<c:forEach items="${orderSources}" var="orderSource">
						case ${orderSource.id}:
							statusStr += "/${orderSource.name}";
							break;
							</c:forEach>
						default:
							statusStr += "/未知类型";
					}
					//后、普、返、兑
					switch(row.orderCategory){
						case 0:
							statusStr += "/普";break;
						case 1:
							statusStr += "/返";break;
						case 2:
							statusStr += "/后";break;
						case 3:
							statusStr += "/兑";break;
						default :
							statusStr += "/未知";
					}
					switch(row.origin) {
							<c:forEach items="${orderChangeList}" var="orderChange">
						case ${orderChange.id}:
							statusStr += "/${orderChange.name}";
							break;
							</c:forEach>
						default :
							statusStr += "/自有"
					}
					return statusStr;
				}
			},
			{
				field: "cpName",
				title: "服务商",
				width: 80,
				align: 'center',
				formatter:function(value,row){
					if(row.cp!=null){
						return row.cp.name;
					}else{
						return "暂无";
					}
				}
			},
			{
				field: "serCenterName",
				title: "中心/工程师",
				width: 80,
				align: 'center',
				formatter:function(value,row){
					if(row.engineer!=null){
						return value+"/"+row.engineer.name;
					}else if(value != null && value!=""){
						return value;
					}else{
						return "暂无";
					}
				}
			},
           	{ field: "status",
				title: "状态",
				width: 40,
				align: 'center',
				formatter: function (value, row, idx) {
					var statusStr = "";
					switch (value) {
						case orderStatus.waitDistributeToCp :
							statusStr = " <font color=red>待分配</font>";
							break;
						case orderStatus.failDistributeToCp :
							statusStr = " <font color=red>分配失败</font>";
							break;
						case orderStatus.pendingAudit :
							statusStr = " <font color=red>待审核</font>";
							break;
						case orderStatus.quickPendingAudit :
							statusStr = " <font color=red>快速下单,待审核</font>";
							break;
						case orderStatus.hasAudit :
							statusStr = row.method == 0 ? "已审核,待收货" : "已审核,待指派";
							break;
						case orderStatus.engineersDoor :
							statusStr = row.method == 1 ? "已指派,待上门" : row.method == 0? "已指派,待评估":"已指派,待客户到店";
							//statusStr = "";
							break;

						case orderStatus.harvest :
							statusStr = "已收货,待检测";
							break;
						case orderStatus.waitPayment :
							statusStr = "回收完成,待付款";
							break;
						case orderStatus.waitRepair :
							statusStr = "已付款,待回收";
							break;
						case orderStatus.repair :
							statusStr = "正在回收";
							break;
						case orderStatus.repairCompletion :
							statusStr = "已付款,待回寄";
							break;
						case orderStatus.repairFailed:
							statusStr = "回收失败,待回寄";
							break;
						case orderStatus.sendBack :
							statusStr = "已回寄,待客户收货";
							break;
						case orderStatus.success :
							statusStr = "订单成功";
							break;
						case orderStatus.refuseSuccess :
							statusStr = "订单取消";
							break;
						// case orderStatus.refund :
						//     statusStr="已退款";
						//    break;
						case orderStatus.close:
							statusStr = "订单关闭";
							break;
						case 1600 :
							statusStr = "放弃回收";
							break;
						case 1400 :
							statusStr = "无法完成";
							break;
						default:
							statusStr = "未知状态";
					}
					return statusStr;
				}},
			{
				field: "operatAndData",
				title: "最后操作",
				width: 35,
				align: 'center'

			},
   	        {title:"操作", 
				field: "a",
				title: "操作",
				align: 'center',
				width:50,
				formatter: function (value, row, index) {
					var str="";
					str+="<a href='javaScript:;' onclick=\"Jump('" + row.id + "')\">详情</a>";
					return str;
			}}
			,{title:"员工姓名", field:"employeeName", align:"center",width:50},
             {title:"员工编号", field:"employeeNo", align:"center",width:50},
			{
                field: "aa",
                title: "服务图片",
                width: 35,
                align: 'center',
                formatter: function (value, row, index) {
                    if(row.orderFiles!=null){
                        return "已上传";
                    }else{
                        return "未上传";
                    }
                }
            },
            {
                field: "loadFileOptName",
                title: "上传工程师",
                width: 35,
                align: 'center'

            }
     	]]
   });

	$("#orderStatus").combobox({
		valueField: "value",
		textField: "label",
		editable: false,
		data: [
			{
				label: "全部",
				value: "",
				selected: true
			},
			{
				label: "待分配",
				value: orderStatus.waitDistributeToCp,
				selected:${status!=null&&status!=''&&500==status}

			},
			{
				label: "分配失败",
				value: orderStatus.failDistributeToCp,
				selected:${status!=null&&status!=''&&501==status}

			},
			<s:privilege ifAny="order_list_all">
			{
				label: "待审核",
				value: orderStatus.pendingAudit,
				selected:${status!=null&&status!=''&&1000==status}

			},
			</s:privilege>
			{
				label: "已审核,待指派",
				value: orderStatus.hasAudit,
				selected:${status!=null&&status!=''&&(110001)==status}
			},
			{
				label: "已指派,待上门",
				value: orderStatus.engineersDoor,
				selected:${status!=null&&status!=''&&(130001)==status}
			},

			/*  {
			 label: "已指派,待客户到店",
			 value: orderStatus.engineersDoor+"02",
			 selected:${status!=null&&status!=''&&(130002)==status}
			 },*/

			{
				label: "回收完成,待付款(上)",
				value: orderStatus.waitPayment ,
				selected:${status!=null&&status!=''&&(180001)==status}
			},
			/*             {
			 label: "回收完成,待付款(到)",
			 value: orderStatus.waitPayment + "02",
			 selected:${status!=null&&status!=''&&(180002)==status}
			 },
			 {
			 label: "已审核,待收货",
			 value: 110000,
			 selected:${status!=null&&status!=''&&110000==status}
			 },
			 {
			 label: "已收货,待检测",
			 value: orderStatus.harvest,
			 selected:${status!=null&&status!=''&&1500==status}
			 }, */
			{
				label: "正在回收",
				value: orderStatus.repair,
				selected:${status!=null&&status!=''&&2000==status}
			}
			/*             {
			 label: "回收完成,待付款(邮)",
			 value: 180000,
			 selected:${status!=null&&status!=''&&180000==status}
			 },{
			 label: "待回寄",
			 value: orderStatus.repairCompletion,
			 selected:${status!=null&&status!=''&&2100==status}
			 },{
			 label: "已回寄,待客户收货",
			 value: orderStatus.sendBack,
			 selected:${status!=null&&status!=''&&2200==status}
			 } */
			,{
				label: "成功",
				value: orderStatus.success,
				selected:${status!=null&&status!=''&&2300==status}
			},{
				label: "订单取消",
				value: 2301,
				selected:${status!=null&&status!=''&&2301==status}
			}
			,
			//{
			//  label : "退款",
			//   value : orderStatus.refund
			// },

			{
				label : "无法完成",
				value : 1400
			},
			{
				label: "订单关闭",
				value: orderStatus.close,
				selected:${status!=null&&status!=''&&orderStatus.close==status}
			}
		]
	});

});
  
</script>

<div id="player-main" style="display:none;">
	<audio id="player">
	   <source src="/resources/audio/order.mp3"/>
	</audio>
</div>