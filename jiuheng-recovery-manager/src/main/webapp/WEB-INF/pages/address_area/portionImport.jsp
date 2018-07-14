<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="areaImportPage" style="width: 100%;">
	<!-- 详细？-->
	<div class="areaImportPage" style="padding:25px" align="left">
		<form id="areaImport_form" enctype="multipart/form-data"  action="common/import/portionImport" method="post">
		<table >
			<tr>
				<td colspan="11" align="center"><font style="font-size: 17px">请选择上传字段</font></td>
			</tr>
			<tr>
	             <td align="center"><input type="checkbox" name="qx" value="is_gome,18"><font style="font-size: 13px">是否国美</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="delivery_code,10"><font style="font-size: 13px">配送区域代码</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="delivery_fee,14"><font style="font-size: 13px">配送远程费</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="road_fee,15"><font style="font-size: 13px">配送路桥费</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="install_code,12"><font style="font-size: 13px">安装区域代码</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="pos_no,19"><font style="font-size: 13px">POS机编号</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="pick_up_flag,20"><font style="font-size: 13px">是否快递上门取件</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="warehouse_3C_flag,21"><font style="font-size: 13px">仓库3C标记</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="saleOrg_code,22"><font style="font-size: 13px">销售组织代码</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="channel_code,23"><font style="font-size: 13px">渠道编码</font></td>
	             <td align="center"><input type="checkbox" name="qx" value="return_Goods_Mark,24"><font style="font-size: 13px">退货专用标记</font></td>
				 <td align="center"><input type="checkbox" name="qx" value="priority,25"><font style="font-size: 13px">门店优先级</font></td>
			</tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr>
				<td colspan="4"></td>
				<td colspan="2" align="right">
				<input type="file" name="fileimport" id = "fileimportId" buttonText="浏览"
						 data-options="prompt:'选择文件' ,required:true, novalidate:true,validType:'disableSpecialChar'"
						style="width: 100%">
                </td>	
                <td colspan="5"></td>
              </tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
              <tr>
				<td colspan="4"></td>
              	<!-- <td><a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.areaImportUtils.downloadExcel(this);"><span style="font-size: 14px;">下载模板</span></a></td> -->
				<td><a href="javascript:void(0)" style="padding: 5px 0px; width: 80px; margin-left: 20px" class="easyui-linkbutton"  onclick="$.areaImportUtils.importExcel(this);"><span style="font-size: 14px;">上传</span></a></td>
				<td><a href="javascript:void(0);" style="padding: 5px 0px; width: 80px; margin-left: 20px" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
				onclick="addressArea.returnToListPage();"> <span style="font-size: 14px;">返 回</span></a>
				</td>
				<td colspan="5"></td>
              </tr>
			<tr>
          </table>
          </form>
	</div>
	<!-- Javascript 代码 -->
	<script type="text/javascript" src="common/js/address_area/areaImport.js"></script>
</div>
