<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
/* #spuPage #editPanel td:first-child {
	width: 150px;
}
#spuPage #editPanel .input-content {
	width: 150px;
} */
#spuPage #editPanel .search_box{width: 190px;display: inline-block;height: 32px;border: 1px solid #CCCCCC;}
#spuPage #editPanel .search_box input{border: 0;background: transparent;width: 150px;height: 20px;margin: 5px;outline: none;}
#spuPage #editPanel .search .icon-search{cursor: pointer;position: initial;display: inline-block;width: 16px;zoom: 1;}
#spuPage #editPanel .search .icon-remove{margin-left: 10px;cursor: pointer;position: initial;display: inline-block;width: 16px;zoom: 1;} 
</style>
<div style="width: 100%; background-color: #eff5ff;">
	<fieldset>
		<legend>SPU信息</legend>
		<table style="width: 100%">
			<tr>
				<td>SPU名称:</td>
				<td><input  style="width:500px;" value="${spu.name}" readonly="readonly"></input></td>
				<td style="float: right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				onclick="spuInfo.returnToListPage();"> <span>返 回</span></a></td>
			</tr>
		</table>
		<div id="attrs">
			<fieldset>
				<legend>销售属性</legend>
				<table id="skuTable" title="SKU绑定">
				</table>
			</fieldset>
		</div>

		<div style="padding: 10px 20px">
			<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'"
				style="padding: 5px 0px; width: 150px;" onclick="spu.bindSku();">
				<span style="font-size: 14px;">绑定</span>
			</a> <a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="spuInfo.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>

	</fieldset>
</div>
<script type="text/javascript">
	var categoryCode = "${categoryCode}";
	var spuId = "${spu.id}";
	if(categoryCode!=""){
		$.ajax({
			url: "spu/attrGroups/"+categoryCode,
			async: false,
			success : function(data){
				spuInfo.processGroupAttrValues(data,spuId);
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
										dgData[i].skuCode = skuData[j].skuCode;
										dgData[i].skuName = skuData[j].name;
										dgData[i].isNew = false;
										skuData.splice(j,1);
										break;
									}
								//没有属性2
								}else{
									dgData[i].id = skuData[j].id;
									dgData[i].skuCode = skuData[j].skuCode;
									dgData[i].skuName = skuData[j].name;
									dgData[i].isNew = false;
									skuData.splice(j,1);
									break;
								}
							}
						}
					}
					
					colArr.push({
						field : 'id',
						title : 'SKU编码',
						width : 150,
						align : 'center',
					},{
						field : 'skuName',
						title : 'SKU名称',
						width : 450,
						align : 'center',
					},{
						field : 'handle',
						title : '操作SKU',
						width : 300,
						align : 'center',
						formatter : function(value,row) {
							return "<div class='search'><div class='search_box'><input type='text' />"+
							"<span class='icon-search' onclick='spu.getSkuInfo(this);'>&nbsp;</span></div>"+
							"<span class='icon-remove'  onclick='spu.unbindSku(\""+row.skuCode+"\",this)'>&nbsp;</span></div>";
						}
					},{
						field : 'isNew',
						hidden : true
					});
					$(spu.panelId + " #skuTable").datagrid({
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
	spu.getSkuInfo = function(obj){
		
		var skuCode = $(obj).prev('input').val();
		spu.bindSkuTempCode = skuCode;
		spu.bindSkuTempIndex = $(obj).parents('tr').attr('datagrid-row-index');
		var row = $(spu.panelId + " #skuTable").datagrid('getRows')[spu.bindSkuTempIndex];
		if(row.isNew == false){
			$.messager.alert('操作失败', "请先解绑", 'warning');
			return;
		}
		$.o2m.openMagnifierWindow('查询商品', 'icon-search', 500,
				500,'sku/queryFdj?type=2');
		
		return false;
	}
	
	spu.unbindSku = function(skuCode,obj){
		var row = $(spu.panelId + " #skuTable").datagrid('getRows')[$(obj).parents('tr').attr('datagrid-row-index')];
		if(row.isNew != false){
			$(spu.panelId + " #skuTable").datagrid('updateRow',{
				index: parseInt($(obj).parents('tr').attr('datagrid-row-index')),
				row: {
					id:null,
					skuCode: null,
					skuName: null,
					isNew : true
				}
			});
		}else{
			if(null != row.skuCode){
				$.ajax({
					url: "sku/unbind/"+skuCode,
					async: false,
					success : function(result){
						if($.o2m.handleActionResult(result)){
							$(spu.panelId + " #skuTable").datagrid('updateRow',{
								index: parseInt($(obj).parents('tr').attr('datagrid-row-index')),
								row: {
									id:null,
									skuCode: null,
									skuName: null,
									isNew : true
								}
							});
						}
					}
				});
			}
		}
	}
	
	spu.bindSku = function(){
		var spuId = "${spu.id}";
		var rows = $(spu.panelId + " #skuTable").datagrid('getRows');
		var obj = {};
		var skus = [];
		for(var i = 0;i<rows.length;i++){
			if(undefined != rows[i].skuCode && rows[i].skuCode != ''&& true == rows[i].isNew){
				var row = new Object();
				row.skuCode = rows[i].skuCode;
				row.attrId1 = rows[i].attrId1;
				row.attrId2 = rows[i].attrId2;
				row.attrValue1 = rows[i].attrValue1;
				row.attrValue2 = rows[i].attrValue2;
				skus.push(row);
			}
		}
		obj.spuId = spuId;
		obj.bindingSkus = skus;
		if(skus.length>0){
			$.o2m.showProgressing();
			$.ajax({ 
		        type:"POST", 
		        url:"spu/bindingSku", 
		        dataType:"json",      
		        async:false,
		        contentType:"application/json",
		        data:JSON.stringify(obj), 
		        success:function(result){
		        	$.o2m.closeProgressing();
		        	if($.o2m.handleActionResult(result)){
		        		for(var i =0 ;i<rows.length;i++){
		        			if(undefined != rows[i].skuCode && rows[i].skuCode != ''&& true == rows[i].isNew){
		        				rows[i].isNew = false;
		        			}
		        		}
		        	}
		        } 
		    }); 
		}else{
			$.messager.alert('操作失败', '请添加新增或修改SKU信息', 'warning');
		}
	}
	
</script>
