var spu = {};

spu.pageId = '#spuPage';
spu.dg1Id = spu.pageId + ' #dg1';
spu.spuDgId = spu.pageId + ' #spuDg';
spu.spuDiv = spu.pageId + ' #spuDiv';
spu.toolBar = spu.pageId + ' #tb';
spu.listId = spu.pageId + ' #listPanel';
spu.panelId = spu.pageId + ' #editPanel';

/**
 * 页面初始化函数
 */
spu.inits = function() {
	$(spu.spuDgId).datagrid({
		height : $.o2m.centerHeight - 20,
		striped : true,
		fitColumns : true,
		toolbar : spu.toolBar,
		onBeforeLoad : function(param) {
			if (param.categoryCode == undefined) {
				return false;
			}
		},
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		checkbox : true,
		idField : 'id',
		url : 'spu/list',
		columns : [ [ {
			field : 'id',
			checkbox : true
		}, {
			field : 'code',
			title : '编码',
			width : 60,
			formatter : function(value, row) {
				return "<a href='#' onClick='spu.showSpuInfo(\"" + row.id + "\")'>" + value + "</a>";
			}
		}, {
			field : 'name',
			title : '名称',
			width : 200
		}, {
			field : 'status',
			title : '是否发布',
			width : 40,
			formatter : function(value, row) {
				if (value == '1') {
					return "<span style='color:red'>是</span>";
				} else {
					return "<span>否</span>";
				}
			}
		} ] ],
		loadMsg : "数据加载中..."
	});
	$("#spuPage .categories-datagrid").datagrid({
		height : $.o2m.centerHeight - 20,
		singleSelect : true,
		onClickRow : spu.onClickRow,
		onBeforeLoad : function(param) {
			if (param.pid == undefined) {
				return false;
			}
		},
		striped : true,
		fitColumns : true,
		url : 'backCategories/children',
		columns : [ [ {
			field : 'code',
			title : '编码',
			width : 70,
			editor : 'textbox'
		}, {
			field : 'name',
			title : '名称',
			width : 70,
			editor : 'textbox'
		}, {
			field : 'hide',
			title : '',
			width : 20,
			formatter : function(value, row, index) {
				if (row.hasChildren) {
					return "<span style='color:blue;'> > </span>";
				}
			}
		} ] ],
		loadMsg : "数据加载中..."
	});

	$(spu.dg1Id).datagrid('load', {
		pid : ""
	});
	$("#spuPage .categories-datagrid").datagrid('enableFilter');
	$("#spuPage .datagrid-filter-row td").find('input').attr('placeholder', '搜索');
	$("#spuPage .datagrid-filter-row td[field='hide']").hide();
	$("#spuPage .panel-hide").hide();

};

// 查询按钮
$(spu.pageId + ' #btnSearch').on('click', function(event) {
	$(spu.spuDgId).datagrid("clearChecked");
	var searchObj = $.o2m.serializeObject($(spu.pageId + " #searchForm"));
	searchObj.categoryCode = spu.lastCategoryId;
	$(spu.spuDgId).datagrid("load", searchObj);
});
// 新增
$(spu.pageId + ' #btnAdd').on('click', function(event) {
	$(spu.listId).hide();
	$(spu.panelId).panel({
		title : '新增spu',
		href : "spu/add?categoryCode=" + spu.lastCategoryId
	});
	$(spu.panelId).panel('open');
});
// 修改
$(spu.pageId + ' #btnEdit').on('click', function(event) {
	var rows = $(spu.spuDgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spu.listId).hide();
		$(spu.panelId).panel({
			title : '修改spu',
			href : "spu/edit/" + rows[0].id
		});
		$(spu.panelId).panel('open');
	}
});
// 删除
$(spu.pageId + ' #btnDel').on('click', function(event) {
	var rows = $(spu.spuDgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$.messager.confirm("操作提示", "您确定要删除吗？", function(data) {
			if (data) {
				$.ajax({
					url : "spu/delSpu/" + rows[0].id,
					async : false,
					success : function(result) {
						if ($.o2m.handleActionResult(result)) {
							$(spu.spuDgId).datagrid('reload');
						}
					}
				});
			}
		});
	}
});
// 上传素材
$(spu.pageId + ' #btnPicAdd').on('click', function(event) {
	$(spu.listId).hide();
	$(spu.panelId).panel({
		title : '上传spu图片',
		href : "spu/addPic"
	});
	$(spu.panelId).panel('open');
});
// 素材详情
$(spu.pageId + ' #btnSearchPic').on('click', function(event) {
	var rows = $(spu.spuDgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spu.listId).hide();
		$(spu.panelId).panel({
			title : '素材详情',
			href : "spu/picInfo/" + rows[0].id
		});
		$(spu.panelId).panel('open');
	}

});
// 绑定SKU
$(spu.pageId + ' #btnBindSku').on('click', function(event) {
	var rows = $(spu.spuDgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spu.listId).hide();
		$(spu.panelId).panel({
			title : '绑定SKU',
			href : "spu/bindSku/" + rows[0].id + "?" + "categoryCode=" + spu.lastCategoryId
		});
		$(spu.panelId).panel('open');
	}

});
// 发布SPU
$(spu.pageId + ' #btnPublishSpu').on('click', function(event) {
	var rows = $(spu.spuDgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SPU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SPU!', 'info');
	} else {
		$(spu.listId).hide();
		$(spu.panelId).panel({
			title : '发布SPU',
			href : "spu/publishSpu/" + rows[0].id + "?" + "categoryCode=" + spu.lastCategoryId
		});
		$(spu.panelId).panel('open');
	}

});

