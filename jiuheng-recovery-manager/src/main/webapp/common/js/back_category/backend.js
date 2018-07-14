var backCategories = {};
backCategories.pageId = '#backCategoryPage';
backCategories.dlg = '#back_category_pic';
backCategories.categridEditDg = backCategories.pageId + ' #categridEditDg';
backCategories.categridEditTg = backCategories.pageId + ' #categridEditTg';
backCategories.attrGroup = backCategories.pageId + ' #attrGroup';
backCategories.group_index = backCategories.pageId + ' #backcate_group_index';

/**
 * 页面初始化函数
 */
backCategories.inits = function() {
	$(backCategories.categridEditDg).datagrid({
		height : $.o2m.centerHeight/2-10,
		striped : true,
		rownumbers : true,
		fitColumns : true,
		toolbar : '#backCategoryPage #categridEditTb1',
		checkbox : true,
		idField : 'box',
		onEndEdit : function(index,row,changes){
			var ed = $(this).datagrid('getEditor', {index:index,field:'id'});
			if($(ed.target).combobox('getValue') == $(ed.target).combobox('getText')){
				row.id = "";
			}
		},
		columns : [ [ {
			field : 'box',
			checkbox : true
		}, {
			field : 'id',
			title : '属性信息',
			align:'center',
			editor:{
				type:'combobox',
				options:{
					loader:backCategories.attrLoader,
					mode: 'remote',
					required:true,
					valueField: 'value',
					textField: 'text',
					onSelect:function(rec){},
					onChange:function(newValue,oldValue){}
				}
			},
			width : 150
		},{
			field : 'required',
			title : '必填',
			width : 60,
			align :'center',
			editor:{type:'checkbox',options:{on:'1',off:'0'}}
		} ,{
			field : 'skuBj',
			title : '设为销售属性',
			width : 100,
			align :'center',
			editor:{type:'checkbox',options:{on:'1',off:'0'}}
		} /*,{
			field : 'mained',
			title : '是否为主要属性',
			width : 100,
			align :'center',
			editor:{type:'checkbox',options:{on:'1',off:'0'}}
		}*/,{
			field : 'index',
			title : '显示序号',
			align :'center',
			width : 50,
			editor:{type:'numberbox'}
		}] ]
	});
	$(backCategories.categridEditTg).treegrid({  
	    title:'类目已关联的属性',
	    height : $.o2m.centerHeight/4 * 3,
	    toolbar:'#backCategoryPage #categridEditTb2',
	    fitColumns : true,
	    url:'backCategories/getCategoryAttributes',
	    onBeforeLoad : function(row,param){
			if(param.categoryCode == undefined){
				return false;
			}
		},
		onEndEdit : function(row,changes){
			if(changes.index || changes.skuBj){
				var data = {};
				if(row.type==1){
					changes.id = row.id;
				}else{
					row.skuBj = '';
					if(changes.index == undefined){
						return;
					}
					changes.id = row.groupId;
				}
				changes.skuBj = row.skuBj;
				changes.type = row.type;
				changes.categoryCode = $(backCategories.pageId +" #lastCategoryCode").val();
		    	$.ajax({
		            type:"post",  
		            url:"backCategories/updateGroupAttributes",  
		            async : false,
		            data: changes,
		            success : function(result){
		            	$(backCategories.categridEditTg).treegrid('load',{categoryCode:$(backCategories.pageId +" #lastCategoryCode").val()});
		            	$.o2m.handleActionResult(result);
		            }
		    	});
			}
		},
	    idField:'flag',
	    treeField:'name',
	    columns:[[{
	    	title:'id',
	    	field:'checkid',
	    	width:50,
	    	formatter:function(value, row, index) {
				if(row.id == undefined){
					return  row.groupId;
				}else{
					return row.id;
				}
			}
		},{
			title:'名称',
			field:'name',
			width:100
		}, {
			title:'销售属性',
			field:'skuBj',
			align:'center',
			width:50,
			formatter:function(value, row, index) {
				if(value == '1'){
					return '<span style="color: red">是</span>';
				}else if(value == '0'){
					return '<span>否</span>';
				}
			},
			editor:{type:'checkbox',options:{on:'1',off:'0'}}
		},{
			title:'是否必填',
			field:'required',
			align:'center',
			width:50,
			formatter:function(value, row, index) {
	    		var flag;
				if(value == '1'){
					return '<span style="color: red">是</span>';
				}else if(value == '0'){
					return '<span>否</span>';
				}
			}
		},{
			field : 'index',
			title : '显示序号',
			align :'center',
			width : 100,
			editor:{type:'numberbox'}
		}, {
			field : 'action',
			title : '操作',
			align:'center',
			width : 50,
			formatter : function(value, row, index) {
				return  '<a href="#" onclick="backCategories.delTreeRow('+row.groupId+','+row.id+');">删除</a>';
			}
		} ]]
	});
	
	
	$("#backCategoryPage .categories-datagrid").datagrid({
		height : $.o2m.centerHeight-20,
		singleSelect : true,
		onClickCell : backCategories.onClickCell,
		onBeforeLoad : function(param){
			if(param.pid == undefined){
				return false;
			}
		},
		striped : true,
		fitColumns : true,
		url : 'backCategories/children',
		columns : [ [  {
			field : 'url1',
			width : 40,
			formatter : function(value,row,index){
				if(value == ''){
					return "<img width='20px' height='20px' src='common/imgs/default.png'/>"
				}
				 return "<img width='20px'  height='20px' src='"+$.o2m.addTimeStampToImageUrl(picUrl+value) +"'/>";
			}
		}, {
			field : 'code',
			title : '编码',
			width : 70,
			editor : 'textbox'
		}, {
			field : 'name',
			title : '名称',
			width : 70,
			editor : 'textbox'
		},{
			field : 'hide',
			title : '',
			width : 20,
			formatter : function(value, row, index) {
				if(row.hasChildren){
					return "<span style='color:blue;'> > </span>";
				}
			}
		} ] ],
		loadMsg : "数据加载中...",
		onLoadSuccess : function() {
			$(this).datagrid('doCellTip',{'max-width':'300px','delay':500});
		}
	});
	
	$("#backCategoryPage #dg1").datagrid('load',{
		pid: ""
	});
	$("#backCategoryPage .categories-datagrid").datagrid('enableFilter');
	$("#backCategoryPage .datagrid-filter-row td").find('input').attr('placeholder','搜索');
	$("#backCategoryPage .datagrid-filter-row td[field='hide']").hide();
	$("#backCategoryPage .datagrid-filter-row td[field='url1'] input").hide();
	$("#backCategoryPage .panel-hide").hide();
	
	$('#category_img_upload').uploadPreview({
		Img : "category_img_ImgPr",
		Width : 200,
		Height : 200
	});

};
//属性组下拉
backCategories.attrGroupLoader = function(param,success,error){
	var q = param.q || '';
	var data = {};
	if(q!=''){
		if(!isNaN(q)){
			data.id = q;
		}else{
			data.name = q;
		}
	}
	$.ajax({
		url: 'backCategories/searchAttributeGroups',
		dataType: 'json',
		type:"post",  
        data: data,
		success: function(data){
			success(data);
		},
        error: function(){
			error.apply(this, arguments);
		}
	});
}
//属性下拉
backCategories.attrLoader = function(param,success,error){
	var q = param.q || '';
	var data = {};
	if(q!=''){
		if(!isNaN(q)){
			data.id = q;
		}else{
			data.name = q;
		}
	}
	$.ajax({
		url: 'backCategories/searchAttributes',
		dataType: 'json',
		type:"post",  
        data: data,
		success: function(data){
			success(data);
		},
        error: function(){
			error.apply(this, arguments);
		}
	});
}


