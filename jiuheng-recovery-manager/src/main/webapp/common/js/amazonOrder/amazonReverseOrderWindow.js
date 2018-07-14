var creatReverseOrder = {};


/**
 * 页面初始化函数
 */
creatReverseOrder.inits = function() {};

creatReverseOrder.back=function(){
	$('#amazonOrder_index_creatReverseOrder').window('close');
}

creatReverseOrder.creat=function(){
	$('#amazonOrder_index_creatReverseOrder').window('close');
	var reverseReason=$('#amazonOrder_index_creatReverseOrder #reverseReason').combobox('getValue');
	var xsfdh=$('#creatPositiveOrder_page #xsfdh' ).val();
	var xsddh=$('#creatPositiveOrder_page #xsddh' ).val();
	$.ajax({
        type:"POST", 
        url:"amazonOrder/creatReverseOrder",
        data:{"reverseReason":reverseReason,"xsfdh":xsfdh,"xsddh":xsddh},
        success:function(data){
        	if(data.code==0){
	        	parent.$.messager.alert('提示',data.msg,'info');
        	}else if(data.code==1){
        		parent.$.messager.alert('警告',data.msg,'worm');
        	}
        }
    }); 
}

creatReverseOrder.inits();
