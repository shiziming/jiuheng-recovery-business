<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
#machine_info .main_div {
	float: left;
	width: 57px;
	height: 57px;
	margin: 10px;
	position: relative;
}

#machine_info .main_imgs {
	width: 55px;
	height: 55px;
	border: 1px solid #f2f2f2;
}

#machine_info .detail_imgs {
	width: 400px;
	height: auto;
}

#machine_info .main_div_hover {
	border: 2px solid #e4393c
}

#main_pic div i {
    background-image: url(images/delete.png);
	height: 16px;
	width: 16px;
	position: absolute;
    cursor: pointer;
	background-size: cover;
    margin-top: 3px;
    margin-left: 3px;
    display: none;
	filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/delete.png',  sizingMethod='scale');
}

/*详情*/
#mat-detail div i {
	background-image: url(images/delete.png);
	height: 20px;
	width: 20px;
	position: absolute;
    cursor: pointer;
	background-size: cover;
    margin-top: 10px;
    margin-left: 10px;
    display: none;
	filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/delete.png',  sizingMethod='scale');

}
#machine_info #mat-detail .detail-div{
	position: relative;
}
</style>
<div id="machine_info" style="width: 100%;">
	<div align="center">
		<p>SPU编码 : <span style="color: red">${spu.code}</span> &nbsp; &nbsp;
		SPU名称：<span style="color: red">${spu.name}</span></p>
		<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="spic.returnToListPage();"> <span
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
				<i onclick="spic.delMacPic(this)"></i>
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_2" class="main_div">
				<i onclick="spic.delMacPic(this)"></i>
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_3" class="main_div">
				<i onclick="spic.delMacPic(this)"></i>
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_4" class="main_div">
				<i onclick="spic.delMacPic(this)"></i>
				<img class="main_imgs"/>
				<span></span> 
			</div>
			<div data-id="1_5" class="main_div">
				<i onclick="spic.delMacPic(this)"></i>
				<img class="main_imgs"/>
				<span></span>
			</div>
		</div>
	</fieldset>
	<fieldset style="float: left;width: 500px">
		<legend>详情图片</legend>
		<div id="mat-detail"></div>
	</fieldset>
</div>

<script>
	$("#machine_info .main_div").mouseover(function(){
		$(this).addClass('main_div_hover');
		$("#machine_info #img_big_div").attr('src',$(this).find('img').attr('src'));
		$(this).find("i").show();
	});
	$("#machine_info .main_div").mouseout(function(){
		$(this).removeClass('main_div_hover');
		$(this).find("i").hide();
	});
		var spuId = "${spu.id}";
		$.ajax({
			url: "spic/getSpuMachineInfo/"+spuId,
			async: false,
			success : function(result){
				if(0 == result.code ){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location){
							var div = $('#machine_info').find('#main_pic').find('div[data-id=1_'+data.inx+']');
							div.attr('pic-id',data.id);
							div.find('img').attr('src',$.o2m.addTimeStampToImageUrl(picUrl + data.url));
							div.find('span').html(arr[1]+"_"+arr[2]);
						}else{
							var div =  $('<div class="detail-div" pic-id="'+data.id+'"></div>'); 
							div.append('<i onclick="spic.delMacPic(this)"></i>');
							div.append('<img class="detail_imgs" src = '+$.o2m.addTimeStampToImageUrl(picUrl + data.url)+'></img>');
							div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							$('#machine_info #mat-detail').append(div);
						}
					});
				}
			}
		});
		$("#machine_info .detail-div").mouseover(function(){
			$(this).find("i").show();
		});
		$("#machine_info .detail-div").mouseout(function(){
			$(this).find("i").hide();
		});
		
		spic.delMacPic = function(obj){
			var picId = $(obj).parent('div').attr('pic-id');
			if(confirm("确认删除？")){
		 		$.ajax({
					url: "spic/delSpuMac/"+picId,
					async: false,
					success : function(result){
						if($.o2m.handleActionResult(result)){
							$(obj).parent('div').html('');
						}
					}
				});
			}
		}
		
</script>
