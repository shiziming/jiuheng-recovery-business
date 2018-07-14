<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var win;
	function openWin() {
		win = $.messager.progress({
			title : 'Please waiting',
			msg : 'Loading data...'
		});
	};

	function closeWin() {
		$.messager.progress('close');
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
	
	
	function updateGetAccount(){
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 $.post("schedule/updateGetAccount",
					function(msg){
						 setTimeout(function() {
                               $.messager.progress('close');
                           }, 100);
						if(msg == "success"){
							$.messager.alert('提示:','任务调度成功!');
						}else if(msg=="noBatch"){
							$.messager.alert('提示:','没有最新批次!');
						}else{
							$.messager.alert('提示:','任务出现异常!');
						}
					});
	};
	
	function queryEmployeeName(obj) {
		var employeeId = obj.value;
		if(employeeId==""){
			$('#employeeName').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/queryEmployeeName?employeeId=' + employeeId,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#employeeName').val(result[0].employeeName);
					}else{
						alert("该员工不存在！");
						$('#employeeName').val("");
					}
			}
		});
		}
	};
	
	function queryAddressName(obj) {
		var addressId = obj.value;
		if(addressId==""){
			$('#addressName').val("");
		}else{
			$.ajax({
			type : "POST",
			url : 'schedule/queryAddressName?addressId=' + addressId,
			dataType : "json",
			contentType : "application/json",
			success:function(result){
					//增加非空判断
					if(result != null&&result!=""){
						$('#addressName').val(result[0].addressName);
					}else{
						alert("该地址不存在！");
						$('#addressName').val("");
					}
			}
		});
		}
	};
	
	function transforBranchMsg(){
		var saleOrgId = $('#saleOrgId').attr("value");
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 $.post("schedule/transforBranchMsg?saleOrgCode="+saleOrgId,
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
	

	
	
	function pushAddresses(){
		var addressId = $('#addressId').attr("value");
		 $.messager.progress({
           title: '请稍候',
           msg: '任务调度中...'
       	});
		 $.post("schedule/pushAddresses?addressId="+addressId,
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
	

	
	function syncOrganizationUser(){
		 $.messager.progress({
	           title: '请稍候',
	           msg: '任务调度中...'
	       });
			 $.post("schedule/syncOrganizationUser",
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
	}
	
	
	function pushBranchAddresses(){
		 $.messager.progress({
	           title: '请稍候',
	           msg: '任务调度中...'
	       });
			 $.post("schedule/pushBranchAddresses",
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
	}
	
	function pushBranchEmployees(){
		var employeeId = $('#employeeId').attr("value");
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 $.post("schedule/pushBranchEmployees?employeeId=" + employeeId,
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
	}
	
	function pushOrgAddress(){
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 $.post("schedule/pushOrgAddress",
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
	}
	
	function pushStores(){
		 $.messager.progress({
            title: '请稍候',
            msg: '任务调度中...'
        });
		 $.post("schedule/pushStores",
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
	}
	
</script>
<div align="center">
	<table class="easyui-datagrid" style="width:800px;height:250px"  data-options="fitColumns:true, singleSelect:true">   
	    <thead>   
	        <tr  align="center">   
	           <th data-options="field:'choice',width:250" align="center">选项</th>  
	            <th data-options="field:'code',width:100" align="center">任务名称</th>   
	            <th data-options="field:'price',width:50,align:'center'">立即执行</th>   
	        </tr>   
	    </thead>
	    <tbody align="center">    
	        <tr>   
	        	<td>
		      	  销售组织代码:<input id="saleOrgId" name="saleOrgId"  type="text" class="inputbox inputTxtByName" placeholder="销售组织代码" width="20px" onChange="querySaleOrgName(this);"/>
		        <input id="saleOrgName" name="saleOrgName" type="text" disabled="true"  width="50px" />
		        </td>
	            <td align="center">微店分部信息推送</td>
	            <td><input type="button" value="启动" onclick="transforBranchMsg();" width="50px"></td>   
	        </tr>
	         <tr>
	        	 <td>
		      	 员工代码:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input id="employeeId" name="employeeId" type="text" class="inputbox inputTxtByName" placeholder="员工代码" width="20px" onChange="queryEmployeeName(this);"/>
		        <input id="employeeName" name="employeeName" type="text" disabled="true"  width="50px" />
		        </td>   
	            <td align="center">员工及其所属销售组织</td>
	            <td><input type="button" value="启动" onclick="pushBranchEmployees();" width="50px"></td>   
	        </tr>
	         <tr>   
	         	<td>
		      	 地址代码:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input id="addressId" name="addressId"  type="text" class="inputbox inputTxtByName" placeholder="地址代码" width="20px" onChange="queryAddressName(this);"/>
		        <input id="addressName" name="addressName" type="text" disabled="true"  width="50px" />
		        </td> 
	            <td align="center">物流地址信息推送</td><td><input type="button" value="启动" onclick="pushAddresses();" width="50px"></td>   
	        </tr>
	         <tr>   
	         <td></td>
	            <td align="center">同步用户信息</td>
	            <td><input type="button" value="启动" onclick="updateGetAccount();" width="50px"></td> 
	        </tr> 
	         <tr>   
	         <td></td>
	            <td align="center">物流收货地址与销售组织的对照</td>
	            <td><input type="button" value="启动" onclick="pushBranchAddresses();" width="50px"></td>   
	        </tr>
	        <tr>   
	        <td></td>
	            <td align="center">同步管理机构信息</td>
	            <td><input type="button" value="启动" onclick="syncOrganizationUser();" width="50px"></td>  
	        </tr>
	        <tr>   
	        <td></td>
	            <td align="center">推送三级地址到微店</td>
	            <td><input type="button" value="启动" onclick="pushOrgAddress();" width="50px"></td>  
	        </tr>
	        <tr>   
	        <td></td>
	            <td align="center">推送门店信息到微店</td>
	            <td><input type="button" value="启动" onclick="pushStores();" width="50px"></td>  
	        </tr>
	    </tbody>   
	</table>  
</div>
