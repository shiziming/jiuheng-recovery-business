var newCoupon = {};
newCoupon.pageId="#newCouponMagnifierWindow";
newCoupon.btnReturn='#backbtn';
newCoupon.couponType=newCoupon.pageId+" #couponType";
newCoupon.couponName=newCoupon.pageId+" #couponName";
/**
 * 页面初始化函数
 */
newCoupon.inits = function() {
	$('#newCoupon').datagrid({
		striped : true,
		rownumbers : true,
		height : document.documentElement.clientHeight * 0.86,
		pagination :true,
		pageSize : 20,
		striped:true,
		fitColumns:true,
		toolbar:newCoupon.btnReturn,
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
	var couponTypeId=$(newCoupon.couponTypeId).val();
	var couponName=$(newCoupon.couponName).val();
	$('#newCoupon').datagrid({
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
newCoupon.returnToListPage=function(){
		 $('#applyCouponMagnifier').window('close');
}
/**
 * 双击选择
 */
$('#newCoupon').datagrid({
onDblClickRow: function(rowIndex, rowData){
		 $('#applyCouponMagnifier').window('close');
			$(applyCoupon_update.couponType).textbox('setValue', rowData.couponTypeId);
			$(applyCoupon_update.couponName).textbox('setValue', rowData.couponName);
			$(applyCoupon_update.havefunBegin).datebox('setValue',rowData.startDate);
			$(applyCoupon_update.havefunEnd).datebox('setValue',rowData.endDate);
			$(applyCoupon_update.havefunBeginId).val(rowData.startDate);
			$(applyCoupon_update.havefunEndId).val(rowData.endDate);
	}
})

newCoupon.inits();