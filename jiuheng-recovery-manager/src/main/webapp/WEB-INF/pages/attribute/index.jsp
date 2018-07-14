<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form name="select_attribute_search_form" id="select_attribute_search_form">
</form>
<div id="select_attribute_data_container"></div>
<script type="text/javascript" src="common/js/common/prototype.js"></script>
<script type="text/javascript" src="common/js/common/jslist.js"></script>
<script type="text/javascript">
var datagrid;  
var rowEditor=undefined;
 var type = [{ "value": "1", "text": "基本属性" }, { "value": "2", "text": "功能异常" }, { "value": "3", "text": "外观异常" }];
$(function(){  
    datagrid=$("#select_attribute_data_container").datagrid({  
        url:ctx + "/device/getAttributeList.json",//加载的URL  
        isField:"id",  
        pagination:true,//显示分页  
        pageSize:20,//分页大小
        pageList:[5,10,15,20],//每页的个数  
        fit:true,//自动补全  
        fitColumns:true,  
        iconCls:"icon-save",//图标  
       /*  title:"用户管理",  */ 
        columns:[[//每个列具体内容  
                  {field:'id',title:'编号',width:20},     
                  {field:'name',title:'属性名称',width:100,editor : {  
                        type : 'validatebox',  
                        options : {  
                            required : true  
                        }  
                    }},
            {field:'type',title:'类型',width:100,formatter:function(value,row){
                if(value==1){
                    return "基本属性";
                }
                if(value==2){
                    return "功能异常";
                }
                if(value==3){
                    return "外观异常";
                }
                if(value==null){
                    return "";
                }
            },editor : {
                type : 'combobox',
                options : {
                    required : true,
                    data: type,
                    valueField: "value",
                    textField: "text",
                }

            }}
              ]],  
        toolbar:[//工具条  
                {text:"增加",iconCls:"icon-add",handler:function(){//回调函数  
                    if(rowEditor==undefined)  
                    {  
                        datagrid.datagrid('insertRow',{//如果处于未被点击状态，在第一行开启编辑  
                            index: 0,     
                            row: {  
                            }  
                        });  
                        rowEditor=0;  
                        datagrid.datagrid('beginEdit',rowEditor);//没有这行，即使开启了也不编辑  
                          
                    }  
                  
  
                }},  
                /* {text:"删除",iconCls:"icon-remove",handler:function(){  
                    var rows=datagrid.datagrid('getSelections');  
            
                    if(rows.length<=0)  
                    {  
                        $.messager.alert('警告','您没有选择','error');  
                    }  
                    else if(rows.length>1)  
                    {  
                        $.messager.alert('警告','不支持批量删除','error');  
                    }  
                    else  
                    {  
                        $.messager.confirm('确定','您确定要删除吗',function(t){  
                            if(t)  
                            {  
                                  
                                $.ajax({  
                                    url : '',  
                                    data : rows[0],  
                                    dataType : 'json',  
                                    success : function(r) {  
                                        if (r.success) {  
                                            datagrid.datagrid('acceptChanges');  
                                            $.messager.show({  
                                                msg : r.msg,  
                                                title : '成功'  
                                            });  
                                            editRow = undefined;  
                                            datagrid.datagrid('reload');  
                                        } else {  
                                            datagrid.datagrid('beginEdit', editRow);  
                                            $.messager.alert('错误', r.msg, 'error');  
                                        }  
                                        datagrid.datagrid('unselectAll');  
                                    }  
                                });  
                              
                            }  
                        })  
                    }  
                      
                      
                }},   */
                {text:"修改",iconCls:"icon-edit",handler:function(){  
                    var rows=datagrid.datagrid('getSelections');  
                    if(rows.length==1)  
                    {  
                        if(rowEditor==undefined)  
                        {  
                            var index=datagrid.datagrid('getRowIndex',rows[0]);  
                             rowEditor=index;  
                            datagrid.datagrid('unselectAll');  
                            datagrid.datagrid('beginEdit',index);  
                              
                        }  
                    }  
                }},  
                /* {text:"查询",iconCls:"icon-search",handler:function(){}},  */ 
                {text:"保存",iconCls:"icon-save",handler:function(){  
                      
                    datagrid.datagrid('endEdit',rowEditor);  
                    rowEditor=undefined;  
                }},  
                {text:"取消编辑",iconCls:"icon-redo",handler:function(){  
                    rowEditor=undefined;  
                    datagrid.datagrid('rejectChanges')  
                }}  
                ],  
        onAfterEdit:function(rowIndex, rowData, changes){  
            var inserted = datagrid.datagrid('getChanges', 'inserted');  
            var updated = datagrid.datagrid('getChanges', 'updated');  
            if (inserted.length < 1 && updated.length < 1) {  
                editRow = undefined;  
                datagrid.datagrid('unselectAll');  
                return;  
            }  
  
            var url = '';  
            if (inserted.length > 0) {  
                url = ctx + "/device/saveAttribute";  
            }  
            if (updated.length > 0) {  
                url = ctx + "/device/saveAttribute";  
            }  
  
            $.ajax({  
                url : url,  
                data : rowData,  
                dataType : 'json',
                method:'post',
                success : function(r) {  
                    if (r.success) {  
                        datagrid.datagrid('acceptChanges');  
                        $.messager.show({  
                            msg : '信息添加成功！',  
                            title : '成功'  
                        });  
                        editRow = undefined;  
                        datagrid.datagrid('reload');  
                    } else {  
                        /*datagrid.datagrid('rejectChanges');*/  
                        datagrid.datagrid('beginEdit', editRow);  
                        $.messager.alert('错误', r.msg, 'error');  
                    }  
                    datagrid.datagrid('unselectAll');  
                }  
            });  
              
        },  
        onDblClickCell:function(rowIndex, field, value){  
            if(rowEditor==undefined)  
            {  
                datagrid.datagrid('beginEdit',rowIndex);  
                rowEditor=rowIndex;  
            }  
              
        }  
    });}) 

</script>