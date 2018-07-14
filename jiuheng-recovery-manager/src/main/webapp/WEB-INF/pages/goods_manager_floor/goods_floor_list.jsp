<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="goods_up_manage11">
<input id="func_check" type="hidden" value="${FUNC_CHECK}"/>
	<input id="func_maintain" type="hidden" value="${FUNC_MAINTAIN}"/>	
<!-- 国美商品楼层显示查询列表 -->
	<div id="goods_list_panel" class="easyui-panel">
		<div id="goods_list_list_search_panel" class="easyui-panel" title="查询条件"
			style="width: 100%; height: auto; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
			<form id="searchForm">
				<table class="table table-hover table-condensed"
					style="width: 100%; padding: 7px 80px 0px 80px">
					<tr>
						<td width="22%" align="middle" >单据编号</td>
						<td width="5%"><input name="djbh" type="text"
							placeholder="请输入单据编号" class="span2"></td>
						<td width="25%" >销售组织代码</td>
						<td width="5%"><input name="xszzdm" id="xszzdm"
							type="text" placeholder="请输入销售组织代码" class="span2"></td>
						<td width="5%" align="center">录入人</td>
						<td width="10%"><input name="zdrid" type="text"
							placeholder="请输入录入人代码" class="span2"></td>
						<td width="5%" >状态</td>
						<td width="5%"><select id="status" name="status" class="easyui-combobox" style='width: 100%;'>
								<option value="0" selected="selected">已录入</option>
								<option value="1">已审核</option>	
						<td width="5%"></td>
						
						<td width="5%"></td>
						
						
						</select></td>
						
						<td width="20%"></td>
					</tr>
					<tr>
					<!--  
						<td width="10%" align="center">销售渠道代码</td>
						<td width="5%"><input name="channelCode" type="text" placeholder="请输入销售渠道代码" class="span2"></td>
						-->
						
					</tr>
					<tr>
						<td width="10%" align="center">录入日期</td>
						<td width="5%" ><input id="ksrq" style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="createStartTime" type="text" />至
							<input id="jsrq" style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="createEndTime" type="text" /></td>
						<td width="10%" align="left">审核日期</td>
						<td width="5%"><input id="ksrq" style="width: 85%"
							placeholder="起始日期" class="easyui-datebox" name="checkStartTime" type="text" />至
							<input id="jsrq" style="width: 85%" placeholder="结束日期" class="easyui-datebox" name="checkEndTime" type="text" /></td>
						<td width="10%" align="right"><a href="#" id="goods_list_query"
							class="easyui-linkbutton" iconCls="icon-search">查询</a></td>
					</tr>
				</table>
			</form>
		</div>
		
		
		<div id="tb" style="display: none;">
					<a href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true"
					onclick="splc_goods_up_list.go_up();">新增</a>
					
					<a id="activity_list_btnDel" href="javascript:void(0);" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true" onclick="splc_goods_up_list.del();">删除</a>
		</div>
		<div data-options="border:false">
			<table id="dg"></table>
		</div>
	</div>

	
	<!-- 国美商品楼层显示明细查看界面 -->
	<div class="easyui-panel" id="view_panel" style="display:block">
	
	</div>
	
		<!-- 新增，国美商品楼层显示商品上架单据明细 -->
	<div class="easyui-panel" id="up_panel" style="display:block">
	
	</div>

</div>


<script type="text/javascript"	src="common/js/goods_manager_floor/goods_floor_list.js"></script>
