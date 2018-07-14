var addressArea = {};

addressArea.pageId = '#addressArea';
addressArea.dg1Id = addressArea.pageId + ' #dg1';
addressArea.configDgId = addressArea.pageId + ' #configDg';
addressArea.configDiv = addressArea.pageId + ' #configDiv';
addressArea.toolBar = addressArea.pageId + ' #tb';
addressArea.listId = addressArea.pageId + ' #listPanel';
addressArea.panelId = addressArea.pageId + ' #editPanel';
addressArea.tobeReload = "";
addressArea.returnGoodsMark = addressArea.pageId + ' #returnGoodsMark';
addressArea.priority = addressArea.pageId + ' #priority';
/**
 * 页面初始化函数
 */
addressArea.inits = function() {
    
    $(addressArea.configDgId).datagrid({
        height : $.o2m.centerHeight-20,
        striped : true,
//        fitColumns : true,
        toolbar : addressArea.toolBar,
        onBeforeLoad : function(param){
            if(param.addressAreaCode == undefined){
                return false;
            }
        },
        pagination : true,
        pageSize : 20,
        checkbox : true,
        idField : 'id',
        url : 'addressArea/getConfig',
        columns : [ [ {
            field : 'id',
            checkbox:true
        }, {
            field : 'addressAreaCode',
            title : '地址区域代码',
            width : 150
        }, {
            field : 'shopCode',
            title : '门店代码',
            width : 60
        }, {
            field : 'isGome',
            title : '是否国美',
            width : 60,
            formatter:function(value) {
                if (value=="1")
                    return '否';
                else
                    return '是';
            }
        }, {
            field : 'warehouseCode',
            title : '仓库代码',
            width : 100
        }, {
            field : 'deliverAreaCode',
            title : '配送区域代码',
            width : 100
        }, {
            field : 'deliverFee',
            title : '配送远程费',
            width : 80,
            formatter:function(value) {
               return value/100;
            }
        }, {
            field : 'roadToll',
            title : '配送路桥费',
            width : 80,
            formatter:function(value) {
                return value/100;
            }
        }, {
            field : 'installAreaCode',
            title : '安装区域代码',
            width : 100
        },{
            field : 'posNo',
            title : 'POS机编号',
            width : 80
        },{
            field : 'pickUpFlag',
            title : '是否快递上门取件',
            width : 100,
            formatter:function(value) {
                if (value=="1")
                    return '是';
                else
                    return '否';
            }
        },{
            field : 'expressFlag',
            title : '仓库3C标记',
            width : 100,
            formatter:function(value) {
                if (value=="1")
                    return '是';
                else
                    return '否';
            }
        },{
            field : 'shopSaleOrgCode',
            title : '销售组织代码',
            width : 80
        },{
            field : 'channelCode',
            title : '渠道编码',
            width : 80
        },{
            field : 'returnGoodsMark',
            title : '退货专用标记',
            width : 80
        },{
            field : 'priority',
            title : '门店优先级',
            width : 80
        }, {
            field : 'lastUpdateTime',
            title : '最后维护时间',
            width : 160,
            formatter:function(value) {
               return new Date(value).pattern('yyyy-MM-dd HH:mm:ss');
            }
        } ] ],
        loadMsg : "数据加载中..."
    });
    
	$("#addressArea .categories-datagrid").datagrid({
		height : $.o2m.centerHeight-20,
		singleSelect : true,
		onClickRow : addressArea.onClickRow,
		onBeforeLoad : function(param){
			if(param.pid == undefined){
				return false;
			}
		},
		striped : true,
		fitColumns : true,
		url : 'addressArea/children',
		columns : [ [ {
			field : 'code',
			title : '编码',
			width : 40,
			editor : 'textbox',
            formatter:function(value) {
                if(value.length>=4)
                    return value.substr(value.length-4);
             }
		}, {
			field : 'name',
			title : '名称',
			width : 60,
			editor : 'textbox'
		},{
            field : 'status',
            title : '',
            width : 20,
            formatter : function(value) {
                if(value==1){
                    return '<img src="images/icons/ok.png" />';
                }else{
                    return '<img src="images/icons/cancel.png" />';
                }
            }
        }] ],
		loadMsg : "数据加载中..."
	});

	$(addressArea.dg1Id).datagrid('load',{
		pid: ""
	});
	$("#addressArea .categories-datagrid").datagrid('enableFilter');
	$("#addressArea .datagrid-filter-row td").find('input').attr('placeholder','搜索');
	$("#addressArea .datagrid-filter-row td[field='status']").hide();
	$("#addressArea .panel-hide").hide();

};

