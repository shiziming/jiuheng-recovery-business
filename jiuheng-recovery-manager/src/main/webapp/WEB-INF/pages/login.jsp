<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/header.jsp"%>
<%@ include file="inc/resource.inc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>久恒回收管理系统</title>
<script src="${ctx}/js/placeholder.js"></script>
<link rel="stylesheet" type="text/css" href="css/backstagelogin.css">

</head>x`

<body>
	<div style="background-image: url(images/user/background.jpg)" class="pagebg"></div>
	<div class="loginbtn">
		<a></a>
	</div>
	<div class="login" style="display: none;">
		<div class="logindiv">
			<form id="baseForm" name="baseForm" method="post">
				<input type="hidden" name="indexRandomCode" class="textbox" value="3456"></input>
				<input type="hidden" name="needRandomCode" class="textbox" value="0"></input>
				<div class="loginbox">
					<ul>
						<li id="error_info" style="color: red;margin-bottom: 2px;height: 15px;font-size: 14px"></li>
						<li><input id="indexLoginId" name="indexLoginId" type="text" class="inputbox inputTxtByName" placeholder="用户名"/></li>
						<li>
							<input id="pwd" name="pwd" type="text" class="inputbox inputTxtByPwd" placeholder="密码" />
							<input id="indexLoginPwd" name="indexLoginPwd" type="password" class="inputbox inputTxtByPwd" placeholder="密码" style="display:none;"/>
						</li>
						<li><input type="button" value="立即登录" class="loginsubmit" onclick="loginSubmit();" /></li>
					</ul>
				</div>
			</form>
		</div>
	</div>

	<div class="footer">
		<label>久恒股份有限公司</label>
	</div>
	
	<div style="display: none; height: 0px;">
		<a id="baseHref" href="" target="hiddenFrame"></a>
		<iframe name="hiddenFrame" id="hiddenFrame" style="display: none;"/></iframe>
	</div>
	<div id="newPwdWin" class="easyui-window" title="首次登录，请修改原始密码" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;font-size: 16px;">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>用户名:</td>
	    			<td><input class="easyui-validatebox textbox" id="modifyPwdName" type="text" name="name" disabled="disabled"></input></td>
	    		</tr>
	    		<tr>
	    			<td>新密码<span style="color:red">(*)</span>:</td>
	    			<td><input class="easyui-validatebox textbox  text pwd" type="password" name="newPwd" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>新密码确认<span style="color:red">(*)</span>:</td>
	    			<td><input class="easyui-validatebox textbox  text pwd" type="password" name="newPwd" ></input></td>
	    		</tr>
	    	</table>
	    	
	    		<div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">确认</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#newPwdWin').window('close')">取消</a>
	   			</div>
	</div>

<script type="text/javascript">
    var animation = {//动画部分 从jQuery剥离
        "swing": function (p) {
            return 0.5 - Math.cos(p * Math.PI) / 2;
        },
        "chang": 200,
        "rate": 25
    };
    
    var flag = 1;
   
    
    $(".login").bind("click", function (event) {
        if (window.event) {
            window.event.cancelBubble = true;
        } else {
            event.stopPropagation();
        }
    });
    $(".loginbtn").bind("click", function (event) {
    	if (flag == -1)$(".pagebg").click();
    	
        if (flag == 1) {
            flag = 0;
            if (window.event) {
                window.event.cancelBubble = true;
            } else {
                event.stopPropagation();
            }
            event.stopPropagation();
            var _conts = 141;
            var h = $(this).height();
            var t = $(this).position().top;
            var ml = $(this).css("margin-top").replace("px", "") * 1;
            var _logTop = t + ml + h + 60;
            $(".login").css("top", _logTop);
            var _logHeight = $(window).height() - _logTop + _conts;
            $(".login").height(0);
            $(".login").css("display", "");
            $(".login").css("overflow", "hidden");
            var end = animation.chang;
            var start = 0;
            var cur = 0;
            var step = animation.rate;
            //$(".login").fadeIn(step);
            var timer = setInterval(function () {
                cur += step;
                var ant = animation.swing(cur / (end - start)) * _conts;
                var anh = animation.swing(cur / (end - start)) * _logHeight;
                var __top = t - ant;
                var __logTop = _logTop - ant;
                $(".loginbtn").css("top", __top + "px");
                $(".login").css("top", __logTop + "px");
                $(".login").height(anh);
                if (cur == end) {
                    clearInterval(timer);
                    $(".login").css("overflow", "");
                    $(".login").css("top", "");
                    flag = -1;
                }
            }, step);
        }
    });
    
    $(function() {
    	//特殊处理type是password的情况，以支持placeholder属性
		var pwd = $("#pwd");
		var password = $("#indexLoginPwd");
		pwd.focus(function() {
			pwd.hide();
			password.show().focus();
		});
		password.focusout(function() {
			if (password.val() == "") {
				password.hide();
				pwd.show();
			}
		});

		$(".combo-text").css("width", "266px");
		$(".combo").css("width", "300px");
		$(".combo-arrow").css("width", "35px");
		//初始宽度和高度
		$('#positionId').combobox({
			width : 300,
			height : 40
		});
	});

	function loginSubmit() {
		var browserFlag = true;
		var userAgent = navigator.userAgent.toLowerCase(), s, o = {};
		var browser = {
			version : (userAgent
					.match(/(?:firefox|opera|safari|chrome|msie|rv)[\/: ]([\d.]+)/))[1],
			safari : /version.+safari/.test(userAgent),
			chrome : /chrome/.test(userAgent),
			firefox : /firefox/.test(userAgent),
			ie : /msie/.test(userAgent),
			opera : /opera/.test(userAgent)
		}; /* 获得浏览器的名称及版本信息 */

		if (browserFlag) {
			//默认把提示短语提交的校验
			if($("#indexLoginId").val()=='用户名'){
				$("#indexLoginId").val("");
			}
			if($("#indexVerificationcode").val()=='验证码'){
				$("#indexVerificationcode").val("");
			}
			$.post("${ctx}/login/login", $('#baseForm').serialize(), function(msg) {
				if ($.parseJSON(msg).flag == "loginIdNull") {
					$('#error_info').html('用户名为空!');
				} else if ($.parseJSON(msg).flag == "loginPwdNull") {
					$('#error_info').html('密码为空!');
				} else if ($.parseJSON(msg).flag == "positionNull") {
					$('#error_info').html('岗位为空!');
				} else if ($.parseJSON(msg).flag == "userNull") {
					$('#error_info').html('用户名不存在!');
				} else if ($.parseJSON(msg).flag == "loginPwdError") {
					$('#error_info').html('密码输入错误!');
				} else if ($.parseJSON(msg).flag == "loginDimission") {
					$('#error_info').html('该用户已离职!');
				} else if ($.parseJSON(msg).flag == "loginLock") {
					$('#error_info').html('该账户已被停用,无法登陆系统!');
				}  else if($.parseJSON(msg).flag == "needModifyPass") {
					$('#error_info').html('密码已经过期!');
				}  else if($.parseJSON(msg).flag == "haveNoFun"){
					$('#error_info').html('该职务没有权限!');
				}else if ($.parseJSON(msg).flag == "success") {
					window.location.href = "${ctx}/index";
					
				}
			});
		}
	};

	if (window.top != window) {
		if (window.top.opener) {
			window.top.opener.document.location.href = window.location.href;
		} else {
			window.top.location = window.location;
		}
	};

	document.onkeydown = function(evt) {
		var evt = window.event ? window.event : evt;
		if (evt.keyCode == 13) {
			loginSubmit();
		}
	};

	$(".pagebg").bind("click", function() {
		if (flag == -1) {
			flag = 0;
			var _conts = 141;
			var h = $(".loginbtn").height();
			var t = $(".loginbtn").position().top;
			var ml = $(".loginbtn").css("margin-top").replace("px", "") * 1;
			var _logTop = t + ml + h + 60;
			$(".login").css("top", _logTop);
			var _logHeight = $(".login").height();
			$(".login").css("display", "");
			$(".login").css("overflow", "hidden");
			var end = animation.chang;
			var start = 0;
			var cur = 0;
			var step = animation.rate;
			var timer = setInterval(function() {
				cur += step;
				var ant = animation.swing(cur / (end - start)) * _conts;
				var anh = animation.swing(cur / (end - start)) * _logHeight;
				var __top = t + ant;
				var __logTop = _logTop + ant;
				$(".loginbtn").css("top", __top + "px");
				$(".login").css("top", __logTop + "px");
				$(".login").height(_logHeight - anh);
				if (cur == end) {
					clearInterval(timer);
					$(".login").css("height", "");
					$(".login").css("display", "none");
					$(".login").css("overflow", "");
					$(".login").css("top", "");
					flag = 1;
				}
			}, step);
		}
	});

	function submitForm(){
	     var flag = true;
	      $(".easyui-validatebox").each(function(i, n) {
	          if ("" == n.value) {
	              flag = false;
	          }
	      });

	      if (!flag) {
	    	  $.messager.alert('消息提示',"表单数值不能为空",'error'); 
	      } else {
	  		var arr = $("input[name='newPwd']");
			if(arr[0].value != arr[1].value){
			 	$.messager.alert('消息提示',"两次密码输入不一致",'error');
			}else if(arr[0].value=="123"){
			 	$.messager.alert('消息提示',"新密码不能与原密码相同",'error');
			}else{
				$.ajax({
		            type: "POST",
		            data : {
		            	name:$("input[name='name']").eq(0).val(),
		            	newPwd:$("input[name='newPwd']").eq(0).val()
		            },
		            url:ctx+"/alterUserInitPwd",
					error : function(request) {
						$.messager.alert('消息提示',"发送请求错误!",'error');
					},
					success : function(msg) {
						if ($.parseJSON(msg).flag == "newPwdNull") {
                           $.messager.alert('提示:', '新密码为空!');
                       } else if ($.parseJSON(msg).flag == "accountNull") {
		                    $.messager.alert('提示:', '账号不存在!');
		                } else if ($.parseJSON(msg).flag == "success") {
		                	$('#newPwdWin').window('close');
		                	$.messager.alert('提示:', '修改成功!');
		                }
					}
				});
			};
	      };
	};
	
</script>
</body>
</html>