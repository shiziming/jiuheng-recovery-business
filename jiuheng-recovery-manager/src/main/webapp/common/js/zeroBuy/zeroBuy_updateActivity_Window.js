var zeroBuyUpdateDetail = {};
zeroBuyUpdateDetail.pageId="#zeroBuy_AddZeroBuyDetail";
zeroBuyUpdateDetail.orderNum=zeroBuyUpdateDetail.pageId+" #orderNumId";
zeroBuyUpdateDetail.salAgencyCode=zeroBuyUpdateDetail.pageId+" #salAgencyCode";
zeroBuyUpdateDetail.activityId=zeroBuyUpdateDetail.pageId+" #activityId";
zeroBuyUpdateDetail.activityName=zeroBuyUpdateDetail.pageId+" #activityName";
zeroBuyUpdateDetail.startDate=zeroBuyUpdateDetail.pageId+" #startDate";
zeroBuyUpdateDetail.endDate=zeroBuyUpdateDetail.pageId+" #endDate";
zeroBuyUpdateDetail.beginDateId=zeroBuyUpdateDetail.pageId+" #beginDateId";
zeroBuyUpdateDetail.endDateId=zeroBuyUpdateDetail.pageId+" #endDateId";

var orderNum=$(zeroBuyUpdateDetail.orderNum).val();
var salAgencyCode=$(zeroBuyUpdateDetail.salAgencyCode).val();
zeroBuyUpdateDetail.queryActivity=function(){
	$("#magnifier_Activity_window").window({
        width: 700,
        height: 450,
        modal: true,
        inline:true,
        href: "zeroBuy/openNewActivityMagnifierWindow",
        title: "活动查询"
    });
	$('#magnifier_Activity_window').window('open');
}

/**
 * 返回列表页面
 */
zeroBuyUpdateDetail.returnToListPage=function(){
	$(zeroBuyManage.update).panel('close');
	$(zeroBuyManage.zeroBuy_list_list_panel).show();
	$(zeroBuyManage.zeroBuy_list_dg).datagrid('reload')
	
}

/**
 * 修改
 */
zeroBuyUpdateDetail.updateZeroBuy=function(){
	var activityId=$(zeroBuyUpdateDetail.activityId).textbox('getText');
	var activityName=$(zeroBuyUpdateDetail.activityName).textbox('getText');
	var startDate=$(zeroBuyUpdateDetail.startDate).textbox('getValue');
	var endDate=$(zeroBuyUpdateDetail.endDate).textbox('getValue');
	var beginDateId=$(zeroBuyUpdateDetail.beginDateId).val();
	var endDateId=$(zeroBuyUpdateDetail.endDateId).val();
	var orderNum=$(zeroBuyUpdateDetail.orderNum).val();
	var arys1= new Array();     
    var arys2= new Array();
	var arys3= new Array();     
    var arys4= new Array();
    arys1=startDate.split('-');
    arys2=beginDateId.split('-');
    arys3=endDate.split('-');
    arys4=endDateId.split('-');
    var newTime=arys1[0]+arys1[1]+arys1[2];
    var oldTime=arys2[0]+arys2[1]+arys2[2];
    var newTime1=arys3[0]+arys3[1]+arys3[2];
    var oldTime1=arys4[0]+arys4[1]+arys4[2];
    if(newTime-newTime1>0){
    	$.messager.alert('提示','活动开始时间不能大于活动结束时间','info');
    	return false;
    }
    if(newTime-oldTime1>0){
    	$.messager.alert('提示','活动开始时间不能大于预计活动结束时间','info');
    	return false;
    }
    if(newTime1-newTime<0){
    	$.messager.alert('提示','活动结束时间不能小于活动开始时间','info');
    	return false;
    }
    if(newTime1-oldTime<0){
    	$.messager.alert('提示','活动结束时间不能小于预计活动开始时间','info');
    	return false;
    }
    if(oldTime-newTime>0){
    	$.messager.alert('提示','活动开始时间不能小于活动预计开始时间','info');
    	return false;
    }
    if(oldTime1-newTime1<0){
    	$.messager.alert('提示','活动结束时间不能大于活动预计结束时间','info');
    	return false;
    }
    $.ajax({
    	url:"zeroBuy/updateActivity",
    	data:{promotionCode:activityId,beginDate:startDate,endDate:endDate,orderNum:orderNum},
    	success:function(data){
    		if(data.code==0){
				$.messager.alert('提示',data.msg,'info');
			}else if(data.code==1){
				$.messager.alert('警告',data.msg,'info');
			}
    	}
    	
    	
    })
    
}
