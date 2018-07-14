<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="order_view" style="width: 100%; height: auto;">
     <div id="view_index_panel" class="easyui-panel" style="width: 100%;">
		<div id="order_panel" class="easyui-panel" title="主单信息"	style="width: 100%; background-color: #eff5ff;"
			data-options="collapsible:true">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 3px 1% 3px 1%">
					<tr>
						<td width="11%" align="right">订单号 :</td>
						<td width="5%">${order.xsddh}</td>
						<td width="11%" align="right">主单类型 :</td>
						<td width="5%">
							<c:if test="${order.xsddlx==0}">销售</c:if>
							<c:if test="${order.xsddlx==1}">退款</c:if>
							<c:if test="${order.xsddlx==2}">冲红</c:if>
							<c:if test="${order.xsddlx==3}">拒收</c:if>
							<c:if test="${order.xsddlx==4}">退货</c:if>
							<c:if test="${order.xsddlx==5}">换货</c:if>
						</td>
						<td width="11%" align="right">销售渠道 :</td>
						<td id="xsqddm" width="5%">${order.xsqddm }</td>
						<td width="11%" align="right">顾客名称 :</td>
						<td id="gkmc" width="5%">${order.gkmc}</td>
						<td width="11%" align="right">收货人名称 :</td>
						<td id="shrmc" width="5%">${order.shrmc }</td>
						<td width="11%" align="right">收货人电话 :</td>
						<td id="shrdh1" width="5%">${order.shrdh1}</td>
					
					</tr>
					<tr>
						<td width="11%" align="right">地址区域代码:</td>
						<td id="dzqydm" width="5%">${order.dzqydm}</td>
						<td width="11%" align="right">预约配送日期 :</td>
						<td width="5%" id="returnId">${order.yypsrq}</td>
						<td width="11%" align="right">运费:</td>
						<td width="5%"><fmt:formatNumber type="number" value="${(order.psycf+order.pslqf)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="11%" align="right">发票抬头 :</td>
						<td width="5%">${order.fptt}</td>
						<td width="11%" align="right">顾客留言 :</td>
						<td width="5%">${order.gkly}</td>
						<td width="11%" align="right">提交时间 :</td>
						<td width="5%">${order.tjsj}</td>
					</tr>
					<tr>
						<td width="11%" align="right">支付公司代码 :</td>
						<td width="5%">${order.zfgsdm}</td>
						<td width="8%" align="right">支付时间 :</td>
						<td width="12%">${order.zfsj}</td>
						<!-- <td width="11%" align="right">原线上分单号 :</td>
						<td width="5%">${order.yxsfdh}</td> -->
						<c:if test="${order.status==4}">
							<td width="12%" align="right">退货顾客邮寄单号:</td>
							<td width="4%">${order.thgkyjdh}</td>
						</c:if>
					</tr>
					<c:if test="${order.xsddlx==1 || order.xsddlx==4}">
					<tr>
					    <td width="11%" align="right">发票退回标记 :</td>
						<td width="5%">${order.fpthbj}</td>
						<td width="11%" align="right">发票退回信息 :</td>
						<td width="5%">${order.fpthxx}</td>
						<td width="11%" align="right">财务审核意见 :</td>
						<td width="5%">${order.cwshyj}</td>
						<td width="11%" align="right">财务审核时间 :</td>
						<td width="5%">${order.cwshsj}</td>
						<td width="11%" align="right">财务审核人名称 :</td>
						<td width="5%">${order.cwshrmc}</td>
						<td width="11%" align="right">线下退款描述 :</td>
						<td width="5%">${order.xxtkms}</td>
					</tr>
					</c:if>
<!-- 					<tr> -->
<!-- 					    <td width="10%" align="center">发票是否收回</td> -->
<%-- 						    <c:if test="${returnMoneyMessage.retBillBj == 1 }"> --%>
<!-- 						        <td width="5%" id="retBill">是</td> -->
<!-- 								<td width="10%" id="td1" align="center" >原发票号:</td> -->
<%-- 							    <td width="5%" id="td2" >${returnMoneyMessage.billInfo}</td> --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${returnMoneyMessage.retBillBj == 0 }"> --%>
<!-- 							    <td width="5%" id="retBill">否</td> -->
<!-- 								<td width="10%" id="td3" align="center">备注原因:</td> -->
<%-- 							    <td width="5%" id="td4" >${returnMoneyMessage.despReason}</td> --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${returnMoneyMessage.retStatus==12 }"> --%>
<!-- 							   <td width="5%" align="center">线下退款方式:</td> -->
<%-- 							   <td width="10%">${returnMoneyMessage.underLinePayCode }  </td> --%>
<!-- 							   <td width="5%" align="center">线下退款金额:</td> -->
<%-- 							   <td width="10%">${returnMoneyMessage.underLineAmount }  </td> --%>
<!-- 							   <td width="5%px" align="center"> 线下退款公司账号:</td> -->
<%-- 							   <td width="10%">${returnMoneyMessage.underLineCompAccount }</td> --%>
<!-- 							   <td width="5%" align="center">备注信息:</td> -->
<%-- 							   <td width="10%">${returnMoneyMessage.underLineInfo }</td> --%>
<%-- 							</c:if> --%>
						
