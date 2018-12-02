(function(jQuery) {
	var onlyOpenTitle = "首页";
	var o2m = {};
	var curMenu = null;
	var zTree_Menu = null;
	
	this.logout = function(){
		window.location.href="power/toLogin";
	}

	this.init = function(){
		var setting = {
			view: {
				showLine: false,
				selectedMulti: false,
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: this.beforeTreeNodeClick,
				onClick : this.onTreeNodeClick
			}
		};

		var zNodes;
		var url = "login/getPositionRoleMenuTree?cs="
				+ Math.random();
//		var url = "demo/menu.json";
		$.getJSON(url, function(data) {
			if (data) {
				zNodes = data;
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				zTree_Menu = $.fn.zTree.getZTreeObj("treeDemo");
		        if (zTree_Menu.getNodes()[0] != undefined) {
		        	curMenu = zTree_Menu.getNodes()[0].children[0];
					zTree_Menu.expandNode(zTree_Menu.getNodes()[0]);
				}
			}
		});
		
		tabClose();
		tabCloseEven(); 
		this.centerHeight = $('#tabs .tabs-panels').height();
		
	};
	
	
	this.onTreeNodeClick = function(event, treeId, treeNode, clickFlag) {
		if (treeNode.isParent)
			return;
		
		var menu = treeNode.name;
		if ($('#tabs').tabs('exists', menu)) {
			$('#tabs').tabs('select', menu);
		} else {
			$('#tabs').tabs('add', {
				title : menu,
				content:"<div class='easyui-panel' href='"+treeNode.lnkUrl+"' border='false'  " +
						" style='overflow: hidden;'></div>",
				closable : true
			});
			tabClose();
		}
	}

	this.beforeTreeNodeClick = function(treeId, node) {
		if (node.isParent) {
			if (node.level === 0) {
				var pNode = curMenu;
				while (pNode && pNode.level !== 0) {
					pNode = pNode.getParentNode();
				}
				if (pNode !== node) {
					var a = $("#" + pNode.tId + "_a");
					a.removeClass("cur");
					zTree_Menu.expandNode(pNode, false);
				}
				a = $("#" + node.tId + "_a");
				a.addClass("cur");

				var isOpen = false;
				for (var i = 0, l = node.children.length; i < l; i++) {
					if (node.children[i].open) {
						isOpen = true;
						break;
					}
				}
				if (isOpen) {
					zTree_Menu.expandNode(node, true);
					curMenu = node;
				} else {
					zTree_Menu
							.expandNode(
									node.children[0].isParent ? node.children[0]
											: node, true);
					curMenu = node.children[0];
				}
			} else {
				zTree_Menu.expandNode(node);
			}
		}
		return !node.isParent;
	};
	
	
	 /**
	 * 打开放大镜窗口页面
	 * @param winId		窗口DIV的ID	
	 * @returns 
	 */
	this.openMagnifierWindow = function(title, icon, width, height, linkUrl) {
		$('#magnifier_window').window({
			title: title,
			iconCls: icon,
		    width: width,
		    height: height,
		    modal:true,
		    collapsible: false,
		    minimizable: false,
		    maximizable: false,
		    resizable: false,
		    href: linkUrl,

		    onClose:function(){
		    	$('#magnifier_window').window('destroy');
		    	$("body").append(" <div id = 'magnifier_window' ></div>");
		    }
		});
	};
	this.addTimeStampToImageUrl =  function(url){
		 var getTimestamp = new Date().getTime();  
	     return url+"?timestamp="+getTimestamp;  
	}
	
	function tabClose()
	{
		/*双击关闭TAB选项卡*/
		$("#tabs .tabs-inner").dblclick(function(){
			var subtitle = $(this).children(".tabs-closable").text();
			$('#tabs').tabs('close',subtitle);
		});
		/*为选项卡绑定右键*/
		$("#tabs .tabs-inner").bind('contextmenu',function(e){
			
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});

			var subtitle =$(this).children(".tabs-closable").text();

			$('#mm').data("currtab",subtitle);
			$('#tabs').tabs('select',subtitle);
			return false;
		});
	}
	
	//绑定右键菜单事件
	function tabCloseEven() {

	    $('#mm').menu({
	        onClick: function (item) {
	            closeTab(item.id);
	        }
	    });

	    return false;
	}

	function closeTab(action)
	{
	    var alltabs = $('#tabs').tabs('tabs');
	    var currentTab =$('#tabs').tabs('getSelected');
		var allTabtitle = [];
		$.each(alltabs,function(i,n){
			allTabtitle.push($(n).panel('options').title);
		});

		
	    switch (action) {
	        case "tabupdate":
	        	var panel = currentTab.find('.easyui-panel');
	        	var herf = panel.attr('href');
	            $('#tabs').tabs('update', {
	                tab: currentTab,
	                options: {
	                    content: "<div class='easyui-panel' href='"+herf+"' border='false'  " +
						" style=' overflow: hidden;'></div>"
	                }
	            });
	            break;
	        case "close":
	            var currtab_title = currentTab.panel('options').title;
	            $('#tabs').tabs('close', currtab_title);
	            break;
	        case "closeall":
	            $.each(allTabtitle, function (i, n) {
	                if (n != onlyOpenTitle){
	                    $('#tabs').tabs('close', n);
					}
	            });
	            break;
	        case "closeother":
	            var currtab_title = currentTab.panel('options').title;
	            $.each(allTabtitle, function (i, n) {
	                if (n != currtab_title && n != onlyOpenTitle)
					{
	                    $('#tabs').tabs('close', n);
					}
	            });
	            break;
	        case "closeright":
	            var tabIndex = $('#tabs').tabs('getTabIndex', currentTab);

	            if (tabIndex == alltabs.length - 1){
	                return false;
	            }
	            $.each(allTabtitle, function (i, n) {
	                if (i > tabIndex) {
	                    if (n != onlyOpenTitle){
	                        $('#tabs').tabs('close', n);
						}
	                }
	            });

	            break;
	        case "closeleft":
	            var tabIndex = $('#tabs').tabs('getTabIndex', currentTab);
	            if (tabIndex == 1) {
	                return false;
	            }
	            $.each(allTabtitle, function (i, n) {
	                if (i < tabIndex) {
	                    if (n != onlyOpenTitle){
	                        $('#tabs').tabs('close', n);
						}
	                }
	            });
	            $('#tabs').tabs('select',allTabtitle[allTabtitle.length-1]);

	            break;
	    }
	}
	
	/**
	 * 处理服务器端返回的处理结果 服务器端返回的数据结构为:ActionResult
	 * 
	 * @param result
	 *            ActionResult
	 * @returns {Boolean} 如果是未登录，则返回false,其它返回true
	 */
	this.handleActionResult = function(result) {
		// 0-成功, 1-失败, 2-无权限, 3-未登录或Session过期, 4-超时
		if (result.code == 0) {
			$.messager.show({
				title : '操作成功',
				msg : result.msg,
				showType : 'slide',
				timeout : 1500,
				style : {
					right : '',
					top : document.body.scrollTop
							+ document.documentElement.scrollTop,
					bottom : ''
				}
			});
		} else if (result.code == 1) {
			$.messager.alert('操作失败', result.msg, 'info');
		} else if (result.code == 2) {
			$.messager.alert('操作失败', result.msg, 'warning');
		} else if (result.code == 4) {
			$.messager.alert('操作超时', result.msg, 'warning');
		} else if (result.code == 3) {
			$.messager.alert('操作失败', "您还没有登录或长时间没有操作，2秒中后将跳转到登录页面", 'question');
			setTimeout(function() {
				window.location = "/login.do";
			}, 2000);
		}
		return (result.code == 0);
	};
	
	/**
	 * 判断是否为空字符串
	 */
	this.isEmpty = function(data) {
		if(data==undefined){
			return true;
		}
		if(data=="undefined"){
			return true;
		}
		if(data==null){
			return true;
		}
		if(data==''){
			return true;
		}
		if(data==""){
			return true;
		}
		
	};
	this.replaceNotNum = function(input){
		$(input).val($(input).val().replace(/[^0-9]*/g,""));
	};

	this.serializeObject = function(form) {
		var o = {};
		$.each(form.serializeArray(), function(index) {
			if (this['value'] != '') {
				if (o[this['name']]) {
					o[this['name']] = o[this['name']] + "," + this['value'];
				} else {
					o[this['name']] = this['value'];
				}
			}
		});
		return o;
	};

	this.showProgressing = function() {
		$.messager.progress({
			title : '请稍候',
			msg : '数据加载...',
			text : '加载中.......',
			interval : 100,
			closed : false
		});
	};

	this.closeProgressing = function() {
		$.messager.progress('close');
	};
	
	
	
	this.getCategroyChildren = function(pid){
		var arr = [];
		$.ajax({
	        type:"post",  
	        url:"backCategories/children?pid="+pid,
	        method : 'post',
	        async : false,
	        success : function(data){
	        	$.each($.parseJSON(data),function(i,n){
	        		var obj = {};
	        		obj.pid = n.pid;
	        		obj.id = n.code;
	        		obj.text = n.code +"_"+n.name;
	        		if(n.level < 3){
	        			obj.state = "closed";
	        			obj.children = [];
	        		}else{
	        		}
	        		arr.push(obj);
	        	});
	        }
		});
		return arr;
	}
	this.getSecondCategroyChildren = function(pid){
		var arr = [];
		$.ajax({
	        type:"post",  
	        url:"backCategories/children?pid="+pid,
	        method : 'post',
	        async : false,
	        success : function(data){
	        	$.each($.parseJSON(data),function(i,n){
	        		var obj = {};
	        		obj.pid = n.pid;
	        		obj.id = n.code;
	        		obj.text = n.code +"_"+n.name;
	        		if(n.level < 2){
	        			obj.state = "closed";
	        			obj.children = [];
	        		}else{
	        		}
	        		arr.push(obj);
	        	});
	        }
		});
		return arr;
	}

	this.addTabIframe = function(url, title) {
		if ($('#tabs').tabs('exists', title)) {
			$('#tabs').tabs('select', title);
		} else {
			$('#tabs').tabs('add', {
				title : title,
				content:"<div class='easyui-panel' href='"+url+"' border='false'  " +
				" style='overflow: hidden;'></div>",
				closable : true
			});
			tabClose();
		}
	}

	jQuery.o2m = this;
	return jQuery;
})(jQuery);

$(function(){  
	// 注册Ajax默认设置
	$.ajaxSetup({ cache: false });
	// 注册Ajax请求错误默认处理函数
	$(document).ajaxError(function(event, jqxhr, settings, thrownError) {
		if (jqxhr.status == 401) {
			$.messager.alert('登录超时', "您长时间没有操作，2秒中后将自动跳转到登录页面！", 'question');
			setTimeout(function(){
				window.location.href = "login";
			}, 2000);
		}else if(jqxhr.status == 500){
			$.messager.alert('服务器异常', "系统出了点小小问题，请稍后重试！", 'question');
		}
	});
	
	$.o2m.showProgressing();
	//初始化首页面
	$.o2m.init(); 
	
	$.o2m.closeProgressing();

	$.o2m.closeProgressing();
});