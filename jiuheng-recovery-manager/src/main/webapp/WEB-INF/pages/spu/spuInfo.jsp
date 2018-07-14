<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div style="width: 100%;height:100%; background-color: #eff5ff;">
<form>
	<fieldset>
		<legend>SPU信息</legend>
		<table>
			<tr>
				<td>SPU名称:</td>
				<td><input  style="width: 500px" value="${spu.name }" readonly="readonly"></input></td>
			</tr>
		</table>
		<div id=attrs>
			<fieldset>
				<legend><span style="color:red">*</span>&nbsp;推荐语</legend>
				<textarea style="width: 500px;height: 50px;resize:none" readonly="readonly">${spu.recommendWord}</textarea>
			</fieldset>
			<fieldset>
				<legend>包装清单</legend>
				<textarea style="width: 500px;height: 50px;resize:none" readonly="readonly">${spu.packingList}</textarea>
			</fieldset>
			<fieldset>
				<legend>销售属性</legend>
				<div id="skuAttrDiv">
				</div>
			</fieldset>
<!-- 			<fieldset>
				<legend>SPU属性</legend>
				<div id="spuAttrDiv">
				</div>
			</fieldset> -->
		</div>

		<div style="padding: 10px 20px">
			<a href="javascript:void(0);" id="btnReturn"
				class="easyui-linkbutton" data-options="iconCls:'icon-back'"
				style="padding: 5px 0px; width: 150px; margin-left: 50px"
				onclick="spuInfo.returnToListPage();"> <span
				style="font-size: 14px;">返 回</span>
			</a>
		</div>

	</fieldset>
</form>
</div>
<script type="text/javascript">
	var spuId = "${spu.id}";
	if(spuId!=""){
 		$.getJSON("spu/skuValues/"+spuId, function(data) {
 			spuInfo.processSkuAttrValues(data);
		}); 
 		$.ajax({
			url: "spu/attrGroups/"+spu.lastCategoryId,
			async: false,
			success : function(data){
				spuInfo.processGroupAttrValues(data,spuId)
			}
		});
/*  		$.getJSON("spu/spuValues/"+spuId, function(data) {
 			spuInfo.processSpuAttrValues(data);
		});  */
	}
</script>
