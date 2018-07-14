<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">

	var categoryAttrAdd = {};
	categoryAttrAdd.addAttr = function(obj) {
		var td = $(obj).parent();
		if(td.find('input:eq(1)').val() != ''){
			var tdNew = $(obj).parent().clone();
			tdNew.find('input:first').val(parseInt(td.find('input:first').val())+1);
			tdNew.find('input:eq(1)').val('');
			$(categoryAttr.panelId +" #attrTable").append($('<tr>').append($('<td>')).append(tdNew));
			var delBut = "<a class=\"easyui-linkbutton\" data-options=\"iconCls:'icon-remove'\" onClick=\"categoryAttrAdd.delAttr(this)\">删除</a>";
			$(obj).parent().append(delBut);
			$.parser.parse($(obj).parent());
			tdNew.find('input:eq(1)').focus();
			$(obj).remove();
		}
	}
	categoryAttrAdd.delAttr = function(obj){
		$.each($(obj).parent().parent().nextAll(),function(i,n){
			$(n).find('input:first').val(parseInt($(n).find('input:first').val())-1);
		});
		//删除首行数据
		if($(obj).parent().parent().find('td:first').html() != ''){
			var first = $(obj).parent().parent();
			var next = $(obj).parent().parent().next();
			first.find('td:eq(1)').remove();
			first.append(next.find('td:eq(1)'));
			next.remove();
		}else{
			$(obj).parent().parent().remove();
		}
	}
	$(categoryAttr.panelId +" #dataType").combobox({
		onChange: function (n,o) {
			if(n == 2){
				$.each($(categoryAttr.panelId + " td .attr-value") , function(i,n){
					$(this).val($(this).val().replace(/[^0-9]*/g,""));
					$(this).on('keyup',function(){
						$(this).val($(this).val().replace(/[^0-9]*/g,""));
					}); 
				});
			}else{
				$.each($(categoryAttr.panelId + " td .attr-value") , function(i,n){
					$(this).unbind('keyup');
				});
			}
		}
	});
	$(categoryAttr.panelId +" #chooseType").combobox({
		onChange: function (n,o) {
			//从手输切换
			if(o == 0){
				$(categoryAttr.panelId +" #addAttrValueTr").nextAll().show();
				$(categoryAttr.panelId +" #addAttrValueTr").show();
			//切换到手输
			}else if(n == 0){
				$(categoryAttr.panelId +" #addAttrValueTr").nextAll().hide();
				$(categoryAttr.panelId +" #addAttrValueTr").hide();
			}
		}
	});
	
	//保存
	categoryAttrAdd.saveAttrValue = function(){
		var goodsattr = {};
		goodsattr.name = $(categoryAttr.panelId + " #attrName").val();
		goodsattr.dataType= $(categoryAttr.panelId + " #dataType").combobox('getValue'); 
		goodsattr.chooseType= $(categoryAttr.panelId + " #chooseType").combobox('getValue'); 
		
		var arr = new Array();
		if(goodsattr.chooseType != "0"){
			var first = $(categoryAttr.panelId + " #addAttrValueTr");
			if(first.find('td:eq(1)').find('input:eq(1)').val() != ''){
				var obj = new Object();
				obj.num = first.find('td:eq(1)').find('input:first').val();
				obj.goodsattrvalue = first.find('td:eq(1)').find('input:eq(1)').val();
				   arr.push(obj);
				$.each($(categoryAttr.panelId + " #addAttrValueTr").nextAll(),function(i,n){
					if($(this).find('td:eq(1)').find('input:eq(1)').val() != ''){
						var objNext = new Object();
						objNext.num = $(this).find('td:eq(1)').find('input:first').val();
						objNext.goodsattrvalue = $(this).find('td:eq(1)').find('input:eq(1)').val();
						arr.push(objNext);
					}
				});
			}
		}

		 var param = {};
		 param.goodsattr = goodsattr;
		 param.goodsattrvalue = arr;
 		
		 $.ajax({
			type : "POST",
			url : "attribute/addData",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(param),
			success : function(result) {
				if($.o2m.handleActionResult(result)){
					$(categoryAttr.panelId).panel('close');
					$(categoryAttr.gridId).datagrid('reload');
					$(categoryAttr.listId).show();
				}
			}
		 }); 
	}
	categoryAttrAdd.checkIsNum = function(obj){
		if($(categoryAttr.panelId +" #dataType").combobox('getValue') == 2){
			$.o2m.replaceNotNum(obj);
		}
	}
	
</script>
<style>
#attrPage #editPanel table {
	padding: 30px 80px
}

#attrPage #editPanel table tr {
	line-height: 30px;
}

#attrPage #editPanel table tr td:first-child {
	width: 100px;
	text-align: center;
}
</style>
<div style="width: 100%; height: 100%; background-color: #eff5ff;">
	<table id="attrTable">
		<tr>
			<td>属性名称:</td>
			<td><input name="name" id="attrName" /></td>
		</tr>
		<tr>
			<td>数据类型:</td>
			<td><select id="dataType" class="easyui-combobox" style="width: 150px" onChange="fun(this)">
					<option value="1" selected="selected">文本</option>
					<option value="2">数值</option>
			</select></td>
		</tr>
		<tr>
			<td>文本类型:</td>
			<td><select id="chooseType" class="easyui-combobox" style="width: 150px">
					<option value="1" selected="selected">单选</option>
					<option value="2">多选</option>
					<option value="0">手输</option>
			</select></td>
		</tr>
		<tr id="addAttrValueTr">
			<td>添加属性:</td>
			<td><input placeholder="序号" value=1 style="width: 25px" readonly="readonly"/>
				&nbsp;<input placeholder="属性值" class="attr-value" onkeyup="categoryAttrAdd.checkIsNum(this)"/>&nbsp; <a
				class="easyui-linkbutton" data-options="iconCls:'icon-add'"
				onClick="categoryAttrAdd.addAttr(this)">添加</a></td>
		</tr>
	</table>

	<div style="padding: 0px 80px">
		<a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'"
			style="padding: 5px 0px; width: 150px;"
			onclick="categoryAttrAdd.saveAttrValue();"> <span style="font-size: 14px;">保
				存</span>
		</a> <a href="javascript:void(0);" id="btnReturn"
			class="easyui-linkbutton" data-options="iconCls:'icon-back'"
			style="padding: 5px 0px; width: 150px; margin-left: 50px"
			onclick="categoryAttr.returnToListPage();"> <span
			style="font-size: 14px;">返 回</span>
		</a>
	</div>

</div>