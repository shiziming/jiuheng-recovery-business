<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="jobPowerPage">
<input type="hidden" value="${FUNC_MAINTAIN}" id="MAINTAIN">
	<div class="easyui-panel" id='uoloadExcelPage' title="查询条件" style="width: 100%; height: 150px; padding: 10px; background: #ffffff;"
			data-options="collapsible:true">
		<form id="uploadExcel" action="power/uploadPowerExcel" method='post' enctype="multipart/form-data">
		<table>
			<tr>
				<td width="100px"></td>
				<td width="200px" align="left">
				<c:if test="${FUNC_MAINTAIN}">
				<input type="file" name="fileimport" id = "fileimportId" style="width:140px" onclick="$('#saveExport_btn').linkbutton('enable');" />
				<a href="#" class="easyui-linkbutton" id='saveExport_btn' iconCls="icon-save" onclick="saveExport(this);">上传</a>
				</c:if>
				</td>
				<td width="100px" align="right">职位编码:</td>
				<td align="left" width="100px"><input name="gwdm" type="text"
					placeholder="请输职位编码" class="span2" id="gwdmid"></td>
				<td width="100px" align="right">职位名称:</td>
				<td align="left" width="100px"><input name=gwmc type="text"
					placeholder="职位名称" class="span2" id="gwmcid"></td>
			</tr>
			<tr>
				<td width="100px"></td>
				<td width="200px" align="left">系统编号:
				<input name="xtcxidName" type="text"
					placeholder="请输系统编号" class="span2" id="xtcxidid"></td>
				<td width="50px" align="right">系统名称:</td>
				<td align="left" width="100px"><input name="xtcxmc" type="text"
					placeholder="系统名称" class="span2" id="xtcxmcid"></td>
				<td></td>
				<td><a href="#" id="query"
							class="easyui-linkbutton" iconCls="icon-search" onclick="queryByConditiona()">查询</a></td>
			</tr>
			
				
		</table>
		</form>
	</div>
	<div id="toolbar">
		<c:if test="${FUNC_MAINTAIN}">
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-save" plain="true" onclick="jobPower.downloadTemplate()">下载导入模板</a> 
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-save" plain="true" onclick="jobPower.downloadPowerTemplate()">下载权限数据</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" 	iconCls="icon-save" plain="true" onclick="jobPower.initExportExcel()">导出数据</a>
		</c:if>
		</div>
	<div data-options="region:'center',border:false" id="show" >
		<table class="easyui-datagrid" id="dg1" data-options="url:'power/queryAllPower',fitColumns:true,striped : true,
				pageSize: 20,height : document.documentElement.clientHeight * 0.86,pagination:true,singleSelect:true,rownumbers:true">
			<thead>   
		        <tr>   
		            <th data-options="field:'gwdm',width:100">职位编码</th>   
		            <th data-options="field:'gwmc',width:100">职位名称</th>   
		            <th data-options="field:'xtcxid',width:100">系统ID</th>
		            <th data-options="field:'xtcxmc',width:100">系统名称</th>
		            <th field="操作" width="80"  data-options="formatter:formatOper">操作</th>   
		        </tr>   
		    </thead> 
		</table>
	</div>
	
     <!-- 根据职务编码查询权限-->
	    <div id="tousersid" title="用户所拥有权限" class="easyui-window"
				style="width:650px;height:500px;padding:10px 20px" closed="true" data-options="region:'center',border:false">
				<input type="hidden" value="" name="GWDM_AND_XTCXID" id="GWDM_And_XTCXID">
		<div id="but1" style="display: none;">
		<c:if test="${FUNC_MAINTAIN}">
			<a href="javascript:void(0);" class="easyui-linkbutton" id="but"
				data-options="iconCls:'icon-add',plain:true"
				onclick="addfunction();">添加功能</a>
		</c:if>
		</div>
		<table class="easyui-datagrid" id="dg2" data-options="border:false"></table>
		</div>
		
		<!-- 添加功能页面 -->
		<div id="addFunctionView"></div>
</div>
<script type="text/javascript">

