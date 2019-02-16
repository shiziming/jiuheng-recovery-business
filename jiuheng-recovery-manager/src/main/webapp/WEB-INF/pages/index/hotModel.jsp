<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="hotModel_Add_Page">
    <table id="dg"></table>
    <form id="searchForm">
        <table class="table table-hover table-condensed"
               style="width: 100%; padding: 7px 80px 0px 80px">
            <tr>
                <td width="10%"></td>
                <td width="10%"></td>
                <td width="10%" align="center">
                    <a href="#" class="easyui-linkbutton"	data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
                       onclick="hotModel_add.save();">保存</a>
                <td width="10%"></td>
                <td width="10%"></td>
                <td width="10%"></td>
            </tr>
        </table>
    </form>
    <div id="tb" style="display: none;">
        <a href="javascript:void(0);"	class="easyui-linkbutton"
           data-options="iconCls:'icon-add',plain:true" onclick="hotModel_add.addRow();">增加</a>
        <a href="javascript:void(0);" class="easyui-linkbutton"
           data-options="iconCls:'icon-remove',plain:true" onclick="hotModel_add.delRow();">删除</a>
    </div>
    <div class="easyui-window" data-options="closed:true,cache:false" id="magnifier"></div>
</div>

<script type="text/javascript"	src="common/js/index/hotModel.js"></script>
<script type="text/javascript" src="common/js/common/ajaxupload.js"></script>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<script type="text/javascript" src="common/js/common/uploadFile.js"></script>