backCategories.delTreeRow = function(groupId,id){
	var type;
	if(id == undefined){
		type = 2;//group
		id = groupId;
	}else{
		type = 1;//attr
	}
	$.ajax({  
        type:"post",  
        url:"backCategories/deleteGroupAttributes",  
        data:{
        	id : id,
        	type : type,
        	categoryCode : $(backCategories.pageId +" #lastCategoryCode").val() 
        },
        async:false,  
        success:function(msg) {
			if($.o2m.handleActionResult(msg)){
				$(backCategories.categridEditTg).treegrid('load',{categoryCode:$(backCategories.pageId +" #lastCategoryCode").val()});
			}
		} 
    });
}
backCategories.onClickCell = function(index,filed,value){
	var row = $(this).datagrid('getRows')[index];
	if(row.code == undefined){
		return;
	}
	if(filed == 'url1'){
		if(row.url1 != '' && row.url1 != null){
			$('#category_img_ImgPr').attr('src',picUrl + row.url1);
		}else{
			$('#category_img_ImgPr').attr('src','');
		}
		$('#category_img_upload').uploadPreview({
			Img : "category_img_ImgPr",
			Width : 200,
			Height : 200
		});
		
		$('#backcate_code').val(row.code);
		$('#backcate_name').val(row.name);
		$('#selected_backcate_id').val(backCategories.pageId+" #"+$(this).attr('id'));
		$('#category_img_upload').val('');
		$(backCategories.dlg).dialog('open');
	}
	var paDiv = $(this).parents('.categories-panel');
	var next = $(paDiv).next();
	if (row.level < 3) {
		$(next).show();

		$(next).find('.categories-datagrid').datagrid('load',{
			pid : row.code
		});
		$(next).nextAll().css('display', 'none');
	} else {
		$('#categories-attr-bind').show();
		$(backCategories.pageId +" #lastCategoryCode").val(row.code);
		$(backCategories.attrGroup).combobox("setValue",'');
		$(backCategories.group_index).numberbox('setValue',null);
		$(backCategories.categridEditDg).datagrid('rejectChanges');
		$(backCategories.categridEditTg).treegrid({url:'backCategories/getCategoryAttributes', 	queryParams: {categoryCode:row.code}});
	/*	spu.lastCategoryId = row.code;
		//末级
		$(spu.spuDiv).show();
		$(spu.spuDgId).datagrid('load',{
			categoryCode: spu.lastCategoryId
		});*/
		
	};
};
backCategories.uploadPic = function(){
	var code = $('#backcate_code').val();
	var name = $('#backcate_name').val();
	$.o2m.showProgressing();
	$.ajaxFileUpload ({
		url: 'backCategories/updatePic',
		secureuri: false, //是否需要安全协议，一般设置为false
		fileElementId: 'category_img_upload', //文件上传域的ID
		dataType: 'json',
		data:{"code":code,"name":name},
		type: 'post',
		success: function (data, status){ //服务器成功响应处理函数
			$.o2m.closeProgressing();
			if($.o2m.handleActionResult(data)){
				$(backCategories.dlg).dialog('close');
				$($('#selected_backcate_id').val()).datagrid('reload');
			}
		},error : function(e){
			$.o2m.closeProgressing();
		}
	});
}
backCategories.append = function (dgname) {
	$(dgname).datagrid('rejectChanges');
	$(dgname).datagrid('appendRow',{url1:'',level:dgname.substr(dgname.length-1),status:1});
	var editIndex = $(dgname).datagrid('getRows').length-1;
	eval("backCategories.dgname=editIndex");
	$(dgname).datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
}
backCategories.backend_edit = function (dgname){
	var editIndex = $(dgname).datagrid('getRowIndex', $(dgname).datagrid('getSelected'));
	$(dgname).datagrid('rejectChanges');
	if(editIndex >= 0){
		eval("backCategories.dgname=editIndex");
		$(dgname).datagrid('beginEdit', editIndex);
		var ed = $(dgname).datagrid('getEditor', {index:editIndex,field:'code'});
		var a = $(ed.target).parent();
		var b = $(ed.target).next().find('.validatebox-text');
		$(b).attr("readonly","readonly");
	}
};
backCategories.removeit = function (dgname) {
	var row = $(dgname).datagrid('getSelected');
	if (row) {
		var rowIndex = $(dgname).datagrid('getRowIndex', row);
		$.post('backCategories/delete/'+row.code, null, function (data) {
			if($.o2m.handleActionResult(data)){
            	$(dgname).datagrid('reload');
        	}
        });
	}

}
backCategories.accept = function (dgname) {
	var index = eval("backCategories.dgname");
	if(index != undefined){
		$(dgname).datagrid('acceptChanges');
		var row = $(dgname).datagrid('getRows')[index];
		if(row.pid != undefined){
			  $.ajax({ 
		            type:"POST", 
		            url:"backCategories/update", 
		            data : {
		            	code : row.code,
		            	name : row.name
		            },
		            success:function(msg){
		            	$.o2m.handleActionResult(msg);
		            	$(dgname).datagrid('reload');
		            }
		        });
		}else{
			if(row.code == '' || row.name == ''){
				$(dgname).datagrid('reload');
				return;
			}
			var prevDg = $(dgname).parents('.categories-panel').prev();
			if(prevDg.length == 1){
				row.pid = prevDg.find('.categories-datagrid').datagrid('getSelected').code;
			}else{
				row.pid = '';
			}
		      $.ajax({ 
		            type:"POST", 
		            url:"backCategories/create", 
		            dataType:"json",      
		            contentType:"application/json",               
		            data:JSON.stringify(row), 
		            success:function(msg){
		            	$.o2m.handleActionResult(msg);
		            	$(dgname).datagrid('reload');
		            }
		        });
		}
		eval("backCategories.dgname=undefined");
	}
}

