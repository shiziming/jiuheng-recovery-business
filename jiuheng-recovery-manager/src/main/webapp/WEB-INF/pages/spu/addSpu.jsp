<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style type="text/css">
#spuPage #editPanel td:first-child {
	width: 150px;
}

#spuPage #editPanel .input-content {
	width: 150px;
}
</style>
<div style="width: 100%; background-color: #eff5ff;">
	<form>
		<fieldset>
			<legend>SPU信息</legend>
			<table style="width: 100%">
				<tr>
					<td>SPU名称:</td>
					<td><input class="easyui-searchbox" type="text" name="spuName"
						id="spuName" data-options="required:true, novalidate:true"
						style="width: 500px;" /></td>
					<td style="float: right"><a class="easyui-linkbutton"
						data-options="iconCls:'icon-back'"
						onclick="spuInfo.returnToListPage();"> <span>返 回</span></a></td>
				</tr>
			</table>
			<div id="attrs">
				<fieldset>
					<legend>
						<span style="color: red">*</span>&nbsp;推荐语
					</legend>
					<textarea placeholder="请填写SPU推荐语，最多可填72个字！"
						style="width: 500px; height: 50px; resize: none"
						name="recommendWord" id="recommendWord" cols="400px"></textarea>
				</fieldset>
				<fieldset>
					<legend>包装清单</legend>
					<textarea style="width: 500px; height: 50px; resize: none"
						name="packingList" id="packingList"></textarea>
				</fieldset>
				<fieldset>
					<legend>销售属性</legend>
					<table id="skuTable">
					</table>
				</fieldset>
			</div>

			<div style="padding: 10px 20px">
				<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'"
					style="padding: 5px 0px; width: 150px;"
					onclick="spuInfo.createSpu();"> <span style="font-size: 14px;">保
						存</span>
				</a> <a href="javascript:void(0);" id="btnReturn"
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
	$('#spuPage #spuName').searchbox({
		searcher : function(value, name) {
			$.o2m.openMagnifierWindow('查询商品', 'icon-search', 500, 500, 'sku/queryFdj?type=1');
		},
		prompt : 'spu名称'
	});

	var categoryCode = "${categoryCode}";
	if (categoryCode != "") {
		$.getJSON("spu/skuAttrs/" + categoryCode, function(data) {
			spuInfo.processSkuAttrs(data);
		});
		$.ajax({
			url : "spu/attrGroups/" + categoryCode,
			async : false,
			success : function(data) {
				spuInfo.processAttrGroups(data)
			}
		});
	}

	$(function() {
		if (!('placeholder' in document.createElement('input'))) {
			$(spu.panelId + " #recommendWord").each(function() {
				var $tag = $(this); //当前 input  
				var $copy = $tag.clone(); //当前 input 的复制  
				if ($copy.val() == "") {
					$copy.css("color", "#999");
					$copy.val($copy.attr('placeholder'));
				}
				$copy.focus(function() {
					if (this.value == $copy.attr('placeholder')) {
						this.value = '';
						this.style.color = '#000';
					}
				});
				$copy.blur(function() {
					if (this.value == "") {
						this.value = $copy.attr('placeholder');
						$tag.val("");
						this.style.color = '#999';
					} else {
						$tag.val(this.value);
					}
				});
				$tag.hide().after($copy.show()); //当前 input 隐藏 ，具有 placeholder 功能js的input显示  
			});
		}
	});
</script>
