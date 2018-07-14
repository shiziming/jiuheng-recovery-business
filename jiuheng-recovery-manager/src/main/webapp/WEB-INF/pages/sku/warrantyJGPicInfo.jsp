<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
#machine_info .main_imgs {
	margin: 20px;
	width: 350px;
	height: auto;
}

#machine_info .warranty_imgs {
	width: 400px;
	height: auto;
}
</style>
<div id="machine_info" style="width: 100%;">
	<div align="center">
		<p>
			SKU编码 : <span style="color: red">${sku.id}</span> &nbsp; &nbsp;
			SKU名称：<span style="color: red">${sku.name}</span>
		</p>
		<a id="btnEdit" href="#"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-edit',plain:true"
			style="padding: 5px 0px; width: 150px;"
			onclick="skuInfo.editJGMainPic();"> <span
			style="font-size: 14px;">修改主图</span>
		</a>
		<a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton"
			data-options="iconCls:'icon-back',plain:true"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="skuInfo.returnToListPage();"> <span
			style="font-size: 14px;">返 回</span>
		</a>
	</div>
	<fieldset style="float: left;width: 500px">
		<legend>主图</legend>
		<div id="mainpic"></div>
	</fieldset>
	<fieldset style="float: left;width: 500px">
		<legend>保修卡</legend>
		<div id="warranty"></div>
	</fieldset>
</div>

<script>
		var skuId = "${sku.id}";
		
		$.ajax({
			url: "sku/pic/getSkuJGMainPic/"+skuId,
			async: false,
			success : function(result){
				if(result.code != undefined && result.code == 0){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location && 1 == data.inx){
							var div =  $('<div></div>');
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="main_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							$('#machine_info #mainpic').append(div);
						}
					});
				}
			}
		});
		
		$.ajax({
			url: "sku/pic/getSkuMachineInfo/"+skuId,
			async: false,
			success : function(result){
				if(result.code != undefined && result.code == 0){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location){
							$('#machine_info #mainpic').empty();
							var div =  $('<div></div>');
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="main_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							$('#machine_info #mainpic').append(div);
						}else if(4 == data.location){
							var div =  $('<div></div>'); 
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="warranty_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							$('#machine_info #warranty').append(div);
						}
					});
				}
			}
		});
</script>
