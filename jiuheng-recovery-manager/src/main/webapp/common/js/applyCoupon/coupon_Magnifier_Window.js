var coupon = {};
couponMagnifierWindowPageId="#couponMagnifierWindow";
coupon.btnReturn='#backbtn';
coupon.i=couponMagnifierWindowPageId+" #i";
/**
 * 页面初始化函数
 */
coupon.inits = function() {
	$('#coupon').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:coupon.btnReturn,
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
			title : '结束时间',
			align:'left',
			width : 80
		}] ]
	});
}
/**
 * 查询
 */
function serchCoupon(){
	var couponTypeId=$('#couponTypeId').val();
	var couponName=$('#couponName').val();
	$('#coupon').datagrid({
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
coupon.returnToListPage=function(){
	var i=$(coupon.i).val();
	if(null!=i&&""!=i){
	 $('#couponMagnifier').window('close');
	}else{
		 $('#magnifier_SpuName_window').window('close');
	}
}
/**
 * 双击选择
 */
$('#coupon').datagrid({
onDblClickRow: function(rowIndex, rowData){
	var i=$(coupon.i).val();
		$(applyCoupon_addss.applyCoupondg).datagrid('acceptChanges');
		var row = $(applyCoupon_addss.applyCoupondg).datagrid('getRows')[i];
		//var materials = $(applyCoupon_addss.applyCoupondg).datagrid('getRows');
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
	    $('#couponMagnifier').window('close');
	    $(applyCoupon_addss.applyCoupondg).datagrid('updateRow',{
			index : parseInt(i),
			row : row
		});
}
})

coupon.inits();