var initSpuDg = false;

spu.onClickRow = function(index, row) {
	var paDiv = $(this).parents('.categories-panel');
	var next = $(paDiv).next();
	if (row.level < 3) {
		$(next).show();

		$(next).find('.categories-datagrid').datagrid('load', {
			pid : row.code
		});
		$(next).nextAll().css('display', 'none');
	} else {
		spu.lastCategoryId = row.code;
		// 末级
		$(spu.spuDiv).show();
		$(spu.spuDgId).datagrid('load', {
			categoryCode : spu.lastCategoryId
		});

	}
	;
};
spu.editSpu = function(obj) {
	alert(obj);
};
// 查看
spu.showSpuInfo = function(spuId) {
	$(spu.listId).hide();
	$(spu.panelId).panel({
		title : '查看spu',
		href : "spu/info/" + spuId
	});
	$(spu.panelId).panel('open');
}

var spuInfo = {};
spuInfo.skuTable = spu.panelId + " #skuTable";
spuInfo.attrs = spu.panelId + " #attrs";
// 处理SPU的sku属性
spuInfo.processSkuAttrs = function(data) {
	for (var i = 0; i < data.length; i++) {
		var tr = $('<tr>').attr('attr-id', data[i].id).attr('isSku', true);
		var input = $('<input>');
		if (data[i].dataType == 1) {
			// input.addClass('easyui-numberbox');
		}
		var p = $('<p>').append(input).append(
				"<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-add'\" onClick=\"spuInfo.addSku(this)\">添加</a>");
		var div = $('<div>').append(p);
		tr.append("<td>" + data[i].name + "</td>").append($('<td>').append(div)).appendTo($(spuInfo.skuTable));

	}
	$.parser.parse($(spuInfo.skuTable));
}
// 处理修改页面sku属性
spuInfo.processEditSkuAttrs = function(data) {
	for (var i = 0; i < data.length; i++) {
		var tr = $('<tr>').attr('attr-id', data[i].id).attr('isSku', true);

		var spuId = $(spu.panelId + " #spuId").val();
		var div = $('<div>');

		var content = "<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-remove'\" onClick=\"spuEdit.delSkuAttr(this)\">删除</a>";
		$.ajax({
			url : "spu/skuAttrValueIds/" + spuId + "/" + data[i].id,
			async : false,
			success : function(result) {
				for (var j = 0; j < result.length; j++) {
					var p = $('<p>');
					p.append($('<input>').val(result[j]));
					p.append(content);
					div.append(p);
				}
			}
		});
		div.append($('<p>').append($('<input>')).append(
				"<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-add'\" onClick=\"spuEdit.addSkuAttr(this)\">添加</a>"));
		tr.append("<td>" + data[i].name + "</td>").append($('<td>').append(div)).appendTo($(spuInfo.skuTable));
		$.parser.parse($(spuInfo.skuTable));
	}
	$.parser.parse($(spuInfo.skuTable));
}
// 处理属性组
spuInfo.processAttrGroups = function(data) {
	for (var i = 0; i < data.length; i++) {
		var fieldset = $('<fieldset>').append("<legend>" + data[i].name + "</legend>").attr('group-id', data[i].id);
		var table = $('<table>');
		$.ajax({
			url : "spu/attrValues/" + spu.lastCategoryId + "/" + data[i].id,
			async : false,
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					var tr = $('<tr>').append("<td>" + data[i].name + "</td>").attr("attr-id", data[i].id);
					var td = $('<td>');
					var chooseType = data[i].chooseType;
					tr.attr('choose-type', chooseType);
					var values = data[i].values;
					if (chooseType == 0) {
						var input = $('<input>');
						if (data[i].dataType == 2) {
							input.addClass('easyui-numberbox');
						} else {
							input.addClass('easyui-textbox');
						}
						if (data[i].required == 1) {
							input.attr('data-options', "required:true");
						}
						td.append(input);
					} else {
						var select=$('<select>');
						select.attr('class', 'input-content easyui-combobox');
						select.attr('editable', 'false');
						for (var j = 0; j < values.length; j++) {
							select.append("<option value='" + values[j].id + "'>" + values[j].goodsattrvalue + "</option>");
						}
						if (chooseType == 2) {
							select.attr('data-options', 'multiple:true');
						}
						td.append(select);
					}
					table.append(tr.append(td));
				}
			}
		});
		$(spuInfo.attrs).append(fieldset.append(table));
		$.parser.parse($(spuInfo.attrs));
	}
}
// 处理属性组属性值信息
spuInfo.processGroupAttrValues = function(data, spuId) {
	for (var i = 0; i < data.length; i++) {
		var fieldset = $('<fieldset>').append("<legend>" + data[i].name + "</legend>").attr('group-id', data[i].id);
		var table = $('<table>');
		$.ajax({
			url : "spu/groupAttrValues/" + spu.lastCategoryId + "/" + data[i].id + "/" + spuId,
			async : false,
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					var p = $("<p>").append($("<span>").append(data[i].name + " : "));
					if (data[i].values instanceof Array) {
						var arr = [];
						for (var j = 0; j < data[i].values.length; j++) {
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
		$(spuInfo.attrs).append(fieldset);
	}
}
// 处理修改页面属性组
spuInfo.processEditAttrGroups = function(data) {
	var spuId = $(spu.panelId + " #spuId").val();
	var multiCombos = [];
	for (var i = 0; i < data.length; i++) {
		var fieldset = $('<fieldset>').append("<legend>" + data[i].name + "</legend>").attr('group-id', data[i].id);
		var table = $('<table>');

		$.ajax({
			url : "spu/attrValues/" + spu.lastCategoryId + "/" + data[i].id,
			async : false,
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					var tr = $('<tr>').append("<td>" + data[i].name + "</td>").attr("attr-id", data[i].id);
					var td = $('<td>');
					var chooseType = data[i].chooseType;
					tr.attr('choose-type', chooseType);
					var values = data[i].values;
					var spuAttrValue = [];
					$.ajax({
						url : "spu/spuAttrValues/" + spuId + "/" + data[i].id,
						async : false,
						success : function(spuValuesData) {
							spuAttrValue = spuValuesData;
						}
					});

					if (chooseType == 0) {
						var input = $('<input>');
						if (data[i].dataType == 2) {
							input.addClass('easyui-numberbox');
						} else {
							input.addClass('easyui-textbox');
						}
						if (data[i].required == 1) {
							input.attr('data-options', "required:true");
						}
						if (spuAttrValue && spuAttrValue.length > 0) {
							input.val(spuAttrValue[0].attrValue);
						}
						td.append(input);
					} else {
						var select=$('<select>');
						select.attr('class', 'input-content easyui-combobox');
						select.attr('editable', 'false');
						for (var j = 0; j < values.length; j++) {
							select.append("<option value='" + values[j].id + "'>" + values[j].goodsattrvalue + "</option>");
						}
						if (chooseType == 2) {
							select.attr('id', 'attr' + data[i].id);
							select.attr('data-options', 'multiple:true');
							if (spuAttrValue && spuAttrValue.length > 0) {
								var multiCombo = new Object();
								var arr = [];
								multiCombo.id = 'attr' + data[i].id;
								for (var j = 0; j < spuAttrValue.length; j++) {
									arr.push(spuAttrValue[j].attrValueId);
								}
								multiCombo.values = arr;
								multiCombos.push(multiCombo);
							} else {
								select.val('');
							}

						} else {
							if (spuAttrValue && spuAttrValue.length > 0) {
								select.val(spuAttrValue[0].attrValueId);
							} else {
								select.val('');
							}
						}
						td.append(select);
					}
					table.append(tr.append(td));
				}
			}
		});
		$(spuInfo.attrs).append(fieldset.append(table));
	}

	$.parser.parse($(spuInfo.attrs));
	spuInfo.multiCombos = multiCombos;
}

$(spu.panelId).panel({
	onLoad : function() {
		if (spuInfo.multiCombos != undefined) {
			for (var i = 0; i < spuInfo.multiCombos.length; i++) {
				var multiCombo = spuInfo.multiCombos[i];
				$(spu.panelId + ' #' + multiCombo.id).combobox('setValues', multiCombo.values);
			}
		}
	}
});

// 增加sku属性事件
spuInfo.addSku = function(obj) {
	var val = $.trim($(obj).prev().val());
	if (val != '') {
		var content = "<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-remove'\" onClick=\"spuInfo.delSku(this)\">删除</a>";
		var clone = $(obj).parents('p').clone();
		$(clone).find('input').val('');
		$(obj).parents('p').after(clone);
		$(clone).find('input').focus();
		$(obj).parents('p').append(content);
		$.parser.parse($(obj).parents('p'));
		$(obj).remove();
	}
	return false;
};
spuInfo.delSku = function(obj) {
	$(obj).parents('p').remove();
	return false;
};

spuInfo.processSkuAttrValues = function(data) {
	for (var i = 0; i < data.length; i++) {
		var p = $("<p>").append($("<span>").append(data[i].attrName + " : "));
		if (data[i].values instanceof Array) {
			var span = $("<span>").append(data[i].values.join("、"));
			span.addClass('attr-value');
			p.append(span);
		}
		$(spu.panelId + ' #skuAttrDiv').append(p);
	}
}
spuInfo.processSpuAttrValues = function(data) {
	for (var i = 0; i < data.length; i++) {
		var p = $("<p>").append($("<span>").append(data[i].attrName + " : "));
		if (data[i].values instanceof Array) {
			var span = $("<span>").append(data[i].values.join("、"));
			span.addClass('attr-value');
			p.append(span);
		}
		$(spu.panelId + ' #spuAttrDiv').append(p);
	}
}

/**
 * 从Panel页面返回到列表页面
 */
spuInfo.returnToListPage = function() {
	$(spu.panelId).panel('close');
	$(spu.listId).show();
}
spuInfo.createSpu = function() {
	if (!$(spu.panelId).find('form').form('enableValidation').form('validate')) {
		return false;
	}
	var obj = new Object();
	var spSpu = new Object();
	spSpu.name = $(spu.panelId + " #spuName").val();
	spSpu.recommendWord = $.trim($(spu.panelId + " #recommendWord").val());

	spSpu.packingList = $.trim($(spu.panelId + " #packingList").val());
	if (spSpu.recommendWord == "" || spSpu.recommendWord == undefined) {
		$.messager.alert('操作失败', "请填写推荐语", 'warning');
		return false;
	} else if (spSpu.packingList == '' || spSpu.packingList == undefined) {
		$.messager.alert('操作失败', "请添加包装清单", 'warning');
		return false;
	}
	spSpu.id = $(spu.panelId + " #spuId").val();
	spSpu.categoryCode = spu.lastCategoryId;

	var attrs = [];
	$(spu.panelId + " #attrs").find('tr').each(function() {
		var attr = new Object();
		attr.id = $(this).attr('attr-id');
		var attrValues = [];
		if ($(this).attr('isSku')) {
			// 新增直接保存销售属性 修改不保存销售属性
			if (spSpu.id == undefined) {
				attr.isSku = true;
				$(this).find('input').each(function() {
					if ($.trim($(this).val()) != '') {
						var value = new Object();
						value.goodsattrvalue = $.trim($(this).val());
						attrValues.push(value);
					}
				});
			}
		} else {
			if ($(this).attr('choose-type') == 0) {
				if ($(this).find('input').val() != '') {
					var value = new Object();
					value.goodsattrvalue = $(this).find('input').val();
					attrValues.push(value);
				}
			} else {
				if ($(this).find('select').combobox('getValues') != '') {
					var comboValues = $(this).find('select').combobox('getValues');
					var comboTexts = $(this).find('select').combobox('getText').split(",");
					for (var i = 0; i < comboValues.length; i++) {
						var value = new Object();
						value.goodsattrvalue = comboTexts[i];
						value.goodsattrid = comboValues[i];
						attrValues.push(value);
					}
				}
			}
		}
		if (attrValues.length > 0) {
			attr.values = attrValues;
			attrs.push(attr);
		}
	});
	obj.spu = spSpu;
	obj.attrs = attrs;
	$.ajax({
		type : "POST",
		url : "spu/createOrUpdate",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(obj),
		success : function(data) {
			spuInfo.multiCombos = [];
			if ($.o2m.handleActionResult(data)) {
				$(spu.panelId).panel('close');
				$(spu.listId).show();
				$(spu.spuDgId).datagrid('reload');
			}
		}
	});
	return false;
}

spu.inits();
