<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="areaImportPage" style="width: 100%;">
	<!-- 详细？-->
	<div class="areaImportPage" style="padding:25px" align="center">
		<form id="areaImport_form" enctype="multipart/form-data"  action="common/import/specialImport" method="post">
		<table>
			<tr>
				<td align="center"><font style="font-size: 17px">请选择修改字段</font></td>
			</tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr>
				
	            <td align="center"><input type="radio" name="type" value="0"><font style="font-size: 13px">门店</font>
	           					   <input type="radio" name="type" value="1"><font style="font-size: 13px">仓库</font></td>
			</tr>
			<tr>
				<td align="center">
				<input type="file" name="fileimport" id = "fileimportId" buttonText="浏览"
						 data-options="prompt:'选择文件' ,required:true, novalidate:true,validType:'disableSpecialChar'"
						style="width: 100%">
                </td>	
              </tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
              <tr>
				
              	<!-- <td><a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.areaImportUtils.downloadExcel(this);"><span style="font-size: 14px;">下载模板</span></a></td> -->
				<td><a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.areaImportUtils.importExcel(this);"><span style="font-size: 14px;">上传</span></a>
				<a href="javascript:void(0);" style="padding: 5px 0px; width: 80px; margin-left: 20px" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				onclick="addressArea.returnToListPage();"> <span style="font-size: 14px;">返 回</span></a>
				</td>
              </tr>
			<tr>
          </table>
          </form>
	</div>
	<!-- Javascript 代码 -->
	<script type="text/javascript" src="common/js/address_area/areaImport.js"></script>
</div>
