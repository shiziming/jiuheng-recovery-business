<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script src="<%=request.getContextPath()%>/js/webuploader/webuploader.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/webuploader/webuploader.css">
<div id="material_uploader">
	<div align="left">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			onclick="spuInfo.returnToListPage();">返回</a>
	</div>
	<!-- 列表-->
		<div class="btns">
				<div id="picker">
					选择文件
				</div>
				<button id="ctlBtn" class="btn btn-default">
					开始上传
				</button>
			</div>
			
	<table id='dgtable'
		style="text-align: center; width: 100%; height: 100%; padding: 15px"></table>
</div>
<style>
#material_uploader .btns {
	width: 212px;
	margin: 0 auto;
}

#material_uploader #picker {
	float: left;
}

#material_uploader #ctlBtn {
	background-image: -webkit-linear-gradient(top, #fff 0, #e0e0e0 100%);
	background-image: linear-gradient(to bottom, #fff 0, #e0e0e0 100%);
	background-repeat: repeat-x;
	color: #333;
	background-color: #fff;
	display: inline-block;
	padding: 8px 14px;
	font-size: 12px;
	line-height: 1.428571429;
	cursor: pointer;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-left: 50px;
}
</style>
<script type="text/javascript">
	$('#material_uploader #dgtable').datagrid({
		title : '文件信息',
		striped : true,
		fitColumns : true,
		height: 500,
		singleSelect : true,
		idField : 'id',
		rownumbers : true,
		columns : [ [ {
			field : 'id',
			title : 'id',
			hidden : true
		},{
			field : 'name',
			title : '文件名',
			width : 100
		}, {
			field : 'size',
			title : '大小',
			width : 50
		}, {
			field : 'status',
			title : '状态',
			width : 100,
			formatter : function(value,row) {
				if(value == 0){
					return "准备";
				}else if(value == 1){
					return "<span style='color:green'>成功</span>";
				}else{
					return "<span style='color:red'>"+value+"</span>";
				}
			}
		} ] ]
	});
	var spuId = "${spu.id}";
	spuInfo.uploader = WebUploader.create({
		auto : false,
		compress : false,
		method  : 'POST',
		swf : ctx + '/js/webuploader/Uploader.swf',
		server : ctx+'/spic/saveSpuMaterial',
		pick : '#material_uploader #picker'
	});
	spuInfo.uploader.on('fileQueued', function(file) {
		$('#material_uploader #dgtable').datagrid('appendRow',{
			id : file.id,
			name : file.name,
			size : file.size/1000 + 'kb',
			status : 0
		});
	});
	spuInfo.uploader.on('uploadAccept', function(object,ret) {
		var result = jQuery.parseJSON(ret._raw);
		if(result.code == 1){
			$('#material_uploader #dgtable').datagrid('updateRow',{
				index: parseInt(object.file.id.split('_')[2]),
				row: {
					status: result.msg
				}
			});
			return false;
		}else{
			$('#material_uploader #dgtable').datagrid('updateRow',{
				index: parseInt(object.file.id.split('_')[2]),
				row: {
					status: 1
				}
			});
		}
	});
	
	$('#material_uploader #ctlBtn').on('click', function() {
		spuInfo.uploader.upload();
	});
</script>
	
