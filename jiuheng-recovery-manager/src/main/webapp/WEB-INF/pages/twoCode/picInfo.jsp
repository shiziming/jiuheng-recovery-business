<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="material_info" style="width: 100%;">
       <div  style="height:30px;" align="center"  >
		    <a target="_blank" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true"
				onclick="twocode.btnExport();"
				style="padding: 5px 0px; width: 150px;"> <span
				style="font-size: 14px;">下载二维码</span>
		    </a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-back',plain:true"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="twocode.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
	    	</a>
		</div>
	<fieldset style="float: left; width:500px;overflow: hidden;" >
		<legend>二维码</legend>
		<div id="mat-detail"></div>
	</fieldset>
</div>

<script>
	var rows = $(twocode.dgId).datagrid("getSelections");
	if (rows.length != 0) {
		var storeCodes = [];
		var skuIds = [];
		for (var i = 0; i < rows.length; i++) {
			var storeCode = rows[i].storeCode;
			var skuId = rows[i].skuId
			storeCodes.push(storeCode);
			skuIds.push(skuId);
		}
		//下载二维码
		twocode.btnExport = function() {
			window.location.href = "twocode/export?storeCodes=" + storeCodes
					+ "&skuIds=" + skuIds;
		}
		$.ajax({
					type : "POST",
					url : "twocode/showTwoCode?storeCodes=" + storeCodes+ "&skuIds=" + skuIds,
					dataType : "json",
					contentType : "application/json",
					success : function(result) {
						if (result.code != undefined && result.code == 0) {
							$.each(result.data,function(i, data) {
									var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
									var name = data.url.substr(data.url.lastIndexOf("/") + 1);
									var arr = name.split("_");
									var div = $('<div style="overflow: hidden;border:1px dashed black;height:125px" ></div>');
									if (fileType != '.BMP'&& fileType != '.PNG'&& fileType != '.GIF'&& fileType != '.JPG'&& fileType != '.JEPG') {
											div.append('<a align="center" target="_blank" href = '+picUrl + $.o2m.addTimeStampToImageUrl(data.url)+'>'+ arr[0]+ "_"+ arr[1]+ '</a>');
									} else {
											div.append('<span  style="float: left;width: 300px;text-align:center;margin-top:5%" >'+ data.skuId + "<br>"+data.skuName + '<br>'+data.storeCode + "<br>"+ data.storeName +'</span>');
											div.append('<img  style="margin-top:2%" class="detail_imgs" src = '+picUrl + $.o2m.addTimeStampToImageUrl(data.url)+'></img>');
											}
												$('#material_info #mat-detail').append(div);
											});
						}
					}
				});
	} else {
		$.messager.alert('警告', '至少选择一条记录!', 'warning');
	}
</script>
