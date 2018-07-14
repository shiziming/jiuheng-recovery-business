<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="gmzxOrder_view" style="width: 100%; height: auto;">
     <div id="view_index_panel" class="easyui-panel" style="width: 100%;">
		<div id="order_panel" class="easyui-panel" title="主单信息"	style="width: 100%; background-color: #eff5ff;"
			data-options="collapsible:true">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 3px 1% 3px 1%; ">
					<tr>
						<td width="30px" align="right" style="padding-left: 30px">国美在线订单编号 :</td>
						<td width="50px">${mainOrder.wbxsddh}</td>
						<td width="30px" align="right">买家名称 :</td>
						<td id="shrmc" width="50px">${mainOrder.gkmc}</td>
						<td width="30px" align="right">提交时间 :</td>
						<td id="xsqddm" width="50px">${mainOrder.tjsj}</td>
					</tr>
					<tr>
						<td align="right">订单号 :</td>
						<td>${mainOrder.xsddh}</td>	
						<td align="right">收货人姓名 :</td>
						<td id="shrmc">${consigneeInfo.name}</td>
						<td align="right">支付时间 :</td>
						<td>${mainOrder.zfsj}</td>
					</tr>
					<tr>		
						<td align="right">主单类型 :</td>
						<td >
							<c:if test="${mainOrder.xsddlx==0}">销售</c:if>
							<c:if test="${mainOrder.xsddlx==1}">退款</c:if>
							<c:if test="${mainOrder.xsddlx==2}">冲红</c:if>
							<c:if test="${mainOrder.xsddlx==3}">拒收</c:if>
							<c:if test="${mainOrder.xsddlx==4}">退货</c:if>
							<c:if test="${mainOrder.xsddlx==5}">换货</c:if>
						</td>
						<td  align="right">收货地址 :</td>
						<td id="xsqddm" >${address.address0}${address.address1}${address.address2}${address.address3}${address.address4}${address.address5}${address.address6}</td>
						<td  align="right">顾客留言 :</td>
						<td >${mainOrder.gkly}</td>
					</tr>
					<tr>
						<td  align="right">销售渠道 :</td>
						<td id="xsqddm" >${mainOrder.xsqddm }</td>
						<td  align="right">收货人电话 :</td>
						<td id="shrdh1">${consigneeInfo.phone1}<br>${consigneeInfo.phone2}</td>
						<td align="right">发票抬头 :</td>
						<td >${branchOrder.fptt}</td>
					</tr>
					<tr>
						<td  align="right">原单号 :</td>
						<td id="returnId">${mainOrder.yxsfdh}</td>
						<td  align="right">地址区域代码:</td>
						<td id="dzqydm">${address.addressAreaCode}</td>
						<td  align="right">运费:</td>
						<td ><fmt:formatNumber type="number" value="${(branchOrder.psycf+branchOrder.pslqf)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
					</tr>
						
				</table>
		</div>
		<div id="branchOrder_panel" class="easyui-panel" title="分单信息" style="width: 100%;  background-color: #eff5ff;"
			data-options="collapsible:true">
				<table class="table table-hover table-condensed" style="width: 100%; padding: 3px 1% 3px 1%;">
					<tr>
						<td width="30px" align="right" style="padding-left: 10px">分单号 :</td>
						<td width="50px" id="xsfdh">${branchOrder.xsfdh}</td>
						<td width="30px" align="right">成交金额 :</td>
						<td width="50px" id="ddcjje"><fmt:formatNumber type="number" value="${branchOrder.ddcjje/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="30px" align="right">物流确定配送日期:</td>
						<td id="shrmc" width="50px">${branchOrder.ddfhsj}</td>
					</tr>
					<tr>	
						<td width="30px" align="right">分单序号 :</td>
						<td id="fdxh" width="50px">${branchOrder.fdxh}</td>
						<td width="30px" align="right">运费 :</td>
						<td id="fdxh" width="50px"><fmt:formatNumber type="number" value="${(branchOrder.psycf+branchOrder.pslqf)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						<td width="30px" align="right">凭证记录编号 :</td>
						<td width="50px" id="pzjlbh">${branchOrder.pzjlbh}</td>
					</tr>
					<tr>
						<td width="30px" align="right">原分单号 :</td>
						<c:choose>
						   <c:when test="${branchOrder.yxsfdh>0}">
						    <td width="50px"><a href="#" onclick="gmzxOrderview.view(${branchOrder.yxsfdh});">${branchOrder.yxsfdh}</a></td>
						   </c:when>
						   <c:otherwise><td width="50px"></td></c:otherwise>
						</c:choose>
						<td width="30px" align="right">配送区域代码 :</td>
						<td width="50px" >${branchOrder.psqydm}</td>
						<td width="30px" align="right">SAP订单号:</td>
						<td width="50px">${branchOrder.sapddh}</td>
					</tr>
					<tr>
						<td width="30px" align="right">分单类型 :</td>
						<td width="50px">
							<c:if test="${branchOrder.xsfdlx==0}">销售</c:if>
							<c:if test="${branchOrder.xsfdlx==1}">退款</c:if>
							<c:if test="${branchOrder.xsfdlx==2}">冲红</c:if>
							<c:if test="${branchOrder.xsfdlx==3}">拒收</c:if>
							<c:if test="${branchOrder.xsfdlx==4}">退货</c:if>
							<c:if test="${branchOrder.xsfdlx==5}">换货</c:if>
						</td>
						<td width="30px" align="right">实际库存地 :</td>
						<td width="50px">${branchOrder.sjkcddm}</td>
						<td width="30px" align="right">非国美标记 :</td>
						<td width="50px" >${branchOrder.fgmbj}</td>
					</tr>
					<tr>
						<td width="30px" align="right">状态 :</td>
						<td width="50px">${branchOrder.status1}</td>
						<td width="35px" align="right">地址配置的实际库存地 :</td>
						<td width="50px">${branchOrder.dzsjkcddm}</td>
						<td width="30px" align="right">物流配送类型 :</td>
						<td width="50px" >
						    <c:if test="${branchOrder.wlpslx==0}">自提</c:if>
							<c:if test="${branchOrder.wlpslx==1}">国美物流</c:if>
							<c:if test="${branchOrder.wlpslx==2}">第三方快递</c:if>
							<c:if test="${branchOrder.wlpslx==3}">厂家带安</c:if>
						</td>
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
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">国美在线商品识别号</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">国美在线订单商品识别号</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">商品名称</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">供货商代码</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">库存地点代码</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">业务机型</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">单价</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">数量</td>
						<td width="4%" style="background-color:#F4F4F4;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">成交金额</td>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
						<tr bgcolor="#ffffff" onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
							<td id="xsddh" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.xsfdh }</td>
							<td id="ddspxh" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.ddspxh }</td>
							<td id="skuId" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.skuId }</td>
							<td id="spmc" style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.skuwm }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.ddspmxm }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.skumc }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.ghsdm }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.kcdddm }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.ywjx }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;"><fmt:formatNumber type="number" value="${(goods.spjg)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dotted #CCCCCC;">${goods.xssl }</td>
							<td style="background-color:#FFFFFF;font-size:12px;padding:3px;border-right:1px dot	ted #CCCCCC;"><fmt:formatNumber type="number" value="${(goods.cjje)/100}"  pattern="0.00" maxFractionDigits="2"/></td>
						</tr>
				</tbody>
	        </table>
		</div>
		<div style="clear:both;">
<!-- 		overflow-x : scroll; -->
		 	<div class="easyui-panel" title="订单履历" data-options="border:false,collapsible:true" style="width: 100%;min-height: 100px;background-color: #eff5ff;">
				<table class="easyui-datagrid" data-options="
				collapsible:true,url:'gmzxOrder/queryOrderStatusByXsfdh/'+${branchOrder.xsfdh},
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
				onclick="gmzxOrderview.Return();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
	   </div>
 </div>
</div>
<script type="text/javascript"	src="common/js/gmzxOrder/gmzxOrderView.js"></script>
