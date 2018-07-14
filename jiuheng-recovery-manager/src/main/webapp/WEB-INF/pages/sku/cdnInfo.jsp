<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#cdn_info .main_imgs {
	margin: 10px;
	width: 350px;
	height: auto;
}

#cdn_info .direction_imgs {
	width: 400px;
	height: auto;
}

#cdn_info .warranty_imgs {
	width: 400px;
	height: auto;
}

</style>
<div id="cdn_info" style="width: 100%;">
	<div align="center">
		<p>
			SKU编码 : <span style="color: red">${sku.id}</span> &nbsp; &nbsp;
			SKU名称：<span style="color: red">${sku.name}</span>
		</p>
		<div align="center" class="easyui-panel" style="padding: 5px;">
			<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton"
				data-options="iconCls:'icon-back',plain:true"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="skuInfo.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>
	</div>
		<fieldset style="margin-left: 20px;width: 500px">
			<legend>主图</legend>
			<div id="mainpic"></div>
		</fieldset>
	<div>
		<fieldset style="margin-left: 20px;float: left;width: 500px">
			<legend>电子说明书</legend>
			<div id="direction"></div>
		</fieldset>
		<fieldset style="margin-left: 20px;float: left;width: 500px">
			<legend>保修卡</legend>
			<div id="warranty"></div>
		</fieldset>
	</div>
</div>

<script>
		var skuId = "${sku.id}";
		//查询主图
		$.ajax({
			url: "sku/pic/getSkuCdnMainPic/"+skuId,
			async: false,
			success : function(result){
				if(result.code != undefined && result.code == 0){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location && 1 == data.inx){
							var div =  $('<div class="mainpic-div" pic-id="'+data.id+'"></div>'); 
							div.append('<img class="main_imgs" src = '+$.o2m.addTimeStampToImageUrl(data.url)+'></img>');
							div.append('<span>'+data.location+"_"+data.inx+fileType+'</span>');
							$('#cdn_info #mainpic').append(div);
						}
					});
				}
			}
		});
		//显示图片
		$.ajax({
			url: "sku/pic/getSkuCdnInfo/"+skuId,
			async: false,
			success : function(result){
				if(result.code != undefined && result.code == 0){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location){
							$('#cdn_info #mainpic').empty();
							var div =  $('<div class="mainpic-div" pic-id="'+data.id+'"></div>'); 
							div.append('<img class="main_imgs" src = '+$.o2m.addTimeStampToImageUrl(data.url)+'></img>');
							div.append('<span>'+data.location+"_"+data.inx+fileType+'</span>');
							$('#cdn_info #mainpic').append(div);
						}else if(3 == data.location){
							var div =  $('<div class="direction-div" pic-id="'+data.id+'"></div>'); 
							div.append('<img class="direction_imgs" src = '+$.o2m.addTimeStampToImageUrl(data.url)+'></img>');
							div.append('<span>'+data.location+"_"+data.inx+fileType+'</span>');
							$('#cdn_info #direction').append(div);
						}else if(4 == data.location){
							var div =  $('<div class="warranty-div" pic-id="'+data.id+'"></div>'); 
							div.append('<img class="warranty_imgs" src = '+$.o2m.addTimeStampToImageUrl(data.url)+'></img>');
							div.append('<span>'+data.location+"_"+data.inx+fileType+'</span>');
							$('#cdn_info #warranty').append(div);
						}
					});
				}
			}
		});
		
</script>