backCategories.addRow = function () {
	var attrGroup = $(backCategories.attrGroup).combobox("getValue");
	var text = $(backCategories.attrGroup).combobox("getText");
	if (attrGroup == text) {
		$.messager.alert('警告', '请选择属性组！', 'warning');
		return;
	}
	var index = $(backCategories.group_index).numberbox('getValue');
	if (index == "" || index == undefined) {
		$.messager.alert('警告', '请输入属性组序号！', 'warning');
		return;
	}
	
	$(backCategories.categridEditDg).datagrid('appendRow', {});
	var editIndex = $(backCategories.categridEditDg).datagrid('getRows').length-1;
	$(backCategories.categridEditDg).datagrid('beginEdit', editIndex);
}
backCategories.delRow = function () {
	var rowNums = $(backCategories.categridEditDg).datagrid('getRowNum');
	for(var i = rowNums.length-1;i>= 0;i--){
		$(backCategories.categridEditDg).datagrid('deleteRow',rowNums[i]-1);
	}
	$(backCategories.categridEditDg).datagrid('clearChecked');
	
}
backCategories.save_attribute=function() {
	var attrGroup = $(backCategories.attrGroup).combobox("getValue");
	var text = $(backCategories.attrGroup).combobox("getText");
	if (attrGroup == text) {
		$.messager.alert('警告', '请先选择商品属性组！', 'warning');
		return;
	}
	var index = $(backCategories.group_index).numberbox('getValue');
	if (index == "" || index == undefined) {
		$.messager.alert('警告', '请输入商品属性序号！', 'warning');
		return;
	}
	$(backCategories.categridEditDg).datagrid('acceptChanges');
	var materials = $(backCategories.categridEditDg).datagrid('getRows');
	var arr = [];
	for (var i = 0; i < materials.length; i++) {
		if (materials[i].id == "" || materials[i].id == undefined) {
			$.messager.alert('警告', '请选择下拉属性', 'warning');
			return;
		}
		arr.push(materials[i]);
	}
	if(arr.length == 0){
		$.messager.alert('警告', '请增加属性组属性', 'warning');
		return;
	}
	var ga = {};
	ga.groupId = attrGroup;
	ga.index = index;
	ga.attributes = arr;
	ga.categoryCode = $(backCategories.pageId +" #lastCategoryCode").val();
	$.ajax({
		type : "POST",
		url : "backCategories/saveGroupAttributes",
		dataType : "json",
		contentType : "application/json",
		data : JSON.stringify(ga),
		success : function(msg) {
			if($.o2m.handleActionResult(msg)){
				$(backCategories.attrGroup).combobox("setValue",'');
				$(backCategories.group_index).numberbox('setValue',null);
				$(backCategories.categridEditDg).datagrid('loadData', { total: 0, rows: [] });
				$(backCategories.categridEditTg).treegrid('load',{categoryCode:$(backCategories.pageId +" #lastCategoryCode").val()});
			}
		}
	});
}
backCategories.tg_edit_id = undefined;
backCategories.backcate_tg_edit = function(){
	if(backCategories.tg_edit_id){
		$(backCategories.categridEditTg).treegrid('cancelEdit', backCategories.tg_edit_id);
	}
	var row = $(backCategories.categridEditTg).treegrid('getSelected');
	if(row){
		backCategories.tg_edit_id = row.flag;
		$(backCategories.categridEditTg).treegrid('beginEdit', backCategories.tg_edit_id);
	}
}
backCategories.backcate_tg_accept = function(){
    if (backCategories.tg_edit_id != undefined){
    	$(backCategories.categridEditTg).treegrid('endEdit', backCategories.tg_edit_id);
    	 return ;
		var row = $(backCategories.categridEditTg).treegrid('getSelected');
		alert(JSON.stringify(row));
        var id;
        if(row.type==1){
        	id = row.id;
        }else{
        	id = row.groupId;
        }
       
    	$.ajax({
            type:"post",  
            url:"backCategories/updateGroupAttributes",  
            data:{
            	id : id,
            	type : row.type,
            	categoryCode : $(backCategories.pageId +" #lastCategoryCode").val(),
            	index : row.index
            },  
            async:false,  
            success:function(msg) {
            	if($.o2m.handleActionResult(msg)){
            		$(backCategories.categridEditTg).treegrid('load',{categoryCode:$(backCategories.pageId +" #lastCategoryCode").val()});
            	}
    		} 
        });
    	backCategories.tg_edit_id = undefined;
    }
}

backCategories.inits();

