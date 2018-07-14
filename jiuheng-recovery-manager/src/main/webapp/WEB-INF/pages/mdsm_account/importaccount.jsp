<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="mdsm_accountImportPage" style="width: 100%;">
	<!-- 详细？-->
	<div class="mdsm_accountImportPage" style="padding:25px" align="left">
		<form id="mdsm_accountImport_form" enctype="multipart/form-data"  action="mdsm_account/importPayAccount" method="post">
		<table >
			<tr style="text-align: left">
				<td style="width: 400px" id="mdsm_account_pleaseSelectId" >请选择</td>
			<tr>
				<td style="width: 400px">
				<input type="file" name="mdsm_account_fileimport" id = "mdsm_account_fileimportId" buttonText="浏览"
						 data-options="prompt:'选择文件' ,required:true, novalidate:true,validType:'disableSpecialChar'"
						style="width: 100%">
                </td>
              </tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
              <tr>
              	<td style="text-align: left; width: 400px">
					<!-- <a href="${ftpPath}" style="padding: 5px 0px; width: 80px; margin-left: 0px" class="easyui-linkbutton" ><span style="font-size: 14px;">下载模板</span></a> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
					<a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.mdsm_accountImportUtils.importExcel(this);"><span style="font-size: 14px;">上传</span></a>
					<a href="javascript:void(0);" style="padding: 5px 0px; width: 80px; margin-left: 20px" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				onclick="mdsm_account.returnToListPage();"> <span style="font-size: 14px;">返 回</span>
			</a>
				</td>
              </tr>
			<tr>
          </table>
          </form>
	</div>
	<!-- Javascript 代码 -->
	<script type="text/javascript" src="common/js/mdsm_account/mdsm_accountImport.js"></script>
</div>
