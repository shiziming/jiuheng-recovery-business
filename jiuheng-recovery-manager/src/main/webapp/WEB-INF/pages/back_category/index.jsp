<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style type="text/css">
#backCategoryPage .categories-panel {
	float: left;
	margin-right: 1px;
	width : 15%;
}
#backCategoryPage #categories-attr-bind {
	float: left;
	width: 50%;
}
</style>
<div id="backCategoryPage">
	<div id="listPanel">
		<div class="categories-panel">
			<table id="dg1" title="一级类目" class="categories-datagrid" data-options="toolbar:'#tb1'"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg2" title="二级类目" class="categories-datagrid" data-options="toolbar:'#tb2'"></table>
		</div>
		<div class="categories-panel panel-hide">
			<table id="dg3" title="三级类目" class="categories-datagrid" data-options="toolbar:'#tb3'"></table>
		</div>
		
		<div id="categories-attr-bind" class="panel-hide">
			<table id="categridEditDg" title="关联属性" style="height: auto;"></table>
			<div id="categridEditTb1" style="height: auto">
				<div class="search1">
					<form id="searchForm">
						<table>
							<tr>
								<td class="label">属性组名称:<input id="attrGroup" class="easyui-combobox" style="width: 150px;"
								data-options="loader:backCategories.attrGroupLoader,mode: 'remote',required:true,valueField: 'value',
				textField: 'text'"></td>
								<td class="label">属性组显示序号:<input type="text" id="backcate_group_index" class="easyui-numberbox" value=""style="width: 150px;"  data-options="min:1,required:true"></input></td>
							</tr>
						</table>
					</form>
				</div>
				<input id="lastCategoryCode" type="hidden"/>
				<div class="toolbar">
					<a class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true" onclick="backCategories.addRow();">增加</a>
					<a class="easyui-linkbutton"
					data-options="iconCls:'icon-remove',plain:true" onclick="backCategories.delRow();">删除</a>
				</div>
			</div>
			
			<div align="center" style="padding: 5px;height: 30px;">
				<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g1',iconCls:'icon-save'"
					onclick="backCategories.save_attribute();">保存</a>
			</div>
			<table id="categridEditTg"  style=" height: auto;">	</table>
			<div id="categridEditTb2" style="height: auto">
				<a class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true" onclick="backCategories.backcate_tg_edit()">修改</a>
			 	<a class="easyui-linkbutton"
				data-options="iconCls:'icon-save',plain:true" onclick="backCategories.backcate_tg_accept()">保存</a>
			</div>
			
		</div>


		<div id="tb1">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"
				onclick="backCategories.append('#backCategoryPage #dg1')"> </a>  
			<a class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"
				onclick="backCategories.backend_edit('#backCategoryPage #dg1')"></a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"
				onclick="backCategories.removeit('#backCategoryPage #dg1')"> </a> 
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true"
				onclick="backCategories.accept('#backCategoryPage #dg1')"> </a>
		</div>
		<div id="tb2">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"
				onclick="backCategories.append('#backCategoryPage #dg2')"> </a>  
			<a class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"
				onclick="backCategories.backend_edit('#backCategoryPage #dg2')"></a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"
				onclick="backCategories.removeit('#backCategoryPage #dg2')"> </a> 
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true"
				onclick="backCategories.accept('#backCategoryPage #dg2')"> </a>
		</div>
		<div id="tb3">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"
				onclick="backCategories.append('#backCategoryPage #dg3')"> </a>  
			<a class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"
				onclick="backCategories.backend_edit('#backCategoryPage #dg3')"></a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"
				onclick="backCategories.removeit('#backCategoryPage #dg3')"> </a> 
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true"
				onclick="backCategories.accept('#backCategoryPage #dg3')"> </a>
		</div>
	</div>
	
	
	
	
	<div id="back_category_pic" class="easyui-dialog" title="类目图片" data-options="width:400,height:400,closed:true ,modal:true">
    	 <div align="center" style="margin-top: 20px;width:200px;margin-left:98px;">
			<img id="category_img_ImgPr" width="200" height="200" src='' />
			<input type="file" id="category_img_upload" name="category_img_upload"/> 
			<input id="backcate_code" style="display: none;" ></input>
			<input id="backcate_name" style="display: none;" ></input>
			<input id="selected_backcate_id" style="display: none;" ></input>
		 </div>
	   	<div  align="center" style="margin-top: 20px">
			<a href="javascript:void(0);"  class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 100px;" onclick="backCategories.uploadPic();">
				<span style="font-size: 12px;">保 存</span>
			</a> <a href="javascript:void(0);"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 100px; margin-left: 50px"
				onclick="$(backCategories.dlg).dialog('close');"> <span>返 回</span>
			</a>
		</div>
	</div>
</div>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="common/js/back_category/backend.js"></script>
