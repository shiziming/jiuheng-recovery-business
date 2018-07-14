<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="spuPage">
	 <div id="tb">  
     <input id="codeid" name="code" type="text" class="inputbox inputTxtByName" placeholder="请输入要修改用户账号" />                 
     <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="serch()">搜索</a>
     </div>
     <div id='openUpdateWindow'></div>
     <div id="show">
     	<table class="easyui-datagrid" id="dg" data-options="fitColumns:true,singleSelect:true">
		    <thead>   
		        <tr>   
		            <th bgcolor="#66DD00" data-options="field:'RYDM',width:100">编号</th>   
		            <th data-options="field:'RYMC',width:100">姓名</th>   
		            <th data-options="field:'GSDM',width:100">所在公司编号</th>
		            <th data-options="field:'CZYZH',width:100">账号</th>  
		        </tr>   
		    </thead>   
		</table>  
     </div>
</div>
<script type="text/javascript">

function serch(){
	var code=$('#codeid').val();
	$('#dg').datagrid({
	method:'post',
	 url:'${ctx}power/queryUserByCode?currtime=' + new Date(),
	 queryParams: {
		code:code
	}
	 });
	}
	$('#dg').datagrid({
		onDblClickRow: function(rowIndex, rowData){
		        $('#openUpdateWindow').window({
		            width: 400,
		            height: 300,
		            modal: true,
		            method:'post',
		            href: "${ctx}power/openUpdateWindow?currtime=" + new Date(),
		            queryParams: {
		            	code:rowData.RYDM,
		        		name:rowData.RYMC
		        	},
		            title: "修改用户密码"
		        });
		}
	});

</script>