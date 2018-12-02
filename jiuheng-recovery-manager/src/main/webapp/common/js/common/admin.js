function myToFocus(fieldName){
   var form=document.forms[0];
   form[''+fieldName+''].focus();

} 
//操作:停用,启用,删除
function actiondo(url){
		document.forms[0].action=url;
		document.forms[0].submit();
}
//刷新页面
function actionreload(){
		window.location.reload(); 
}
//判断是否有节点选中
function isNodeSelected(itemName){
   var num = 0;
  var aa = document.getElementsByName(itemName);
  for (var i=0; i<aa.length; i++){
   if(aa[i].checked){
    return true;
   }
   }
       
   alert("没有选中用户。请先选中用户再进行操作。");
   return false;
  } 


function isNodeSelectedMore(itemName){
  var aa = document.getElementsByName(itemName);
  var flag=0;
  for (var i=0; i<aa.length; i++){
   if(aa[i].checked){
    flag++;
    if(flag>1){
    alert("选中分类数目超过2个。请先选中唯一角色再进行操作。");
    return false;
    }
   }
  }
  
  if(flag==0){
     alert("没有选中角色。请先选中角色再进行操作。");
   return false;
  }else{
  	
    return true;
  }

}





//新增分类
function actionadd(itemName,url){
  var aa = document.getElementsByName(itemName);
  var flag=0;
  for (var i=0; i<aa.length; i++){
   	if(aa[i].checked){
          flag++;
    	  if(flag>=1){
    	    //document.forms[0].action='/privilege/edit.jhtml?fatherId='+aa[i].value;
			//document.forms[0].submit();
			window.location.href='/privilege/edit.jhtml?fatherId='+aa[i].value;
    	  }
   	   }
   	 }
  if(flag==0){
  	if(url==0){
  			url=-1;	
  		}
			window.location.href='/privilege/edit.jhtml?fatherId='+url;
   	}
  }

//编辑角色
function edit(id,name,type,siteId,status){
	  document.getElementById("editid").value=id;
	  YAHOO.util.Connect.setForm('roleeditform', true);
	                YAHOO.util.Connect.asyncRequest('GET', '/role/edit.json?id='+id, {
	                    upload: function(o) {	  
	                        var data = YAHOO.lang.JSON.parse(o.responseText);
	                        var role=data['role'];
 	  						  document.getElementById('description1').value=role.description;
							  document.getElementById("editname").value=role.name; 
							  document.getElementById("roletype").value=role.type;
							  document.getElementById("rolesiteId").value=role.siteId;
							  document.getElementById("status").value=role.status;
			
							  
 						}
	                });
  
}

//移动角色下权限
     function moveNode(){
     		 var treeprivilegeids = document.getElementsByName("treeids");
	         for(var j=0;j<treeprivilegeids.length;j++){
	            var value=treeprivilegeids[j].value;
	            var id=value.substring(0,value.indexOf('&'));
   				var name=value.substring(value.lastIndexOf('&')+1,value.length);  
   				var categoryname = document.getElementById("categoryname"+id).value;
              if(treeprivilegeids[j].checked){
              var flag=false;
      	      //alert("item:"+item);
              //alert("allCount:"+allCount);
              //判断是否有重复记录
               for(var m=0; m<=allCount ;m++){
                   if(document.getElementById("privilegeid"+m)!=null && parseInt(document.getElementById("privilegeid"+m).value)==id){
                      //alert("有重复");
                      flag=true;
                      break;
                   }
               }
               if(flag){continue;}
               
               try{
               var itemnum=parseInt(allCount)+1;
                  //增加记录 
				  addRowPrivilege(id,name,categoryname,itemnum);
               }catch(e){
               }
               
            }
          }
        }
            
    //删除角色权限  
     function delNode(){
     
     	var tab = $("contenttable");
		 //减少一行
        var cbbox ;//说明i=1 从表格第一行数据开始,不包括默认的表头行.
        for(var i=1;i<tab.rows.length;i++){
            cbbox = tab.rows[i].childNodes[0].childNodes[0];//获取input元素
            if(cbbox.checked){               
                tab.deleteRow(i--);
            }
        }
     }
     

//增加控件id
function addRowCount(){
 allCount++;
}

//减小控件id
function delRowCount(){
 if(parseInt(allCount)>0){
  allCount--;
 }
}

