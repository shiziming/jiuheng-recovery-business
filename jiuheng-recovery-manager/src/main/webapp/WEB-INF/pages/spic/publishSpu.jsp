<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
#publish_sku_page_1 .main_div{
	float: left;
	width: 60px;
	height: 60px;
	margin: 10px
}
#publish_sku_page_1 .main_imgs{
	width: 55px;
	height: 55px
}
#publish_sku_page_1 .detail_imgs{
	width: 250px;
	height: auto;
}
#publish_sku_page_1 .main_div_hover{
	border : 2px solid #e4393c
}
</style>
<div id="publish_sku_page_1" style="width: 100%;">
	<div align="center">
		<p>SPU编码 : <span style="color: red">${spu.code}</span> &nbsp; &nbsp;
		SPU名称：<span style="color: red">${spu.name}</span>
			<a style="float: right" class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="spic.returnToListPage();"> <span>返 回</span></a>
		</p>
	</div>
	<div style="float: left;width: 48%">
	<fieldset >
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
		<legend>详情图片</legend>
		<div id="mat-detail"></div>
	</fieldset>
	</div>
	<div style="width: 48%; background-color: #eff5ff;float: left">
		<fieldset>
			<legend>SPU信息</legend>
			<div id="attrs">
				<fieldset>
					<legend>推荐语</legend>
					<textarea style="width: 500px;height: 50px;resize:none" readonly="readonly">${spu.recommendWord}</textarea>
				</fieldset>
				<fieldset>
					<legend>包装清单</legend>
					<textarea style="width: 500px;height: 50px;resize:none">${spu.packingList}</textarea>
				</fieldset>
				<fieldset>
					<legend>销售属性</legend>
					<table id="skuTable" title="SKU绑定">
					</table>
				</fieldset>
			</div>
	
			<div style="padding: 10px 20px">
				<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'"
					style="padding: 5px 0px; width: 150px;" onclick="pic_publish.publish();">
					<span style="font-size: 14px;">发布</span>
				</a> <a href="javascript:void(0);" id="btnReturn"
					class="easyui-linkbutton" data-options="iconCls:'icon-back'"
					style="padding: 5px 0px; width: 150px; margin-left: 50px"
					onclick="spic.returnToListPage();"> <span
					style="font-size: 14px;">返 回</span>
				</a>
			</div>
	
		</fieldset>
	</div>
</div>

