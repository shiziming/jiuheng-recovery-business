(function(jQuery) {
	/*
	 * 带安商品库存设置单明细导入
	 */
	$.dastorageImportUtils = {
			/**
			 * 导入
			 */
			importExcel : function(obj) {
				//判断上传文件是否为excel
				var ratefileaa = $('input[name=dastorage_fileimport]').val();
				if (ratefileaa.lastIndexOf('.xls') == "-1") {
					$.messager.alert("操作提示","请选择excel格式文件","warning");
					return;
				}
				var curForm = $('#dastorageImport_form');
				curForm.form({
					onSubmit: function () {
						curForm.form('enableValidation');
						//return curForm.form('validate');
						// 验证表单
						var beValidate = curForm.form('validate');
						if (beValidate) {
							// 验证通过，灰掉link-button
							$(obj).linkbutton('disable');
						}

						return beValidate;
					},
				    success:function(data) {
				    	// 提交返回，使link-button正常
				    	$(obj).linkbutton('enable');
				    	var result = $.parseJSON(data);
				    	if(result!=null)
				    	$.o2m.handleActionResult(result);
				    	curForm.form('disableValidation');
				    	curForm.form('clear');
				    }
				});
				curForm.form('submit');
			},

			
			/**
			 * 页面初始化函数
			 */
			inits : function() {
			}	
	};
	
})(jQuery);

$.dastorageImportUtils.inits();