var   str="";
//权限选择   
   function   addRowPrivilege(id,name,categoryname,itemnum)   
   {   
   	addRowCount();//合计复选框数量
	//添加一行
	tabdt=document.getElementById('contenttable');
	var newTr = tabdt.insertRow(-1);
	//添加列
	var newidsTd = newTr.insertCell(0);
	newidsTd.innerHTML='<input type="checkbox" checked  name="privilegeids" id="privilegeid'+itemnum+'" value="'+id+'" />';
	
	var newidTd = newTr.insertCell(1);
	newidTd.innerHTML=''+id+'';
	
    var newnameTd = newTr.insertCell(2);
	newnameTd.innerHTML=''+name+'';

    var newsitemapnameTd = newTr.insertCell(3);
	newsitemapnameTd.innerHTML=''+categoryname+'';
	
	document.getElementById('arrlength').value=allCount;
  		
   }


function isadd(){
 	  document.getElementById("editid").value=0;
	  document.getElementById("editname").value='';
	  document.getElementById("roletype").value=0;
 	  document.getElementById("rolesiteId").value=0;
	                
	  return true; 
}

//具有该权限的角色 全选
function selAll(value){
        var items = document.getElementsByName("privilegeids");
        for(var i = 0;i<items.length;i++){
	       items[i].checked = value.checked;
        }
 }

//通过角色ID取得权限信息
function privilege(id,sitemapname,typename){
	  document.getElementById("roleId").value=id;
	  document.getElementById("cnltreemenu1").innerHTML="<table class='sytable' id='contenttable'><tr><th><input type='checkbox' onclick='selAll(checkroleid)' name='checkroleid' /><th>ID</th><th>权限名称</th><th>所属分类</th></tr></table>";
	  
	  document.getElementById("privilegelink").innerHTML="<td>权限：<strong>"+typename+"</strong></td>";
	  
 	  YAHOO.util.Connect.setForm('privilegeform', true);
 	  
	                YAHOO.util.Connect.asyncRequest('GET', '/role/getPrivilegeByRoleId.json', {
	                    upload: function(o) {	  
	                       var data = YAHOO.lang.JSON.parse(o.responseText);
	                       var privilege=data.privilege;
	                       //权限下角色列表
	                       if(privilege.length>0){
	                        var content="<table class='sytable' id='contenttable'><tr><th><input type='checkbox' onclick='selAll(checkroleid)' name='checkroleid' /><th>ID</th><th>权限名称</th><th>所属分类</th></tr>";
								for(i=0;i<privilege.length;i++){
								    addRowCount();//合计复选框数量
									content=content+'<tr><td><input type="checkbox" checked  name="privilegeids" id="privilegeid'+i+'" value="'+privilege[i].id+'" /></td><td>'+privilege[i].id+'</td><td>'+privilege[i].name+'</td><td>'+privilege[i].categoryname+'</td></tr>';																					
								}
								content+"</table>";
							document.getElementById("cnltreemenu1").innerHTML=content;	
	 					   }
	 											        
 						}
	                });
	                            
  
}

//通过权限ID取得权限下的角色信息
function userrole(id,typename,categoryname){
	  document.getElementById("userrolebyprivilegeId").value=id;
	  document.getElementById("userrolecontent").innerHTML="<table width='100%' cellspacing='0' class='sytable' cellpadding='0' id='bbstrry'><tr><th>序号</th><th>姓名</th><th>所属部门</th></tr></table>";	
	  document.getElementById("userrolelink").innerHTML="<td>权限：<strong>"+typename+"</strong>&nbsp;->&nbsp;<strong>"+categoryname+"</strong></td>";
	  
	  YAHOO.util.Connect.setForm('userrolebyprivilegeIdform', true);
	                YAHOO.util.Connect.asyncRequest('GET', '/privilege/loadUserPrivilegeView.json', {
	                    upload: function(o) {	  
	                       var data = YAHOO.lang.JSON.parse(o.responseText);
	                       var userrole=data.userprivilegeview;
	                       //alert(o.responseText); 
	                       if(userrole.length>0){
	                        var userrolecontent="";
								for(i=0;i<userrole.length;i++){
									//alert(role[i].id+" "+role[i].name);
									var num=i+1;
									userrolecontent=userrolecontent+"<tr><td>"+num+"</td><td><a href='#'>"+userrole[i].pin+"</a></td><td>"+userrole[i].sitemapname+"</td></tr>";													
								}
							document.getElementById("userrolecontent").innerHTML="<table width='100%' cellspacing='0' class='sytable' cellpadding='0' id='bbstrry'><tr><th>序号</th><th>姓名</th><th>所属部门</th></tr>"+userrolecontent+"</table>";	
	 							}
 							}
	                });
  
}

