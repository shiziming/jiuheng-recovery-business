<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function onLoadSuccess(data){
		var merges = [{
			index: 0,
			field: "code",
			rowspan: 2
		},{
			index: 2,
			field: "code",
			rowspan: 2
		},{
			index: 4,
			field: "code",
			rowspan: 2
		},{
			index: 6,
			field: "code",
			rowspan: 2
		},{
			index: 8,
			field: "code",
			rowspan: 2
		},{
			index: 0,
			field: "price",
			rowspan: 2
		},{
			index: 2,
			field: "price",
			rowspan: 2
		},{
			index: 4,
			field: "price",
			rowspan: 2
		},{
			index: 6,
			field: "price",
			rowspan: 2
		},{
			index: 8,
			field: "price",
			rowspan: 2
		}
	];
	for(var i=0; i<merges.length; i++){
		$(this).datagrid('mergeCells',{
			index: merges[i].index,
			field: merges[i].field,
			rowspan: merges[i].rowspan
		});
	}
	}

	function pushSPU(){
		var spuid = $('#spuid').attr("value");
		var startSpuid=$('#startSpuid').attr("value");
		var endSpuid=$('#endSpuid').attr("value");
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 if(spuid!=''){
			 $.post("schedule/pushSPU?spuid=" + spuid,
						function(msg){
							 setTimeout(function() {
	                               $.messager.progress('close');
	                           }, 100);
							if(msg == "success"){
								$.messager.alert('提示:','任务调度成功!');
							}else{
								$.messager.alert('提示:','任务出现异常!');
							}
						});
		 }else{
			 if(startSpuid==''||endSpuid==''){
				 alert("起始和结束SPU都不能为空！");
			 }else{
				 $.post("schedule/pushSPUWithStartEnd?startSpuid=" + startSpuid+"&endSpuid="+endSpuid,
							function(msg){
								 setTimeout(function() {
		                               $.messager.progress('close');
		                           }, 100);
								if(msg == "success"){
									$.messager.alert('提示:','任务调度成功!');
								}else if(msg == "startSpuidNotExist"){
									$.messager.alert('提示:','起始SPU不存在!');
								}else if(msg == "endSpuidNotExist"){
									$.messager.alert('提示:','结束SPU不存在!');
								}else{
									$.messager.alert('提示:','任务出现异常!');
								}
							});
		 }
		 }
	};
	
	
	
	function pushSkU(){
		var skuid = $('#skuid').attr("value");
		var startSkuid=$('#startSkuid').attr("value");
		var endSkuid=$('#endSkuid').attr("value");
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 if(skuid!=''){
			 $.post("schedule/pushSkU?skuid=" + skuid,
						function(msg){
							 setTimeout(function() {
	                               $.messager.progress('close');
	                           }, 100);
							if(msg == "success"){
								$.messager.alert('提示:','任务调度成功!');
							}else if(msg =="imageisnull"){
								$.messager.alert('提示:','主图和详情图必须存在!');
							}else if(msg =="notSPU"){
								$.messager.alert('提示:','该商品未绑定SPU!');
							}else{
								$.messager.alert('提示:','任务出现异常!');
							}
						});
		 }else{
			 if(startSkuid==''||endSkuid==''){
				 alert("起始和结束SPU都不能为空！");
			 }else{
				 $.post("schedule/pushSKUWithStartEnd?startSkuid=" + startSkuid+"&endSkuid="+endSkuid,
							function(msg){
								 setTimeout(function() {
		                               $.messager.progress('close');
		                           }, 100);
								if(msg == "success"){
									$.messager.alert('提示:','任务调度成功!');
								}else if(msg == "startSKuidNotExist"){
									$.messager.alert('提示:','起始SKU不存在!');
								}else if(msg == "endSKuidNotExist"){
									$.messager.alert('提示:','结束SKU不存在!');
								}else if(msg.indexOf("推送失败，请从此条后的数据重新推送")){
									$.messager.alert('提示:',msg);
								}
								else{
									$.messager.alert('提示:','任务出现异常!');
								}
							});
		 	}
		 }
	};
	

	function transferInventoryToWD(){
		 $.messager.progress({
           title: '请稍候',
           msg: '任务调度中...'
       	});
		 $.post("schedule/transferInventoryToWD",
					function(msg){
						 setTimeout(function() {
                              $.messager.progress('close');
                          }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};


	function pushBackCategories(){
		 $.messager.progress({
           title: '请稍候',
           msg: '任务调度中...'
       });
		 $.post("schedule/pushBackCategories",
					function(msg){
						 setTimeout(function() {
                              $.messager.progress('close');
                          }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function pushBrand(){
		 $.messager.progress({
           title: '请稍候',
           msg: '任务调度中...'
       	});
		 $.post("schedule/pushBrand",
					function(msg){
						 setTimeout(function() {
                              $.messager.progress('close');
                          }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function transferUpdownStatusToWD(){
		var upid = $('#upid').attr("value");
		 $.messager.progress({
          title: '请稍候',
          msg: '任务调度中...'
      	});
		 $.post("schedule/transferUpdownStatusToWD?upid="+upid,
					function(msg){
						 setTimeout(function() {
                             $.messager.progress('close');
                         }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	
	function transferZeroProductToWD(){
		var zeroid = $('#zeroid').attr("value");
		if(zeroid==""){
			alert("请填写零元购单号！");
			return;
		}
		 $.messager.progress({
          title: '请稍候',
          msg: '任务调度中...'
      	});
		 $.post("schedule/transferZeroProductToWD?zeroid="+zeroid,
					function(msg){
						 setTimeout(function() {
                             $.messager.progress('close');
                         }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else if(msg == "statusNotFit"){
							$.messager.alert('提示:','审核通过或终止的单据才能推送给端点！!');
						}else if(msg == "noData"){
							$.messager.alert('提示:','该单号下没有数据可以推送!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function transferFinishZeroProduct(){
		var zeroSaleOrgId = $('#zeroSaleOrgId').attr("value");
		if(zeroSaleOrgId==""){
			alert("请填写销售组织代码！");
			return;
		}
		 $.messager.progress({
          title: '请稍候',
          msg: '任务调度中...'
      	});
		 $.post("schedule/transferFinishZeroProduct?zeroSaleOrgId="+zeroSaleOrgId,
					function(msg){
						 setTimeout(function() {
                             $.messager.progress('close');
                         }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else if(msg == "noData"){
							$.messager.alert('提示:','该销售组织下没有数据可以推送!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function transferHotSkus(){
		var type=$('#hotbox option:selected') .val();
		var hotid = $('#hotid').attr("value");
		 $.messager.progress({
         title: '请稍候',
         msg: '任务调度中...'
     	});
		 $.post("schedule/transferHotSkus?type="+type+"&hotid="+hotid,
					function(msg){
						 setTimeout(function() {
                            $.messager.progress('close');
                        }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度 成功!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function transferPriceToWD(){
		var skuid=$('#skuid2').attr("value");
		var saleOrgId = $('#saleOrgId').attr("value");
		//要么都为空 要么都不为空
		if(skuid==""&&saleOrgId==""){
			
		}else if(skuid!=""&&saleOrgId!=""){
			
		}else{
			alert("销售组织或SKU为空！");
			return;
		}
		$.messager.progress({
         title: '请稍候',
         msg: '任务调度中...'
     	});
		 $.post("schedule/transferPriceToWD?skuid="+skuid+"&saleOrgId="+saleOrgId,
					function(msg){
						 setTimeout(function() {
			                 $.messager.progress('close');
			             }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else if(msg=="priceNull"){
							$.messager.alert('提示:','该销售组织下的该SKU价格不存在!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	

	function transferCommissionToWD(){
		var skuid=$('#skuid3').attr("value");
		var saleOrgId = $('#saleOrgId2').attr("value");
		//要么都为空 要么都不为空
		if(skuid==""&&saleOrgId==""){
			
		}else if(skuid!=""&&saleOrgId!=""){
			
		}else{
			alert("销售组织或SKU为空！");
			return;
		}
		$.messager.progress({
         title: '请稍候',
         msg: '任务调度中...'
     	});
		 $.post("schedule/transferCommissionToWD?skuid="+skuid+"&saleOrgId="+saleOrgId,
					function(msg){
						 setTimeout(function() {
			                 $.messager.progress('close');
			             }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else if(msg=="priceNull"){
							$.messager.alert('提示:','该销售组织下的该SKU佣金不存在!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function querySKUName(obj) {
		var skuid = obj.value;
		if(skuid==""){
			$('#skuname').val("");
		}else{
			$.ajax({
				type : "POST",
				url : 'schedule/getSKUName?skuid=' + skuid,
				dataType : "json",
				contentType : "application/json",
				success:function(result){
						//增加非空判断
						if(result != null&&result!=""){
							$('#skuname').val(result[0].skuname);
						}else{
							alert("该商品不存在！");
							$('#skuname').val("");
						}
				}
			});
		}
	};
	
	function querySKUName2(obj) {
		var skuid = obj.value;
		if(skuid==""){
			$('#skuname2').val("");
		}else{
		 	$.ajax({
			type : "POST",
			url : 'schedule/getSKUName?skuid=' + skuid,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#skuname2').val(result[0].skuname);
					}else{
						alert("该商品不存在！");
						$('#skuname2').val("");
					}
			}
		});
		 	}
	};

	function querySKUName3(obj) {
		var skuid = obj.value;
		if(skuid==""){
			$('#skuname3').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/getSKUName?skuid=' + skuid,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#skuname3').val(result[0].skuname);
					}else{
						alert("该商品不存在！");
						$('#skuname3').val("");
					}
			}
		});
		}
	};
	
	function querySKUName4(obj) {
		var skuid = obj.value;
		if(skuid==""){
			$('#skuname4').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/getSKUName?skuid=' + skuid,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#skuname4').val(result[0].skuname);
					}else{
						alert("该商品不存在！");
						$('#skuname4').val("");
					}
			}
		});
		}
	};

	function querySPUName(obj) {
		var spuid = obj.value;
		if(spuid==""){
			$('#spuname').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/getSPUName?spuid=' + spuid,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#spuname').val(result[0].spuname);
					}else{
						alert("该SPU不存在！");
						$('#spuname').val("");
					}
			}
		});
		}
	};

	function querySaleOrgName(obj) {
		var saleOrgId = obj.value;
		if(saleOrgId==""){
			$('#saleOrgName').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/querySaleOrgName?saleOrgId=' + saleOrgId,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#saleOrgName').val(result[0].saleOrgName);
					}else{
						alert("该销售组织不存在！");
						$('#saleOrgName').val("");
					}
			}
		});
		}
	};
	
	function queryZeroSaleOrgName(obj) {
		var saleOrgId = obj.value;
		if(saleOrgId==""){
			$('#zeroSaleOrgName').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/querySaleOrgName?saleOrgId=' + saleOrgId,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#zeroSaleOrgName').val(result[0].saleOrgName);
					}else{
						alert("该销售组织不存在！");
						$('#zeroSaleOrgName').val("");
					}
			}
		});
		}
	};
	
	function querySaleOrgName2(obj) {
		var saleOrgId = obj.value;
		if(saleOrgId==""){
			$('#saleOrgName2').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/querySaleOrgName?saleOrgId=' + saleOrgId,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#saleOrgName2').val(result[0].saleOrgName);
					}else{
						alert("该销售组织不存在！");
						$('#saleOrgName2').val("");
					}
			}
		});
		}
	};

	function queryUpDown(obj) {
		var upid = obj.value;
		if(upid!=''){
			$.post("schedule/queryUpDown?upid=" + upid,
				function(msg){
					if(msg == "notExist"){
						$.messager.alert('提示:','单号不存在!');
					}else if(msg =="notUpDown"){
						$.messager.alert('提示:','该单子处于审核状态，不能推送!');
					}else if(msg=="error"){
						$.messager.alert('提示:','输入有误，请重新输入!');
					}
				});
		}
	};
	
	function queryHotSku(obj) {
		var type=$('#hotbox option:selected') .val();
		var hotid = obj.value;
		if(hotid!=''){
			$.post("schedule/queryHotSkuStatus?hotid=" + hotid+"&type="+type,
				function(msg){
					if(msg == "noData"){
						$.messager.alert('提示:','该单据不存在!');
					}else if(msg =="noCheckData"){
						$.messager.alert('提示:','该单据没有通过审核，不能推送!');
					}else if(msg =="noBill"){
						$.messager.alert('提示:','该销售组织下无单据，不能推送!');
					}else if(msg =="error"){
						$.messager.alert('提示:','输入有误，请重新输入!');
					}
				});
		}
	};
	
	function pushMDSkU(){
		var skuid = $('#skuid4').attr("value");
		var startSkuid=$('#startSkuid2').attr("value");
		var endSkuid=$('#endSkuid2').attr("value");
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 if(skuid!=''){
			 $.post("schedule/pushMdSkU?skuid=" + skuid,
						function(msg){
							 setTimeout(function() {
	                               $.messager.progress('close');
	                           }, 100);
							if(msg == "success"){
								$.messager.alert('提示:','任务调度成功!');
							}else if(msg =="imageisnull"){
								$.messager.alert('提示:','主图和详情图必须存在!');
							}else if(msg =="notSPU"){
								$.messager.alert('提示:','该商品未绑定SPU!');
							}else{
								$.messager.alert('提示:','任务出现异常!');
							}
						});
		 }else{
			 if(startSkuid==''||endSkuid==''){
				 alert("起始和结束SPU都不能为空！");
			 }else{
				 $.post("schedule/pushMdSKUWithStartEnd?startSkuid=" + startSkuid+"&endSkuid="+endSkuid,
							function(msg){
								 setTimeout(function() {
		                               $.messager.progress('close');
		                           }, 100);
								if(msg == "success"){
									$.messager.alert('提示:','任务调度成功!');
								}else if(msg == "startSKuidNotExist"){
									$.messager.alert('提示:','起始SKU不存在!');
								}else if(msg == "endSKuidNotExist"){
									$.messager.alert('提示:','结束SKU不存在!');
								}else if(msg.indexOf("推送失败，请从此条后的数据重新推送")){
									$.messager.alert('提示:',msg);
								}
								else{
									$.messager.alert('提示:','任务出现异常!');
								}
							});
		 	}
		 }
	};
</script>
<div align="center">
	<table class="easyui-datagrid" id="tab-1"  style="width:1000px;height:500px"  data-options="fitColumns:true, singleSelect:true, onLoadSuccess: onLoadSuccess
" onload="onLoad">   
	    <thead>   
	        <tr  align="center">   
	        	<th data-options="field:'choice',width:250" align="center">选项</th>  
	            <th data-options="field:'code',width:100" align="center">任务名称</th>   
	            <th data-options="field:'price',width:50,align:'center'">立即执行</th>   
	        </tr>   
	    </thead>
	    <tbody align="center" style="border:1;cellpadding:2;cellspacing:1">    
	      	 <tr>   
	      	 	<td>
		        SPU代码:&nbsp&nbsp&nbsp&nbsp&nbsp<input id="spuid" name="spuid" type="text" class="inputbox inputTxtByName" placeholder="SPU代码" width="20px" onChange="querySPUName(this);"/>
		        <input id="spuname" name="spuname" type="text" disabled="true"  width="50px" />
		        </td>
		        <td align="center" rowspan="2">SPU信息推送</td>
	            <td align="center" rowspan="2"><input type="button" value="启动" onclick="pushSPU();" width="50px"></td> 
	        </tr>
	         <tr>   
	      	 	<td>
		        SPU代码:
		        <input id="startSpuid" name="startSpuid" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="inputbox inputTxtByName" placeholder="SPU开始代码" width="20px"/>
		        ---
		        <input id="endSpuid" name="endSpuid" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="inputbox inputTxtByName" placeholder="SPU结束代码" width="20px"/>
		        </td>
	        </tr>
	        <tr>   
		        <td>
		        SKU代码:&nbsp&nbsp&nbsp&nbsp&nbsp<input id="skuid" name="skuid" type="text" class="nputbox inputTxtByName" placeholder="SKU代码" width="20px" onChange="querySKUName(this);"/>
		        <input id="skuname" name="skuname" type="text"   disabled="true"  width="50px"/>
		        </td>
	          	<td align="center" rowspan="2">SKU信息推送</td>
	          	<td align="center" rowspan="2"><input type="button" value="启动" onclick="pushSkU();" width="50px"></td>   
	        </tr> 
	       <tr>   
		        <td>
		        SKU代码:
		        <input id="startSkuid" name="startSkuid" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="nputbox inputTxtByName" placeholder="SKU开始代码" width="20px"/>
		        ---
		        <input id="endSkuid" name="endSkuid" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="nputbox inputTxtByName" placeholder="SKU结束代码" width="20px"/>
		        </td>
	        </tr> 
	         <tr>   
	         	<td>
		        SKU代码:&nbsp&nbsp&nbsp&nbsp&nbsp<input id="skuid2" name="skuid2"  type="text" class="nputbox inputTxtByName" placeholder="SKU代码" width="20px" onChange="querySKUName2(this);"/>
		        <input id="skuname2" name="skuname2" type="text"   disabled="true"  width="50px"/>
		        </td>
	            <td align="center" rowspan="2">商品价格传到微店</td>
	            <td align="center" rowspan="2">
	            	<input type="button" value="启动" onclick="transferPriceToWD();" width="50px"/>
	            </td> 
	        </tr> 
	         <tr>   
	         	<td>
		        销售组织代码:<input id="saleOrgId" name="saleOrgId"  type="text" class="nputbox inputTxtByName" placeholder="销售组织代码" width="20px" onChange="querySaleOrgName(this);"/>
		        <input id="saleOrgName" name="saleOrgName" type="text"   disabled="true"  width="50px"/>
		        </td>
	        </tr> 
	        <tr>   
	        	<td>
		        SKU代码:&nbsp&nbsp&nbsp&nbsp&nbsp<input id="skuid3" name="skuid3"  type="text" class="nputbox inputTxtByName" placeholder="SKU代码" width="20px" onChange="querySKUName3(this);"/>
		        <input id="skuname3" name="skuname3" type="text"   disabled="true"  width="50px"/>
		        </td>
	            <td align="center" rowspan="2">商品佣金传到微店</td>
	            <td align="center" rowspan="2"><input type="button" value="启动" onclick="transferCommissionToWD();" width="50px"></td>   
	        </tr>
	        
	        <tr>   
	        	<td>
		        销售组织代码:<input id="saleOrgId2" name="saleOrgId2"  type="text" class="nputbox inputTxtByName" placeholder="销售组织代码" width="20px" onChange="querySaleOrgName2(this);"/>
		        <input id="saleOrgName2" name="saleOrgName2" type="text"   disabled="true"  width="50px"/>
		        </td>
	        </tr>
	         <tr>   
		        <td>
		                  门店SKU代码:&nbsp&nbsp&nbsp&nbsp&nbsp<input id="skuid4" name="skuid4" type="text" class="nputbox inputTxtByName" placeholder="SKU代码" width="20px" onChange="querySKUName4(this);"/>
		        <input id="skuname4" name="skuname4" type="text"   disabled="true"  width="50px"/>
		        </td>
	          	<td align="center" rowspan="2">门店SKU信息推送</td>
	          	<td align="center" rowspan="2"><input type="button" value="启动" onclick="pushMDSkU();" width="50px"></td>   
	        </tr>
	        <tr>   
		        <td>
		        门店SKU代码:
		        <input id="startSkuid2" name="startSkuid2" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="nputbox inputTxtByName" placeholder="SKU开始代码" width="20px"/>
		        ---
		        <input id="endSkuid2" name="endSkuid2" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="nputbox inputTxtByName" placeholder="SKU结束代码" width="20px"/>
		        </td>
	        </tr>  
	        <tr>
	         	<td>
	         	 请选择:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<select id="hotbox"  name="hotbox" style="width: 132px;"> 
	         	  	<option  selected="selected"></option>     
				    <option value="1" >单据编号</option>   
				    <option value="2" >销售组织代码</option>     
				</select>
				<input id="hotid" name="hotid"  type="text" class="nputbox inputTxtByName"  width="20px" onChange="queryHotSku(this);"/></td>
	            <td align="center">首页热销商品推送</td>
	            <td><input type="button" value="启动" onclick="transferHotSkus();" width="50px"></td>   
	        </tr>
	         <tr>  
	        	<td>
		       		 销售组织代码:<input id="zeroSaleOrgId" name="zeroSaleOrgId"  type="text" class="nputbox inputTxtByName" placeholder="销售组织代码" width="20px" onChange="queryZeroSaleOrgName(this);"/>
		        <input id="zeroSaleOrgName" name="zeroSaleOrgName" type="text"   disabled="true"  width="50px"/>
		        </td>
	            <td align="center">无可卖数量零元购商品推送</td>
	            <td><input type="button" value="启动" onclick="transferFinishZeroProduct();" width="50px"></td>   
	        </tr>
	         <tr>  
	        	<td>
	        		上下架单号:&nbsp&nbsp<input  id="upid" name="upid" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="nputbox inputTxtByName" placeholder="上下架单号" width="20px" onChange="queryUpDown(this);"/>
	        	</td>
	            <td align="center">上下架状态</td>
	            <td><input type="button" value="启动" onclick="transferUpdownStatusToWD();" width="50px"></td>   
	        </tr>
	         <tr>  
	        	<td>
	        		零元购单号:&nbsp&nbsp<input  id="zeroid" name="zeroid" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" type="text" class="nputbox inputTxtByName" placeholder="零元购单号" width="20px"/>
	        	</td>
	            <td align="center">零元购商品推送</td>
	            <td><input type="button" value="启动" onclick="transferZeroProductToWD();" width="50px"></td>   
	        </tr>
	        
	        <tr>   
	         	<td></td>
	            <td align="center">推送后台类目</td>
	            <td><input type="button" value="启动" onclick="pushBackCategories();" width="50px"></td>   
	        </tr>
	         <tr>   
	         	<td></td>
	            <td align="center">推送品牌</td><td><input type="button" value="启动" onclick="pushBrand();" width="50px"></td>   
	        </tr>
	         <tr>   
	         	<td></td>
	            <td align="center">SKU库存状态快照</td>
	            <td><input type="button" value="启动" onclick="transferInventoryToWD();" width="50px"></td>   
	        </tr>
	    </tbody>   
	</table>  
</div>
