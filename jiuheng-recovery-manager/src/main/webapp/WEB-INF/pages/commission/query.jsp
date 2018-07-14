<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">


</style>
<div id="commissionQueryPage">

	<form action="commissionQueryPage_form" method="post" action="">
 	<table>
 		<tr><div style="height: 20px"></div></tr>
 		<tr></tr>
		<tr>
			<td style="text-align: right; width: 100px">销售组织代码：</td>
			<td style="width: 150px">
				<input class="easyui-validatebox" type="text" name="saleOrgCodeQuery" id="saleOrgCodeQuery" style="width: 150px;" value="" validType="length[0,60]"/>
            </td>
		</tr>
		<tr>
			<td style="text-align: right; width: 100px">状态：</td>
						<td>
							<select id="statusQueryPage" class="easyui-combobox" name="statusQuery" style="width:150px;" >
							    <option value="">请选择</option>
							    <option value="1">已审核</option>
							    <option value="0">建单中</option>
							</select>
						</td>
		</tr>
	</table>
	</form>
	<div style="text-align:center;padding:15px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CommissionQueryUtils.doQuery();">查询</a>   
    </div>

</div>

<script type="text/javascript" src="common/js/commission/query.js"></script>
