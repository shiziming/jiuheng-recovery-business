var applyCouponMagnifier = {};
applyCouponMagnifier.pageId="#applyCouponMagnifierWindow";
applyCouponMagnifier.backbtn=applyCouponMagnifier.pageId+' #backbtn';
applyCouponMagnifier.i=applyCouponMagnifier.pageId+" #i";
applyCouponMagnifier.couponType=applyCouponMagnifier.pageId+" #couponType";
applyCouponMagnifier.couponName=applyCouponMagnifier.pageId+" #couponName";
applyCouponMagnifier.applyCoupondg=applyCouponMagnifier.pageId+" #applyCoupondg";
/**
 * 页面初始化函数
 */
applyCouponMagnifier.inits = function() {
	$(applyCouponMagnifier.applyCoupondg).datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:applyCouponMagnifier.backbtn,
		url : "applyCoupon/queryCouponList",
		columns : [ [{
			field : 'couponTypeId',
			title : '优惠券类型',
			align:'left',
			width : 80
		},{
			field : 'couponName',
			title : '优惠券名称',
			align:'left',
			width : 80
		},{
			field : 'startDate',
			title : '开始时间',
			align:'left',
			width : 80
		},{
			field : 'endDate',
			title : '结束1时间',
			align:'left',
			width : 80
		}] ]
	});
}
/**
 * 查询
 */
function serchCoupon(){
	var couponTypeId=$(applyCouponMagnifier.couponTypeId).val();
	var couponName=$(applyCouponMagnifier.couponName).val();
	$(applyCouponMagnifier.applyCoupondg).datagrid({
		url:'applyCoupon/queryCouponList',
		queryParams: {
			couponTypeId:couponTypeId,
			couponName:couponName
		}
	});
}
/**
 * 返回
 */
applyCouponMagnifier.returnToListPage=function(){
	 $('#addApplyCouponMagnifier').window('close');
}
/**
 * 双击选择
 */
$(applyCouponMagnifier.applyCoupondg).datagrid({
onDblClickRow: function(rowIndex, rowData){
		var i=$(applyCouponMagnifier.i).val();
		$(applyCoupon_add.dgId).datagrid('acceptChanges');
		var row = $(applyCoupon_add.dgId).datagrid('getRows')[i];
		var materials = $(applyCoupon_add.dgId).datagrid('getRows');
		/*for(var j = materials.length-1;j>= 0;j--){
			if(rowData.couponType==materials[j].couponType){
				$.messager.alert('警告','该优惠券已添加，请添加其他优惠券！','info');
				return false;
			}
		}*/
		row.couponType = rowData.couponTypeId;
		row.couponName = rowData.couponName;
		row.havefunBegin = rowData.startDate;
		row.havefunEnd = rowData.endDate;
		row.funBegin = rowData.startDate;
		row.funEnd = rowData.endDate;
	    $('#addApplyCouponMagnifier').window('close');
	    $(applyCoupon_add.dgId).datagrid('updateRow',{
			index : parseInt(i),
			row : row
		});
}
})

applyCouponMagnifier.inits();