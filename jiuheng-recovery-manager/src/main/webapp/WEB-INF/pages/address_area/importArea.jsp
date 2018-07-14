<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="areaImportPage" style="width: 100%;">
	<!-- 详细？-->
	<div class="areaImportPage" style="padding:25px" align="left">
		<form id="areaImport_form" enctype="multipart/form-data"  action="common/import/importAddressArea" method="post">
		<table >
			<tr style="text-align: left">
				<td style="width: 400px" id="pleaseSelectId" >请选择</td>
			<tr>
				<td style="width: 400px">
				<input type="file" name="fileimport" id = "fileimportId" buttonText="浏览"
						 data-options="prompt:'选择文件' ,required:true, novalidate:true,validType:'disableSpecialChar'"
						style="width: 100%">
                </td>
              </tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
              <tr>
              	<td style="text-align: left; width: 400px">
					<!-- 
					<a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.areaImportUtils.downloadExcel(this);"><span style="font-size: 14px;">下载模板</span></a> -->
					<a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.areaImportUtils.importExcel(this);"><span style="font-size: 14px;">上传</span></a>
					<a href="javascript:void(0);" style="padding: 5px 0px; width: 80px; margin-left: 20px" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				onclick="addressArea.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
			</a>
				</td>
              </tr>
			<tr>
          </table>
          </form>
	</div>
	<!-- Javascript 代码 -->
	<script type="text/javascript" src="common/js/address_area/areaImport.js"></script>
</div>