addressArea.onClickRow = function(index, row){
	var paDiv = $(this).parents('.categories-panel');
	var next = $(paDiv).next();
	if (row.level < 4) {
		$(next).show();

		$(next).find('.categories-datagrid').datagrid('load',{
			pid : row.code
		});
		$(next).nextAll().css('display', 'none');
	} else {
	    addressArea.lastAreaCode = row.code;
        //末级
        $(addressArea.configDiv).show();
        $(addressArea.configDgId).datagrid('load',{
            addressAreaCode: addressArea.lastAreaCode
        });
	};
};
addressArea.editArea =  function(dgname) {
    //选中一行进行编辑
    var rows = $(dgname).datagrid('getSelections');
    if (!rows || rows.length == 0) {
        $.messager.alert('提示', '请选择地址区域。', 'info');
    } else if (rows.length > 1) {
        $.messager.alert('提示', '您只能选择一个地址区域!', 'info');
    } else {
        $(addressArea.listId).hide();
        $(addressArea.panelId).panel({
            title:'修改地址区域', 
            href:"addressArea/edit/"+rows[0].code
        });
        $(addressArea.panelId).panel('open');
        addressArea.tobeReload=dgname;
    }
};
addressArea.saveArea = function(){
    var areaEditForm  = $('#area_edit_form');
    areaEditForm.form({
        onSubmit: function () {
            areaEditForm.form('enableValidation');
            return areaEditForm.form('validate');
        },
        success:function(data) {
            $.o2m.handleActionResult(data);
            $(addressArea.panelId).panel('close');
            $(addressArea.listId).show();
//            $(addressArea.listId).datagrid('reload');
            $(addressArea.tobeReload).datagrid('reload');
        },
        fail:function(data) {
            $.o2m.handleActionResult(data);
            areaEditForm.form('disableValidation');
        }
    });
    areaEditForm.form('submit');
};

addressArea.deleteArea = function(dgname){
    var rows = $(dgname).datagrid('getSelections');
    if (!rows || rows.length == 0) {
        $.messager.alert('提示', '请选择地址区域。', 'info');
    }else {
        $.messager.confirm("警告","是否确认删除", function (ok) { 
            if (ok) { 
                $.post("addressArea/deleteArea", {areaCode:rows[0].code}, function(data) {
                    $.o2m.handleActionResult(data);
                    if (data.code == 0) {
//                        $(dgname).datagrid('reload');
                        addressArea.refresh();
                    }
                }, "JSON");
            } 
        });
    }
};
//导出所有地址
addressArea.exportAllArea=function(dgname){
	window.location.href="addressArea/allExportExcel";
	/*var rows = $(dgname).datagrid("getRows");
	var strb=",";
	for(var i=0;i<rows.length;i++){
		strb+=","+rows[i].code;
	}
	var strbs=strb.substring(2);
	$("#addressArea #exportForm #areaCode").val(strbs);
    var curForm = $("#addressArea #exportForm");
    curForm.form({
    	url:"addressArea/allExportExcel",
        success:function(data) {
            // 提交返回，使link-button正常
            var result = $.parseJSON(data);
            if(result!=null)
                $.o2m.handleActionResult(result);
            curForm.form('clear');
        }
    });
    curForm.form('submit');*/
}

addressArea.exportArea = function(dgname){
    var rows = $(dgname).datagrid('getSelections');
    if (!rows || rows.length == 0) {
        $.messager.alert('提示', '请选择地址区域。', 'info');
    }else {
        $("#addressArea #exportForm #areaCode").val(rows[0].code);
        var curForm = $("#addressArea #exportForm");
        curForm.form({
            success:function(data) {
                // 提交返回，使link-button正常
                var result = $.parseJSON(data);
                if(result!=null)
                    $.o2m.handleActionResult(result);
                curForm.form('clear');
            }
        });
        curForm.form('submit');
//                $.post("addressArea/exportExcel", {areaCode:rows[0].code}, function(data) {
//                    var result = $.parseJSON(data);
//                    if(result!=null)
//                        $.o2m.handleActionResult(result);
//                }, "JSON");
//        window.location.href="addressArea/exportExcel?areaCode="+rows[0].code;
    }
};
addressArea.editConfig =  function() {
    //选中一行进行编辑
    var rows = $(addressArea.configDgId).datagrid('getSelections');
    if (!rows || rows.length == 0) {
        $.messager.alert('提示', '请选择配置信息。', 'info');
    } else if (rows.length > 1) {
        $.messager.alert('提示', '您只能选择一条配置信息!', 'info');
    } else {
        $(addressArea.listId).hide();
        $(addressArea.panelId).panel({
            title:'配置信息修改', 
            href:"addressArea/editConfig?areaCode="+rows[0].addressAreaCode+"&shopCode="+rows[0].shopCode+"&warehouseCode="+rows[0].warehouseCode
        });
        $(addressArea.panelId).panel('open');
    }
};