function saveExport(obj){
	//判断上传文件是否为excel
	var fileaa = $('input[name=fileimport]').val();
	if (fileaa.lastIndexOf('.xls') == "-1") {
		$.messager.alert('警告','上传的不是Excle文件,请重新选择！',"warning");
		return;
	}
	var curForm = $('#uploadExcel');
	
	curForm.form('submit',{
		success:function(data){
			var data =eval('('+data+')');
	    	if (data.code== 0) {
	    		alert(data.msg);
			$('#dg1').datagrid({url:'power/queryAllPower?currtime='+ new Date()});
	    	}else if(data.code== 1){
	    		alert(data.msg);
	    	}
		}
	});
	curForm.form('clear');
	
}
function formatOper(val,row,index){  
		var MAINTAIN=$("#MAINTAIN").val();
		if(MAINTAIN){
		 	return '<a href="#" onclick="openUsers(\'' + row.gwdm+","+row.xtcxid + '\');">查看所拥有功能</a>'+
		 	' <a href="#" onclick="del(\'' + row.gwdm + '\');">删除该职务</a>';
		 }else{
			 return '<a href="#" onclick="openUsers(\'' + row.gwdm+","+row.xtcxid + '\');">查看所拥有功能</a>'
		 }
}

function openUsers(power){
	$('#tousersid').window('open');
	var MAINTAIN=$("#MAINTAIN").val();
	$('#GWDM_And_XTCXID').val(power);
 	$('#dg2').datagrid({
 		url:'${ctx}power/queryPowerByGWID?currtime='+ new Date(),
 		queryParams: {
 			power: power
 		},
 		title : "功能展示",
        striped : true,
        collapsible : true,
        autoRowHeight : true,
        remoteSort : false,
        idField : 'xtgnid',
        rownumbers : true,
        fitColumns : true,
        nowrap : true,
        pagination : true,
        pageSize: 20,
        checkOnSelect : false,
        selectOnCheck : false,
        fit : true,
        toolbar:'#but',
 		columns : [ [ {
            field : 'xtmkmc',
            title : '系统模块名称',
            width : 100,
            align : 'center'
        },{
            field : 'xtgnmc',
            title : '系统功能名称',
            width : 100,
            align : 'center'
        },{
            field : 'power',
            title : '功能权限',
            width : 100,
            align : 'center'
        },{
            field : 'powerid',
            title : '功能权限ID',
            hidden: true,
        },{
            field : 'fzbj',
            title : '父子标记',
            hidden: true,
        },{
            field : 'action',
            title : '操作',
            width : 40,
            align : 'center',
            formatter : function(value, row, index) {
            	if(MAINTAIN){
            	return '<a href="#" onclick="delPower(\'' + power +"," + row.xtgnid + "," + row.powerid +'\');">删除</a>';
            	}
            	}
        }
        ] ]

 	});
}
	
function delPower(GWDMandXTCXIDandXTGNIDandPowerid){
	var isok=confirm("确认删除此功能么？");
	if(isok){
	$.ajax({
		url:'${ctx}power/delXTGNbyGWDM?currtime='+ new Date(),
		type:'post',
		data:{"GWDMandXTCXIDandXTGNIDandPowerid":GWDMandXTCXIDandXTGNIDandPowerid},
		success:function(data){
	    	if (data.code== 0) {
	    		$('#dg2').datagrid('load');
	    		alert(data.msg);
	    	}else if(data.code== 1){
	    		alert(data.msg);
	    	}
		}
	});
	}
}
function del(GWDM){
	var isok=confirm("确认删除此岗位么,删除后其他系统同步删除？");
	if(isok){
		$.ajax({
			url:"${ctx}power/delGWDM",
			type:"post",
			data:{"GWDM":GWDM},
			success:function(data){
				if(0==data.code){
					$('#dg1').datagrid({url:'power/queryAllPower'});
					alert("删除成功");
				}else{
					alert("删除失败");
				}
			}
		});
	}
}
function addfunction(){
	$('#addFunctionView').window({
        width: 500,
        height: 300,
        modal: true,
        method:'post',
        href: "${ctx}power/openAddFunctionWindow?currtime=" + new Date(),
        queryParams: {
        	power:$('#GWDM_And_XTCXID').val()
    	},
        title: "添加职位功能"
    });
	
	
}

function queryByConditiona(){
	var gwdmId=$('#gwdmid').val();
	var gwmcId =$('#gwmcid').val();
	var xtcxidId =$('#xtcxidid').val();
	var xtcxmcId =$('#xtcxmcid').val();
	$("#dg1").datagrid({
		queryParams: {
			gwdmId:gwdmId,
			gwmcId :gwmcId,
			xtcxidId :xtcxidId,
			xtcxmcId :xtcxmcId,
			page : 1,
            rows : 20
		},
		url:'power/queryAllPower?currtime='+ new Date()
		});
	
}
</script>
<script type="text/javascript" src="common/js/power/jobPower.js"></script>