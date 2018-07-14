<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="attrGroupPage">
	<div id="listPanel">
		<table id="dataGrid"></table>
		<div id="tb" style="height: auto">
			<div class="search">
				<form id="searchForm">
					<table>
						<tr>
							<td class="label">id:</td>
							<td class="content">
								<input name="id"/>
							</td>
							<td class="label">名称:</td>
							<td class="content">
								<input name="name"/>
							</td>
							 <td> <a id="btnSearch" class="easyui-linkbutton" iconCls="icon-search">查询</a></td>  
						</tr>
					</table>
				</form>
			</div>
			<div class="toolbar">
					<a id="btnAdd" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true">新增</a>
					<a id="btnEdit" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-edit',plain:true">修改</a>
					<a id="btnDel" href="#" class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true">删除</a>
			</div>
		</div>
	</div>
	
	<div id="attr_group_dlg" class="easyui-dialog"  data-options="width:400,height:300,closed:true ,modal:true">
		<div style="margin:50px 0px " align="center">
			<form id="group_fm" method="post">
				<input type="hidden" id="group_attr_id" name="id"/>
				<label>属性组名称:</label><input id="group_attr_name" type="text" name="name"/><br/> 
			</form>
		</div>
		<div  align="center">
			<a href="javascript:void(0);"  class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 100px;" onclick="categoryAttrGroup.save();">
				<span style="font-size: 12px;">保 存</span>
			</a> <a href="javascript:void(0);"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 100px; margin-left: 50px"
				onclick="categoryAttrGroup.cancel();"> <span>返 回</span>
			</a>
		</div>
	</div>
	
	<script type="text/javascript" src="common/js/attribute_group/group.js"></script>
</div>