addressArea.saveConfig = function(){
    var configEditForm  = $('#config_edit_form');
    configEditForm.form({
        onSubmit: function () {
        	var returnGoodsMark= $(addressArea.returnGoodsMark).val();
        	var priority= $(addressArea.priority).val();
        	var reg = /^\d{1,4}$/;
        	if (isNaN(returnGoodsMark)){
        		$.messager.alert('提示','请输入数字0或1','info');
        		return false;
        	}else{
        		if(returnGoodsMark>1||returnGoodsMark<0){
        			$.messager.alert('提示','请输入数字0或1','info');
            		return false;
        		}
        	}
        	if(!reg.test(priority)){
        		$.messager.alert('提示','门店优先级请输入整数且最多四位','info');
        		return false;
        	}
            configEditForm.form('enableValidation');
            return configEditForm.form('validate');
            
        },
        success:function(data) {
            $.o2m.handleActionResult(data);
            $(addressArea.panelId).panel('close');
            $(addressArea.listId).show();
            $(addressArea.configDgId).datagrid('reload');
        },
        fail:function(data) {
            $.o2m.handleActionResult(data);
            configEditForm.form('disableValidation');
        }
    });
    configEditForm.form('submit');
};

addressArea.deleteConfig = function(){
    var rows = $(addressArea.configDgId).datagrid('getSelections');
    if (!rows || rows.length == 0) {
        $.messager.alert('提示', '请选择地址区域。', 'info');
    }else {
        $.messager.confirm("警告","是否确认删除", function (ok) { 
            if (ok) { 
                var params = [];
                for(var i=0;i<rows.length;i++){
                    params.push(rows[i].addressAreaCode+";"+rows[i].shopCode+";"+rows[i].warehouseCode);
                }
                $.post("addressArea/deleteConfig", {'params':params}, function(data) {
                    $.o2m.handleActionResult(data);
                    if (data.code == 0) {
                        $(addressArea.configDgId).datagrid('reload');
                    }
                }, "JSON");
            } 
        });
    }
};
//下载模板
$(addressArea.pageId + " #download_btn").on("click", function() {
    window.location.href="common/import/downLoadTemplate?templateName="+encodeURI("地址区域配置");
});

$(addressArea.pageId + ' #import_btn').on('click', function(event) {
    $(addressArea.listId).hide();
    $(addressArea.panelId).panel({
        title:'导入', 
        href:"addressArea/import"
    });
    $(addressArea.panelId).panel('open');
});
$(addressArea.pageId + ' #portion_import_btn').on('click', function(event) {
    $(addressArea.listId).hide();
    $(addressArea.panelId).panel({
        title:'选择导入', 
        href:"addressArea/portionImport"
    });
    $(addressArea.panelId).panel('open');
});

$(addressArea.pageId + ' #special_import_btn').on('click', function(event) {
    $(addressArea.listId).hide();
    $(addressArea.panelId).panel({
        title:'门店/仓库修改导入', 
        href:"addressArea/specialImport"
    });
    $(addressArea.panelId).panel('open');
});

addressArea.returnToListPage = function() {
    $(addressArea.panelId).panel('close');
    $(addressArea.listId).show();
};

addressArea.refresh = function(){
    var currentTab =$('#tabs').tabs('getSelected');
    var panel = currentTab.find('.easyui-panel');
    var herf = panel.attr('href');
    $('#tabs').tabs('update', {
        tab: currentTab,
        options: {
            content: "<div class='easyui-panel' href='"+herf+"' border='false'  " +
            " style=' overflow: hidden;'></div>"
        }
    });
};

$.extend($.fn.validatebox.defaults.rules, {
    transIntervalTwo: {
        validator:function(value,param){     
            if (value) {
                return (/^\d+(\.\d{1,2})*$/.test(value));   
            } else {     
                return true;     
            }     
        },     
        message:'保留两位小数.'           
    },
    // 输入框禁止输入特殊字符
    disableSpecialChar: {
        validator: function (value, param) { 
            var reg = /[<>%\{\}'"]/;
            if (value) {
                if (reg.test(value)) {
                    return false;  
                } else {
                    return true;
                }
            } else {     
                return true;     
            }     
        },    
        message:'不允许输入< > % { } \' " 这些特殊字符.'           
    }
});

addressArea.inits();
