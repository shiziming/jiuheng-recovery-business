<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#check_info .main_imgs {
	margin: 10px;
	width: 350px;
	height: auto;
}

#check_info .direction_imgs {
	width: 400px;
	height: auto;
}

#check_info .warranty_imgs {
	width: 400px;
	height: auto;
}

</style>
<div id="check_info" style="width: 100%;">
	<div align="center">
		<p>
			SKU编码 : <span style="color: red">${sku.id}</span> &nbsp; &nbsp;
			SKU名称：<span style="color: red">${sku.name}</span>
		</p>
		<div align="center" class="easyui-panel" style="padding: 5px;">
			<c:if test="${FUNC_CHECK}">
				<a href="sku/pic/downPic/${sku.id}" target="_blank"
					class="easyui-linkbutton"
					data-options="iconCls:'icon-add',plain:true"
					style="padding: 5px 0px; width: 150px;"> <span
					style="font-size: 14px;">下载图片</span>
				</a>
				<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-ok'"
					onclick="skuInfo.check(true);"
					style="padding: 5px 0px; width: 150px;"> <span
					style="font-size: 14px;">审批</span>
				</a>
				<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-cancel'"
					onclick="skuInfo.check(false);"
					style="padding: 5px 0px; width: 150px;"> <span
					style="font-size: 14px;">不同意</span>
				</a>
			</c:if>
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
			url: "sku/pic/getSkuCTMainPic/"+skuId,
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
							$('#check_info #mainpic').append(div);
						}
					});
				}
			}
		});
		//显示图片
		$.ajax({
			url: "sku/pic/getSkuMaterialInfo/"+skuId,
			async: false,
			success : function(result){
				if(result.code != undefined && result.code == 0){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location){
							$('#check_info #mainpic').empty();
							var div =  $('<div></div>');
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="main_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							$('#check_info #mainpic').append(div);
						}else if(3 == data.location){
							var div =  $('<div></div>'); 
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="direction_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							
							$('#check_info #direction').append(div);
						}else if(4 == data.location){
							var div =  $('<div></div>'); 
							if(fileType != '.BMP' && fileType != '.PNG' && fileType != '.GIF' && fileType != '.JPG' && fileType != '.JEPG'){
								div.append('<a target="_blank" href = '+picUrl + data.url+'>'+arr[1]+"_"+arr[2]+'</a>');
							}else{
								div.append('<img class="warranty_imgs" src = '+picUrl + data.url+'></img>');
								div.append('<span>'+arr[1]+"_"+arr[2]+'</span>');
							}
							$('#check_info #warranty').append(div);
						}
					});
				}
			}
		});
		
		//审核图片
		skuInfo.check = function(flag){
			$.ajax({ 
		        type:"POST", 
		        url:"sku/pic/check",
		        data:{
		        	id : skuId,
		        	flag : flag
		        },
		        success:function(msg){
		        	if(msg=='success'){
			        	parent.$.messager.alert('','审核成功！',null,function(){
			        		skuInfo.returnToListPage();
			        	});
		        	}else if(msg=='error'){
		        		parent.$.messager.alert('','审核失败！', msg, function(){
		        			skuInfo.returnToListPage();
		        		});
		        	}
		        }
		    }); 
		}
</script>
