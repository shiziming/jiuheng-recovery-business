<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
#material_info .main_div{
	float: left;
	width: 60px;
	height: 60px;
	margin: 10px
}
#material_info .main_imgs{
	width: 55px;
	height: 55px
}
#material_info .detail_imgs{
	width: 250px;
	height: auto;
}
#material_info .main_div_hover{
	border : 2px solid #e4393c
}
</style>
<div id="material_info" style="width: 100%;">
	<div align="center">
		<p>SPU编码 : <span style="color: red">${spu.code}</span> &nbsp; &nbsp;
		SPU名称：<span style="color: red">${spu.name}</span></p>
		<a href="spic/downSpuMat/${spu.id}" target="_blank" class="easyui-linkbutton"
				data-options="iconCls:'icon-add',plain:true"
				style="padding: 5px 0px; width: 150px;">
				<span style="font-size: 14px;">下载素材</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="spuInfo.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
	</div>
	<fieldset style="float: left;width: 500px">
		<legend>主体</legend>
		<div>
			<img src="" id="img_big_div" style="width: 350px;height: 350px;margin-left: 20px;margin-top: 10px">
		</div>
		<div style="padding-bottom: 20px" id="main_pic">
			<div data-id="1_1" class="main_div">
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_2" class="main_div">
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_3" class="main_div">
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_4" class="main_div">
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_5" class="main_div">
				<img class="main_imgs"/>
				<span></span>
			</div>
		</div>
	</fieldset>
	<fieldset style="float: left;width: 500px">
		<legend>详情文件</legend>
		<div id="mat-detail"></div>
	</fieldset>
</div>

<script>
	$("#material_info .main_div").mouseover(function(){
		$(this).addClass('main_div_hover');
		$("#material_info #img_big_div").attr('src',$(this).find('img').attr('src'));
	});
	$("#material_info .main_div").mouseout(function(){
		$(this).removeClass('main_div_hover');
	});
		var spuId = "${spu.id}";
		$.ajax({
			url: "spic/getSpuMaterialInfo/"+spuId,
			async: false,
			success : function(result){
				if(result.code != undefined && result.code == 0){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location){
							var li = $('#material_info').find('#main_pic').find('div[data-id=1_'+data.inx+']');
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								li.find('span').html('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								li.find('img').attr('src',picUrl + data.url);
								li.find('span').html(arr[1]+"_"+arr[2]);
							}
						}else{
							var div =  $('<div></div>'); 
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="detail_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							
							$('#material_info #mat-detail').append(div);
						}
					});
				}
			}
		});
</script>
