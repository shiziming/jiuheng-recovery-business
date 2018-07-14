<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<div id="goods_down_manage2">
	<input id="func_check" type="hidden" value="${FUNC_CHECK}"/>
	<input id="func_maintain" type="hidden" value="${FUNC_MAINTAIN}"/>
	<input id="xsqddm" type="hidden" value="84"/>
<!-- 商品下架单据查询列表 -->
	<div id="goods_list_panel" class="easyui-panel">
		<div id="goods_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
			<input name="channelCode" type="hidden" value="84"/>
			<input type="hidden" name="billType" value="2">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 80px 0px 80px">
					<tr>
						<td width="10%" align="center">单据编号</td>
						<td width="5%"><input name="billId" type="text"
							placeholder="请输入单据编号" class="span2"></td>
						<td width="5%"></td>
						<td width="10%" align="center">录入人</td>
						<td width="5%"><input name="createUserCode" type="text"
							placeholder="请输入录入人代码" class="span2"></td>
						<td width="5%"></td>
						<td width="10%" align="center">单据机构代码</td>
						<td width="5%"><input name="billOrgCode" id="billOrgCode"
							type="text" placeholder="请输入销售组织代码" class="span2"></td>
						<td width="5%"></td>
						<td width="10%" align="center">状态</td>
						<td width="5%"><select id="status" name="status" class="easyui-combobox" style='width: 100%;'>
								<option value="0" selected="selected">已录入</option>
								<option value="1">已审核</option>
						</select></td>
						<td width="5%"></td>
						
						<td width="10%"></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<!-- <td width="10%" align="center">销售渠道代码</td>
						<td width="5%"><input name="channelCode" type="text" placeholder="请输入销售渠道代码" class="span2"></td> -->
						
						
						<td width="10%" align="left"></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
					<tr>
						<td width="10%" align="center">录入日期</td>
						<td width="5%"><input id="ksrq" style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="createStartTime" type="text" />至
							<input id="jsrq" style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="createEndTime" type="text" /></td>
						<td width="5%"></td>
						<td width="10%" align="center">审核日期</td>
						<td width="5%"><input id="ksrq" style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="checkStartTime" type="text" />至
							<input id="jsrq" style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="checkEndiTime" type="text" /></td>
						<td width="5%"></td>
						<td width="10%" align="right"><a href="#" id="goods_list_query"
							class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
						<td width="10%"></td>
						<td width="20%"></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="tb" style="display: none;">
			<c:if test="${FUNC_MAINTAIN ==true}">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true"
				onclick="gmj_goods_down_list.go_down();">新增下架</a>
			</c:if>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
	</div>

	
	<!-- 商品上下架单据明细查看界面 -->
	<div class="easyui-panel" id="view_panel" style="display:block">
	
	</div>
	
		<!-- 新增，修改商品上架单据明细 -->
	<div class="easyui-panel" id="down_panel" style="display:block">
	
	</div>

</div>


<script type="text/javascript"	src="common/js/gmj_goods_manage/goods_down_list.js"></script>