var   str="";
//权限选择
  function   Add(ObjSource,ObjTarget){
   str="";   
   for(var   i=ObjSource.length-1;i>=0;i--){
   var obj = ObjSource[i];
   var id=obj.value.indexOf('&');
   var name=obj.value.substring(obj.value.lastIndexOf('&')+1,obj.value.length);   
	 if(obj.checked){  
	  addCheckbox(id,name); 
   
	   }   
  	}
  document.getElementById("rolecontent").innerHTML=str;    
  	   
  }   

  function   addCheckbox(id,name)   
   {   
  		str=str+"<tr><input   title="+name+"   type=checkbox   checked    value="+id+">"+name+"</tr>";
   } 

 //提交验证功能
function validateForm(){

   var name=document.getElementById('editname').value;
   var rolesiteId=document.getElementById('rolesiteId').value;
   var roletype=document.getElementById('roletype').value;
   name=name.replace(/^\s*|\s*$/g,'');
   document.getElementById('editname').value=name;
	if (name==""||name==null){
	  	alert("角色名称不能为空!"); 
     	return false; 
	  }
	//if (rolesiteId<=0){
	//  	alert("请选择站点!"); 
    // 	return false; 
	 // }
   	if (roletype<=0){
	  	alert("请选择类型!"); 
     	return false; 
	  }

	return true;  
} 
  
//列表操作

    function init() {
        var uploader = {
        
           updateprivilegecarry: function() {

				   var items = document.getElementsByName("privilegeids");
				        for(var i = 0;i<items.length;i++){
					       items[i].checked = true;
				    }
	                // set form 更新角色权限表:cms_role_privilege
	                YAHOO.util.Connect.setForm('privilegeform', true);
	                YAHOO.util.Connect.asyncRequest('GET', '/role/privilegesave.json', {
	                    upload: function(o) {
	                        var data = YAHOO.lang.JSON.parse(o.responseText);
							window.location.reload(); 
	                    }
	                });

            }, 
            updatecarry: function() {
				if(validateForm()){
	                // set form
	                YAHOO.util.Connect.setForm('roleeditform', true);
	                YAHOO.util.Connect.asyncRequest('GET', '/role/save.json', {
	                    upload: function(o) {
	                        var data = YAHOO.lang.JSON.parse(o.responseText);
	                        var role=data['role'];
	    					if(role.result==-1){
	    						//showlayer('errrolelayer',3);
	    						alert("提示信息: 名称,站点,类型唯一限制,请重新设置");
	    						return false; 
	    					}
	    					if(role.result==0){
	    						hiddlayer('addadminlayer');
								window.location.reload(); 
							}
	                    }
	                });
	                
			   }
            },          
                        
             deletecarry: function() {

                // set form
                YAHOO.util.Connect.setForm('userqueryform', true);
                YAHOO.util.Connect.asyncRequest('GET', '/user/delece.json', {
                    upload: function(o) {
                        var data = YAHOO.lang.JSON.parse(o.responseText);
    						var user=data['user'];
	    					if(user.result==-1){
	    						var errPannel = document.getElementById("__topmessage");
							      if(!errPannel){
							          errPannel = document.createElement("<div id='__topmessage' class='mytopmessage'>");
							      }
							      var msg = "";
						       msg += "<li  style='width:933px;height:18px;font-size:12px;padding:7px 22px 0 22px;'  onclick=\"myToFocus('nodeall');\">· *该用户拥有权限,不允许删除,请删除完权限后,再进行删除用户操作</li>";
						   	   errPannel.innerHTML = msg;
						       document.body.insertAdjacentElement("afterBegin",errPannel);
						       
	    						//alert("提示信息: 该用户拥有权限,不允许删除,请删除完权限后,再进行删除用户操作");
	    						return false; 
	    					}
	    					if(user.result==-2){
	    					    var errPannel = document.getElementById("__topmessage");
							      if(!errPannel){
							          errPannel = document.createElement("<div id='__topmessage' class='mytopmessage'>");
							      }
							      var msg = "";
						       msg += "<li  style='width:933px;height:18px;font-size:12px;padding:7px 22px 0 22px;'  onclick=\"myToFocus('nodeall');\">· *不允许删除用户自身</li>";
						   	   errPannel.innerHTML = msg;
						       document.body.insertAdjacentElement("afterBegin",errPannel);
       
	    						//alert("提示信息: 不能删除用户本身");
	    						return false; 
	    					}
	    					if(user.result==0){
								//window.location.href="/user/list.jhtml"; 
								window.location.reload(); 
							}
                    }
                });

            }
            
        };

        $('#updateprivilegeclick').click(function(){
        	uploader.updateprivilegecarry();
        });

        $('#updateclick').click(function(){
        	uploader.updatecarry();
        });
    }

