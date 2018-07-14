<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="gmplusOrder_CreatPositiveOrder">
	<div id="creatPositiveOrder_page" style="padding-left: 100px;padding-top:40px">
	<input type="hidden" value="${gmplusOrderReq.xsddh}" id="xsddh">
	<input type="hidden" value="${gmplusOrderReq.xsfdh}" id="xsfdh">
	<input type="hidden" value="${gmplusOrderReq.xsfdlx}" id="xsfdlx">
	<input type="hidden" value="${gmplusOrderReq.fstatus}" id="fstatus">
	<div id="reasonWindow">
		<form>	
			<table>
				<tr>
					<td>
						<select id="reverseReason" name="reverseReason"  class="easyui-combobox"  type="text" style="width:150px;">
				        	<%-- <c:if test="${gmplusOrderReq.xsfdlx==0&&gmplusOrderReq.fstatus==9}">
				        		<option value="1">无库存</option>   
				        	</c:if> --%>
				        	<c:if test="${gmplusOrderReq.xsfdlx==0&&gmplusOrderReq.fstatus<80&&gmplusOrderReq.fstatus>=10}">
		    					<option value="3">买家退款</option>
				        	</c:if>
				        	<c:if test="${gmplusOrderReq.xsfdlx==0&&gmplusOrderReq.fstatus>=80}">
		    					<option value="4">买家退货</option>
				        	</c:if>
		    				<!-- <option value="3">买家已取消</option>
		    				<option value="5">买家换货</option>
		    				<option value="6">商品没收到</option>
		    				<option value="7">一般盘点</option> -->
				        </select>	
					</td>
					<td></td>
				</tr>
				<tr>
					<td><a href="#" class="easyui-linkbutton" icon="icon-add"  onclick="creatReverseOrder.creat();">确定创建</a>
						<a href="#" class="easyui-linkbutton" icon="icon-back" onclick="creatReverseOrder.back();">返回</a>
					</td>
				</tr>
			</table>
		</form>
		</div>
	</div>
</div>
    <script type="text/javascript"	src="common/js/gmplusOrder/gmplusReverseOrderWindow.js"></script>