<script>

	var pic_publish = {};
	var categoryCode = '${categoryCode}';
	pic_publish.processGroupAttrValues = function(data,spuId){
		for (var i = 0; i < data.length; i++) {
			var fieldset = $('<fieldset>').append("<legend>" + data[i].name + "</legend>").attr('group-id', data[i].id);
			var table = $('<table>');
			$.ajax({
				url: "spu/groupAttrValues/"+categoryCode+"/"+data[i].id+"/"+spuId,
				async: false,
				success : function(data){
					for (var i = 0; i < data.length; i++) {
						var p = $("<p>").append($("<span>").append(data[i].name+" : "));
						if(data[i].values instanceof Array){
							var arr = [];
							for(var j = 0;j<data[i].values.length;j++){
								arr.push(data[i].values[j].goodsattrvalue);
							}
							var span = $("<span>").append(arr.join("、"));
							span.addClass('attr-value');
							p.append(span);
						}
						fieldset.append(p);
					}
				}
			});
			$("#publish_sku_page_1 #attrs").append(fieldset);
		}
	}
	$("#publish_sku_page_1 .main_div").mouseover(function(){
		$(this).addClass('main_div_hover');
		$("#publish_sku_page_1 #img_big_div").attr('src',$(this).find('img').attr('src'));
	});
	$("#publish_sku_page_1 .main_div").mouseout(function(){
		$(this).removeClass('main_div_hover');
	});
		var spuId = "${spu.id}";
		var main_pic = 0;
		var detail_pic = 0;
		var has_bind_sku = false;
 		$.ajax({
			url: "spic/getSpuCdnPicInfo/"+spuId,
			async: false,
			success : function(result){
				if(0 == result.code ){
					$.each(result.data,function(i,data){
						var fileType = data.url.substr(data.url.lastIndexOf(".")).toUpperCase();
						var name = data.url.substr(data.url.lastIndexOf("/")+1);
						var arr = name.split("_");
						if(1 == data.location){
							main_pic = 1;
							var li = $('#publish_sku_page_1').find('#main_pic').find('div[data-id=1_'+data.inx+']');
							li.find('img').attr('src',data.url);
							li.find('span').html(data.location+"_"+data.inx+fileType);
						}else{
							detail_pic = 1;
							var div =  $('<div></div>'); 
							div.append('<img class="detail_imgs" src = '+data.url+'></img>');
							div.append('<span>'+data.location+"_"+data.inx+fileType+'</span>');
							$('#publish_sku_page_1 #mat-detail').append(div);
						}
					});
				}
			}
		}); 
 		

 	if(categoryCode!=""){
		$.ajax({
			url: "spu/attrGroups/"+categoryCode,
			async: false,
			success : function(data){
				pic_publish.processGroupAttrValues(data,spuId);
			}
		});
		$.ajax({
			url: "spu/skuValues/"+spuId,
			async: false,
			success : function(data){
				if(data.length == 0 ){
					$.messager.alert('warn', 'SKU属性未设置', 'warning');
				}else if(data.length > 2){
					$.messager.alert('warn', 'SKU属性超过2个', 'warning');
				}else{
					var colArr = [];
					var dgData = [];
					for(var i = 0;i<data.length;i++){
						var obj = data[i];
						var attrIdObj = new Object();
						attrIdObj.field = 'attrId'+(i+1);
						attrIdObj.hidden = true;
						var attrValObj = new Object();
						attrValObj.width = 80;
						attrValObj.align = 'center';
						attrValObj.field = 'attrValue'+(i+1);
						attrValObj.title = obj.attrName;
						colArr.push(attrIdObj);
						colArr.push(attrValObj);
					}
					//dg数据
					if( data[0].values.length > 0){
						var row = new Object();
						for(var i =0;i<data[0].values.length;i++){
							row.attrId1 = data[0].attrId;
							row.attrValue1 = data[0].values[i];
							if(data[1]){
								row.attrId2 = data[1].attrId;
								if(data[1].values.length > 0){
									for(var j =0;j<data[1].values.length;j++){
										row.attrValue2 = data[1].values[j];
										dgData.push($.extend({}, row));
									}
								}else{
									dgData.push($.extend({}, row));
								}
							}else{
								dgData.push($.extend({}, row));
							}
						}
					}
					//获取已经绑定的sku属性
					var skuData = [];
					$.ajax({
						url: "sku/list/"+spuId,
						async: false,
						success : function(data){
							skuData = data;
						}
					});
					
					//判断sku属性是否已经绑定sku
					for(var i = 0;i<dgData.length;i++){
						for(var j = 0;j < skuData.length ; j++){
							//如果属性1相同
							if(dgData[i].attrId1 == skuData[j].attrId1 && dgData[i].attrValue1 == skuData[j].attrValue1){
								//如果有属性2
								if(dgData[i].attrValue2 !=undefined && dgData[i].attrValue2 != ''){
									//属性2也相同 
									if(dgData[i].attrId2 == skuData[j].attrId2 && dgData[i].attrValue2 == skuData[j].attrValue2){
										dgData[i].id = skuData[j].id;
										dgData[i].skuName = skuData[j].name;
										skuData.splice(j,1);
										has_bind_sku = true;
										break;
									}
								//没有属性2
								}else{
									dgData[i].id = skuData[j].id;
									dgData[i].skuName = skuData[j].name;
									skuData.splice(j,1);
									has_bind_sku = true;
									break;
								}
							}
						}
					}
					
					colArr.push({
						field : 'id',
						title : 'SKU编码',
						width : 120,
						align : 'center',
					},{
						field : 'skuName',
						title : 'SKU名称',
						width : 400,
						align : 'center',
					},{
						field : 'isNew',
						hidden : true
					});
					$("#publish_sku_page_1 #skuTable").datagrid({
						striped : true,
						columns : [ colArr ],
						data : dgData,
						rownumbers : true,
						singleSelect : true,
						fitcolumns: true,
						loadMsg : "数据加载中..."
					});
				}
				
			}
		});
	} 
 	pic_publish.publish = function(){
		if(main_pic + detail_pic < 2){
			$.messager.alert('错误', "必须有一张详情图和主图", 'warning');
			return;
		}
		
		if(!has_bind_sku){
			$.messager.alert('错误', "没有绑定SKU", 'warning');
			return;
		}
		$.o2m.showProgressing();
		$.ajax({ 
	        type:"POST", 
	        url:"spu/publish/"+spuId, 
	        async: false,
	        success:function(result){
	        	$.o2m.closeProgressing();
	        	if($.o2m.handleActionResult(result)){
	        		$(spic.panelId).panel('close');
	        		$(spic.listId).show();
	    	    	$(spic.dgId).datagrid('reload');
	        	}
	        } 
	    }); 
	}
	
	
</script>
