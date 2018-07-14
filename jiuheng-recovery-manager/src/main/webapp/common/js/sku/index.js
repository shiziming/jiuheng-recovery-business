var sku = {};

sku.pageId = '#skuPage';
sku.dgId = sku.pageId + ' #dg';
sku.toolBar = sku.pageId + ' #tb';
sku.listId = sku.pageId + ' #listPanel';
sku.panelId = sku.pageId + ' #editPanel';
sku.VIEW = sku.listId + ' #VIEW';
sku.MAINTAIN = sku.listId + ' #MAINTAIN';
sku.CHECK = sku.listId + ' #CHECK';

/**
 * 页面初始化函数
 */
sku.inits = function() {
	var VIEW=$(sku.VIEW).val();
	var MAINTAIN=$(sku.MAINTAIN).val();
	var CHECK=$(sku.CHECK).val();
	$(sku.dgId).datagrid({
		height : $.o2m.centerHeight-20,
		striped : true,
		fitColumns : true,
		toolbar : sku.toolBar,
		onBeforeLoad : function(param){
			if(param.hasQuery == undefined){
				return false;
			}
		},
		singleSelect : true,
		rownumbers : true,
		pagination : true,
		pageSize : 20,
		url : 'sku/skulist',
		columns : [ [  {
			field : 'id',
			title : 'SKU码',
			width : 30,
			align : 'center'
		}, {
			field : 'name',
			title : 'SKU名称',
			width : 80,
			align : 'center'
		}, 
		{
			field : 'publishStatus',
			title : '是否发布',
			width : 40,
			align : 'center',
			formatter : function(value,row) {
				if(value == '2'){
					return "<span>是</span>";
				}else{
					return "<span style='color:red'>否</span>";
				}
			}
		},
		{
			field : 'CT',
			title : '草图',
			width : 50,
			align:'center',
			formatter : function(value, row) {
				if (CHECK) {
					return '<a href="#" onclick="skuInfo.viewDirectionCT(\'' + row.id + '\');">说明书</a>'+
					'&nbsp;&nbsp;<a href="#" onclick="skuInfo.viewWarrantyCT(\'' + row.id + '\');">保修卡</a>'+
					'&nbsp;&nbsp;<a href="#" onclick="skuInfo.checkPicInfo(\'' + row.id + '\');">审核</a>';
				}
				if (VIEW || MAINTAIN) {
					return '<a href="#" onclick="skuInfo.viewDirectionCT(\'' + row.id + '\');">说明书</a>'+
					'&nbsp;&nbsp;<a href="#" onclick="skuInfo.viewWarrantyCT(\'' + row.id + '\');">保修卡</a>';
				}
			}
		},
		{
			field : 'JG',
			title : '加工图',
			width : 50,
			align:'center',
			formatter : function(value, row) {
				if (VIEW || MAINTAIN) {
					return '<a href="#" onclick="skuInfo.viewDirectionJG(\'' + row.id + '\');">说明书</a>'+
					'&nbsp;&nbsp;<a href="#" onclick="skuInfo.viewWarrantyJG(\'' + row.id + '\');">保修卡</a>';
				}
			}
		}
		] ],
		loadMsg : "数据加载中..."
	});
	
	$(sku.dgId).datagrid('doCellTip',{delay:500});   
};

//查询按钮
$(sku.pageId + ' #btnSearch').on('click', function(event) {
	var searchObj = $.o2m.serializeObject($(sku.pageId + " #searchForm"));
	searchObj.hasQuery = 1;
	$(sku.dgId).datagrid("load", searchObj);
});
//上传说明书草图
$(sku.pageId + ' #btnCTPicAddDirection').on('click', function(event) {
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'上传说明书草图', href:"sku/addPic"});
	$(sku.panelId).panel('open');
});
//上传保修卡草图
$(sku.pageId + ' #btnCTPicAddWarranty').on('click', function(event) {
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'上传保修卡草图', href:"sku/addPic"});
	$(sku.panelId).panel('open');
});
//上传说明书加工图
$(sku.pageId + ' #btnJGPicAddDirection').on("click", function() {
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'上传说明书加工图', href:"sku/addView"});
	$(sku.panelId).panel('open');
});
//上传保修卡加工图
$(sku.pageId + ' #btnJGPicAddWarranty').on("click", function() {
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'上传保修卡加工图', href:"sku/addView"});
	$(sku.panelId).panel('open');
});
//查看CDN图片
$(sku.pageId + ' #btnSearchPic').on("click", function() {
	var rows = $(sku.dgId).datagrid('getChecked');
	if (!rows || rows.length == 0) {
		$.messager.alert('提示', '请选择SKU记录。', 'info');
	} else if (rows.length > 1) {
		$.messager.alert('提示', '您只能选择一个SKU!', 'info');
	} else {
		$(sku.listId).hide();
		$(sku.panelId).panel({title:'CDN图片', href:"sku/cdnPicInfo/"+rows[0].id});
		$(sku.panelId).panel('open');
	}
});

var skuInfo = {};
//从Panel页面返回到列表页面
skuInfo.returnToListPage = function() {
	$(sku.panelId).panel('close');
	$(sku.listId).show();
};
//进入说明书草图详情页面
skuInfo.viewDirectionCT = function(id){
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'查看说明书草图', href:"sku/directionCTPicInfo/"+id});
	$(sku.panelId).panel('open');
};
//进入保修卡草图详情页面
skuInfo.viewWarrantyCT = function(id){
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'查看保修卡草图', href:"sku/warrantyCTPicInfo/"+id});
	$(sku.panelId).panel('open');
};
//进入说明书加工图详情页面
skuInfo.viewDirectionJG = function(id){
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'查看说明书加工图', href:"sku/directionJGPicInfo/"+id});
	$(sku.panelId).panel('open');
};
//进入保修卡加工图详情页面
skuInfo.viewWarrantyJG = function(id){
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'查看保修卡加工图', href:"sku/warrantyJGPicInfo/"+id});
	$(sku.panelId).panel('open');
};
//进入审核图片页面
skuInfo.checkPicInfo = function(id){
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'审核图片', href:"sku/checkPicInfo/"+id});
	$(sku.panelId).panel('open');
};
//修改草图主图页面
skuInfo.editCTMainPic = function() {
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'修改草图主图', href:"sku/editCTMainPic"});
	$(sku.panelId).panel('open');
};
//修改加工图主图页面
skuInfo.editJGMainPic = function() {
	$(sku.listId).hide();
	$(sku.panelId).panel({title:'修改加工图主图', href:"sku/editJGMainPic"});
	$(sku.panelId).panel('open');
};

sku.inits();
