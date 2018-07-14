<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<meta http-equiv="pragma" content="no-cache">
   <meta http-equiv="content-type" content="no-cache, must-revalidate">
   <meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">
</head>
<style>
#material_info {
	width: 600px;
	margin: 0 auto;
}

#material_info .con_div {
	width: 600px;
	margin: 20px 0;
}

#material_info .con_div img {
	width: 100%;
	display: table-cell;
}

#material_info .con_div_1 div.imgs_div {
	height: 600px;
}

/*a  upload */
#material_info .a-upload {
	padding: 4px 10px;
	height: 20px;
	line-height: 20px;
	position: relative;
	cursor: pointer;
	color: #888;
	background: #fafafa;
	border: 1px solid #ddd;
	border-radius: 4px;
	overflow: hidden;
	display: inline-block;
	*display: inline;
	*zoom: 1
}

#material_info .a-upload  input {
	position: absolute;
	font-size: 100px;
	right: 0;
	top: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	cursor: pointer
}

#material_info .a-upload:hover {
	color: #444;
	border-color: #ccc;
	text-decoration: none
}

#material_info .b-upload {
	top: -50px;
	border: 0;
	width: 50px;
	padding: 0;
	word-wrap: break-word;
	height: 40px;
	margin: 0 5px;
}

#material_info .con_div_1 .b-upload {
	width: 150px;
	font-size: 24px;
	line-height: 40px;
	background-color: transparent;
	top: -320px;
	left: 225px;
}

/*主题图片*/
#material_info #img_big_div {
	width: 400px;
	height: 400px;
}

#material_info #img_big_div img {
	border: 1px solid #ddd;
}

#material_info .clearfix:before, .clearfix:after {
	display: table;
	content: "";
}

#material_info ul.images {
	height: 112px;
	margin: 10px 0 0 -9px;
}

#material_info li .imgs_div {
	height: 60px;
}

#material_info .images li {
	list-style: none;
	width: 60px;
	height: 60px;
	padding-left: 20px;
	padding-top: 8px;
	float: left;
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}

#material_info .images li .imgs {
	width: 60px;
	height: 60px;
	border: 0;
	cursor: pointer;
	display: block;
}

#material_info .images li span {
	line-height: 24px;
}

#material_info .images li a.del_btn {
	color: #4287c8;
	font-size: 12px;
	display: none;
}

#material_info .images li.select a {
	display: block;
}

</style>
<div id="indexGoods_list_page">
<!-- 微店首页商品图片 -->
	<div id="material_info">
	
	<div>
		<a href="#" class="easyui-linkbutton"
					data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-back'"
					onclick="indexGood_Image_panel.back();">返回</a>
			<c:if test="${FUNC_MAINTAIN}">
			<a href="#" class="easyui-linkbutton"
						data-options="toggle:true,group:'g2',plain:true,iconCls:'icon-add'"
						onclick="indexGoods_detailed.downloadImage();">下载图片</a>
			</c:if>
			<font size="10px" color="blue">单据编号：</font><font size="10px" color="red">${indexGoods.orderNum}</font>,<font size="10px" color="blue">商品SPU码：</font><font size="10px" color="red">${indexGoods.spuCode}</font>,<font size="10px" color="blue">商品名称：</font><font size="10px" color="red">${indexGoods.spuName}</font>
	</div>
	<div class="con_div con_div_1">
		<fieldset id="machine_detail" style="padding-top: 30px">
			<legend>详情图片</legend>
		</fieldset>
	</div>
</div>
</div>
		
					
<script type="text/javascript">
var url='${indexGoods.imageURL}';
var content = "<div class='imgs_box'><div class='imgs_div'><img alt='未上传图片' src="+picUrl + $.o2m.addTimeStampToImageUrl(url)+" /></div><p align='center'>"+url.substring(url.lastIndexOf("/")+1)+"</p></div>";
	$('#material_info #machine_detail').append(content);
</script>
	<script type="text/javascript" src="common/js/wdIndexGoods/indexGood_Image_panel.js"></script>