<!-- 					    </tr> -->
				</table>
		</div>
		<div id="suborder_panel" class="easyui-panel" title="分单信息" style="width: 100%;  background-color: #eff5ff;"
			data-options="collapsible:true">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 5px 1% 3px 1%">
					<tr>
						<td width="11%" align="right">分单号 :</td>
						<td width="5%" id="xsfdh">${subOrder.xsfdh}</td>
						<td width="11%" align="right">分单序号 :</td>
						<td id="fdxh" width="5%">${subOrder.fdxh}</td>
						<td width="11%" align="right">分单类型 :</td>
						<td width="5%">
							<c:if test="${subOrder.xsfdlx==0}">销售</c:if>
							<c:if test="${subOrder.xsfdlx==1}">退款</c:if>
							<c:if test="${subOrder.xsfdlx==2}">冲红</c:if>
							<c:if test="${subOrder.xsfdlx==3}">拒收</c:if>
							<c:if test="${subOrder.xsfdlx==4}">退货</c:if>
							<c:if test="${subOrder.xsfdlx==5}">换货</c:if>
						</td>
						<td width="8%" align="right">状态 :</td>
						<td width="8%">${subOrder.status1}</td>
						<td width="11%" align="right">网店店主ID :</td>
						<td id="wddzid" width="5%">${subOrder.wddzid}</td>
						<td width="11%" align="right">国美员工ID :</td>
						<td id="gmygid" width="5%">${subOrder.gmygid}</td>
					</tr>
					<tr>
						<td width="11%" align="right">物流配送类型 :</td>
						<td width="5%" >
						    <c:if test="${subOrder.wlpslx==0}">自提</c:if>
							<c:if test="${subOrder.wlpslx==1}">国美物流</c:if>
							<c:if test="${subOrder.wlpslx==2}">第三方快递</c:if>
						</td>
						<td width="11%" align="right">成交金额 :</td>
						<td width="5%" id="ddcjje"><fmt:formatNumber type="number" value="${subOrder.ddcjje/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="11%" align="right">物流确定配送日期:</td>
						<td id="xszzdm"width="5%">${subOrder.wlpsrq}</td>
						<td width="11%" align="right">运费:</td>
						<td width="5%"><fmt:formatNumber type="number" value="${(subOrder.psycf+subOrder.pslqf)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="11%" align="right">实际库存地 :</td>
						<td width="5%">${subOrder.sjkcddm}</td>
						<td width="14%" align="right">地址配置的实际库存地 :</td>
						<td width="4%">${subOrder.dzsjkcddm}</td>
						
					</tr>
					<tr>
						<td width="11%" align="right">原分单号 :</td>
						<c:choose>
						   <c:when test="${subOrder.yxsfdh>0}">
						    <td width="5%"><a href="#" onclick="orderview.view(${subOrder.yxsfdh});">${subOrder.yxsfdh}</a></td>
						   </c:when>
						   <c:otherwise><td width="5%"></td></c:otherwise>
						</c:choose>
						<td width="11%" align="right">凭证记录编号 :</td>
						<td width="5%" id="pzjlbh">${subOrder.pzjlbh}</td>
						<td width="11%" align="right">原门店:</td>
						<td width="5%">${subOrder.ymddm}</td>
						<td width="8%" align="right">员工佣金标记:</td>
						<td width="8%">${subOrder.ygyjbj}</td>
						<td width="8%" align="right">佣金发放单编号:</td>
						<td width="8%">${subOrder.yjffdbh}</td>
						<td width="11%" align="right">SAP订单号:</td>
						<td width="5%">${subOrder.sapddh}</td>
					</tr>
					<tr>
						<td width="11%" align="right">非国美标记 :</td>
						<td width="5%" >${subOrder.fgmbj}</td>
						<td width="11%" align="right">卖家销售组织 :</td>
						<td width="5%" id="wddzxszz">${subOrder.wddzxszz}</td>
						<td width="11%" align="right">卖家门店:</td>
						<td width="5%">${subOrder.wddzmd}</td>
						<td width="11%" align="right">配送区域代码 :</td>
						<td width="5%" >${subOrder.psqydm}</td>
						<td width="11%" align="right">安装区域代码 :</td>
						<td width="5%" id="azqydm">${subOrder.azqydm}</td>
						<td width="11%" align="right">销售公司代码:</td>
						<td width="5%">${subOrder.xsgsdm}</td>
					</tr>
					<tr>
						<td width="11%" align="right">门店代码 :</td>
						<td width="5%" >${subOrder.mddm}</td>
						<td width="11%" align="right">订单上传SAP :</td>
							<c:if test="${subOrder.ddscbj==0}"><td width="5%">否</td></c:if>
							<c:if test="${subOrder.ddscbj==1}"><td width="5%">是</td></c:if>
						<td width="11%" align="right">建档上传SAP :</td>
							<c:if test="${subOrder.jdscbj==0}"><td width="5%">否</td></c:if>
							<c:if test="${subOrder.jdscbj==1}"><td width="5%">是</td></c:if>
						<td width="11%" align="right">交货单号:</td>
						<td width="5%">${subOrder.jhdh}</td>
						<td width="11%" align="right">带安状态:</td>
						<c:if test="${subOrder.cjazbj==2}"><td width="5%">推送ECP成功</td></c:if>
						<c:if test="${subOrder.cjazbj==1}"><td width="5%">带安</td></c:if>
						<c:if test="${subOrder.cjazbj==0}"><td width="5%">非带安</td></c:if>
						<c:if test="${subOrder.cjazbj==-1}"><td width="5%">推送ECP失败</td></c:if>
						<td width="8%" align="right">预约安装日期:</td>
						<td width="8%">${subOrder.shazrq}</td>
						<!-- <td width="11%" align="right">安装完成码:</td>
						<td width="5%">${subOrder.azwcdm}</td> -->
					</tr>
				</table>
		</div>
		<div class="easyui-panel" title="订单明细" data-options="border:false,collapsible:true" style="width: 100%;min-height: 100px;background-color: #eff5ff;">
	        <table cellspacing="0" cellpadding="0" width="100%" style="border-bottom:1px solid #95B8E7" class="pn-ltable">
				<thead class="pn-lthead">
					<tr  bgcolor="#DCDCDC">
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">分单号</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">订单商品序号</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">商品编码</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">商品名称</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">供货商代码</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">库存地点代码</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">业务机型</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">联营标记</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">单价</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">佣金</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">数量</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">成交金额</td>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${subOrder.subOrdersGoods }" var="detail">
						<tr bgcolor="#ffffff" onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
							<td id="xsddh" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.xsfdh }</td>
							<td id="ddspxh" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.ddspxh }</td>
							<td id="skuid" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.skuid }</td>
							<td id="spmc" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.spmc }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.ghsdm }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.kcdddm }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.ywjx }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">
							   <c:if test="${detail.lybj==0}">否</c:if>
							   <c:if test="${detail.lybj==1}">是</c:if>
							</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;"><fmt:formatNumber type="number" value="${(detail.spjg)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;"><fmt:formatNumber type="number" value="${(detail.spyj)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${detail.xssl }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;"><fmt:formatNumber type="number" value="${(detail.cjje)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						</tr>
					</c:forEach>
				</tbody>
	        </table>
		</div>
		<div style="clear:both;">
<!-- 		overflow-x : scroll; -->
		 	<div class="easyui-panel" title="订单履历" data-options="border:false,collapsible:true" style="width: 100%;min-height: 100px;background-color: #eff5ff;">
				<table class="easyui-datagrid" data-options="
				collapsible:true,url:'order/getSubOrderStatus/'+${subOrder.xsfdh},
				striped : true,
				autoRowHeight:true,
				checkOnSelect : true,
				singleSelect : true">
					<thead>
						<tr>
							<th data-options="field:'xsfdh'">分单号</th>
							<th data-options="field:'xtdm',">系统代码</th>
							<th data-options="field:'status'">状态</th>
							<th data-options="field:'ztfssj'">状态发生时间</th>
							<th data-options="field:'ztjssj'">状态处理时间</th>
							<th data-options="field:'ztmc'">状态名称</th>
							<th data-options="field:'ztms'">状态描述</th>
<!-- 							<th data-options="field:''">承运商信息</th> -->
							<th data-options="field:'cysydh'">承运商运单号</th>
							<th data-options="field:'ztscbj'">状态上传标记</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div style="width: 100%;padding: 5px 0px;background-color: #eff5ff;" align="center">
			<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px;"
				onclick="orderview.Return();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
	   </div>
 </div>
</div>
<script type="text/javascript"	src="common/js/return_money/return_money.js"></script>
<script type="text/javascript"	src="common/js/order/view.js"></script>
