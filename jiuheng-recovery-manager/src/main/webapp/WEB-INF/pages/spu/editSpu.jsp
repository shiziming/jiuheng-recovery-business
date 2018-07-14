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
					<td id="tdd">SPU名称:<input value="${spu.id}" id="spuId"
						style="display: none" /></td>
					<td><input value="${spu.name}" class="easyui-searchbox"
						name="spuName" id="spuName"
						data-options="required:true, novalidate:true"
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
						name="recommendWord" id="recommendWord" cols="400px">${spu.recommendWord}</textarea>
				</fieldset>
				<fieldset>
					<legend>包装清单</legend>
					<textarea style="width: 500px; height: 50px; resize: none"
						name="packingList" id="packingList">${spu.packingList}</textarea>
				</fieldset>
				<span style="color: red;">注:修改销售属性值请直接点击添加删除 </span>
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
					onclick="spuInfo.createSpu();"> <span style="font-size: 14px;">修改</span>
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
	var spuEdit = {};
	$('#spuPage #spuName').searchbox({
		searcher : function(value, name) {
			$.o2m.openMagnifierWindow('查询商品', 'icon-search', 500, 500, 'sku/queryFdj?type=1');
		},
		prompt : 'spu名称'
	});

	if (spu.lastCategoryId != "") {
		$.getJSON("spu/skuAttrs/" + spu.lastCategoryId, function(data) {
			spuInfo.processEditSkuAttrs(data);
		});
		$.ajax({
			url : "spu/attrGroups/" + spu.lastCategoryId,
			async : false,
			success : function(data) {
				spuInfo.processEditAttrGroups(data)
			}
		});
	}
	var spuId = "${spu.id}";
	spuEdit.addSkuAttr = function(obj) {
		if ($.trim($(obj).parent().find('input').val()) == '') {
			return;
		}
		var flag = true;
		$.each($(obj).parent('p').prevAll(), function(i, n) {
			if ($(obj).parent().find('input').val() == $(this).find('input').val()) {
				alert('与之前值有相同');
				flag = false;
				return;
			}
		});
		if (!flag) {
			return;
		}
		var sku = {};
		sku.attrId = $(obj).parents('tr').attr('attr-id');
		sku.attrValue = $.trim($(obj).parent().find('input').val());
		sku.spuId = spuId;
		$.ajax({
			url : "spu/addSkuAttr",
			async : false,
			data : sku,
			type : "POST",
			success : function(result) {
				if ($.o2m.handleActionResult(result)) {
					spuInfo.addSku(obj);
				}
			}
		});
	}
	spuEdit.delSkuAttr = function(obj) {
		var sku = {};
		sku.attrId = $(obj).parents('tr').attr('attr-id');
		sku.attrValue = $(obj).parent().find('input').val();
		sku.spuId = spuId;
		$.ajax({
			url : "spu/delSkuAttr",
			async : false,
			data : sku,
			type : "POST",
			success : function(result) {
				if ($.o2m.handleActionResult(result)) {
					spuInfo.delSku(obj);
				}
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
