<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script src="<%=request.getContextPath()%>/js/webuploader/webuploader.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/webuploader/webuploader.css">
<div id="machine_uploader">
	<!-- 列表-->
	<div align="left">
		<a class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="spic.returnToListPage();">返回</a>
	</div>
		<div class="btns">
				<div id="picker">
					选择文件
				</div>
				<button id="ctlBtn">
					开始上传
				</button>
			</div>
	<table id='dgtable'
		style="text-align: center; width: 100%; height: 100%; padding: 15px"></table>
</div>
<style>
#machine_uploader .btns {
	width: 212px;
	margin: 0 auto;
}

#machine_uploader #picker {
	float: left;
}

#machine_uploader #ctlBtn {
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
	$('#machine_uploader #dgtable').datagrid({
		title : '文件信息',
		striped : true,
		fitColumns : true,
		height : 300,
		toolbar : '#machine_uploader #tb',
		singleSelect : true,
		idField : 'id',
		rownumbers : true,
		columns : [ [ {
			field : 'id',
			title : 'id',
			hidden : true
		}, {
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
			formatter : function(value, row) {
				if (value == 0) {
					return "准备";
				} else if (value == 1) {
					return "<span style='color:green'>成功</span>";
				} else {
					return "<span style='color:red'>" + value + "</span>";
				}
			}
		} ] ]
	});

	spic.uploader = WebUploader.create({
		auto : false,
		method : 'POST',
		swf : ctx + '/js/webuploader/Uploader.swf',
		server : ctx + '/spic/saveSpuMachine',
		pick : '#machine_uploader #picker',
		accept : {
			extensions : 'gif,jpg,jpeg,bmp,png'
		},
		fileSingleSizeLimit : 1024000
	});
	spic.uploader.on('fileQueued', function(file) {
		$('#machine_uploader #dgtable').datagrid('appendRow', {
			id : file.id,
			name : file.name,
			size : file.size / 1000 + 'kb',
			status : 0
		});
	});
	spic.uploader.on('uploadAccept', function(object, ret) {
		var result = jQuery.parseJSON(ret._raw);
		if (result.code == 1) {
			$('#machine_uploader #dgtable').datagrid('updateRow', {
				index : parseInt(object.file.id.split('_')[2]),
				row : {
					status : result.msg
				}
			});
			return false;
		} else {
			$('#machine_uploader #dgtable').datagrid('updateRow', {
				index : parseInt(object.file.id.split('_')[2]),
				row : {
					status : 1
				}
			});
		}
	});
	spic.uploader.on('error', function(type) {
		if(type == 'Q_TYPE_DENIED'){
			$.messager.alert('操作失败', '文件类型有误', 'warning');
		}else if(type == 'F_EXCEED_SIZE'){
			$.messager.alert('操作失败', '文件太大', 'warning');
		}
	});

	$('#machine_uploader #ctlBtn').on('click', function() {
		spic.uploader.upload();
	});
</script>
	
