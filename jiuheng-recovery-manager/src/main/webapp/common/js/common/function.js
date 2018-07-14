    // 对Date的扩展，将 Date 转化为指定格式的String   
    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
    // 例子：   
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
    Date.prototype.format = function(fmt)   
    { //author: meizz   
      var o = {   
        "M+" : this.getMonth()+1,                 //月份   
        "d+" : this.getDate(),                    //日   
        "h+" : this.getHours(),                   //小时   
        "m+" : this.getMinutes(),                 //分   
        "s+" : this.getSeconds(),                 //秒   
        "q+" : Math.floor((this.getMonth()+3)/3), //季度   
        "S"  : this.getMilliseconds()             //毫秒   
      };   
      if(/(y+)/.test(fmt))   
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
      for(var k in o)   
        if(new RegExp("("+ k +")").test(fmt))   
      fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
      return fmt;   
    }  
    

    function Date_Ex(value1)
    {
     var strDate = value1+"";
     if (strDate.length == 0)
      return false;

     //先判断是否为短日期格式：YYYY-MM-DD，如果是，将其后面加上00:00:00，转换为YYYY-MM-DD hh:mm:ss格式
     var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})/;   //短日期格式的正则表达式
     var r = strDate.match(reg);

     if (r != null)   //说明strDate是短日期格式，改造成长日期格式
       strDate = strDate + " 00:00:00";

     reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})/;
     r = strDate.match(reg);
     if (r == null)
     {
      //alert("你输入的日期格式有误，正确格式为：2004-12-01 或 2004-12-01 12:23:45");
      return false;
     }

     var d = new Date(r[1], r[3]-1,r[4],r[5],r[6],r[7]);
     if (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]&&d.getHours()==r[5]&&d.getMinutes()==r[6]&&d.getSeconds()== r[7])
     {
      return d;
     }
     else
     {
      //alert("你输入的日期或时间超出有效范围，请仔细检查！");
      return false;
     }
      }
    
    
    function sort(a, b) {
        return a.rank - b.rank;
    }
    
    Array.prototype.contains = function(obj) {
        var i = this.length;
        while (i--) {
            if (this[i] === obj) {
                return true;
            }
        }
        return false;
    }
    

    Array.prototype.getValue = function(id){
        for(var i = 0 ; i < this.length ; i++){
            if(this[i].articleId == id){
                return this[i];
                break;
            }
        }
    }

   Array.prototype.removeValue = function(id){
       for (i = 0; i < this.length; i++) {
           var objId = this[i].articleId;
           if (id  == objId) {

               this.remove(i);

               break;
           }
       }
    }

   //数组删除
   Array.prototype.remove = function(dx) {
       if (isNaN(dx) || dx > this.length) {
           return false;
       }
       for (var i = 0,n = 0; i < this.length; i++)
       {
           if (this[i] != this[dx])
           {
               this[n++] = this[i];
           }
       }
       this.length -= 1;

   }
   
   String.prototype.trim = function() {
	    return this.replace(/(^\s*)|(\s*$)/g, "");
	}
   String.prototype.endWith=function(str){
	   if(str==null||str==""||this.length==0||str.length>this.length)
	     return false;
	   if(this.substring(this.length-str.length)==str)
	     return true;
	   else
	     return false;
	   return true;
	   }

	String.prototype.startWith=function(str){
	   if(str==null||str==""||this.length==0||str.length>this.length)
	     return false;
	   if(this.substr(0,str.length)==str)
	     return true;
	   else
	     return false;
	   return true;
	   } 
	
	$.extend($.fn.validatebox.defaults.rules, {
	    XmlUrl: {
	        validator: function (value, param) {
	        	return /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*|^http:\/\/([^\{\}]*\{[^\{\}]+}){0,}[^\{\}]*$/.test(value);
	        },
	        message: ''
	    }
	});
   
	// extend the 'equals' rule   
	$.extend($.fn.validatebox.defaults.rules, {   
	    equals: {   
	        validator: function(value,param){   
	            return value == $(param[0]).val();   
	        },   
	        message: '输入不一致.'  
	    }   
	}); 
	
//vm模板中要把$.post  merge成.post，所以特殊处理一下 
var ajaxPost = $.post;    
var ajaxMessager = $.messager;
var easyuiParser = $.parser;
    
/**
 * 转换从server端获取到的树形列表数据，以适配easyui的treenode
 */
function convertTreeData(rows) {

	var nodes = [];
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		nodes.push({
			id : row.id, // 这里绑定你的字段
			text : row.name, // 这里绑定你的字段
			state : row.leaves ? "closed" : "open",// 这里绑定你的字段
		});

	}

	return nodes;
}


function generateComboTree(objId,treeUrl,initNodeId,multiSelect,onlyRoot){

	var hasParameter = false;
	
	if(treeUrl.indexOf("?")>0){
		hasParameter = true;
	}
	
	$('#'+objId).combotree({
		url: treeUrl+(hasParameter?"&":"?")+"id="+initNodeId,
		loadFilter: function(data){
			 if (data.treeNodeList){
				 return convertTreeData(data.treeNodeList);	
			 } else {
			 	return data;
			 }
		}, 
		onBeforeExpand:function(node) {
			if(onlyRoot==undefined || onlyRoot==false)
				$('#'+objId).combotree("tree").tree("options").url = treeUrl+(hasParameter?"&":"?")+"id=" + node.id;
			else
				$('#'+objId).combotree("tree").tree("options").url = "";
		},
		multiple:multiSelect
	});
	
}
/**
 * 获取tree所在节点的全路径文本
 * @param objId
 * @param nodeid
 * @returns {String}
 */
function getTreePath(objId,nodeid){

  var t = $('#'+objId).combotree('tree');
  var o=t.tree('find',nodeid);
  if(o!=null){
	  var result=o.text;
	  while(t.tree('getParent',o.target)!=null){
	   o=t.tree('getParent',o.target);
	   result=o.text+'->'+result;
	  }
	  return result;
	}
  else
	  return "none";
 }

function getTreeSelectedNode(objId){

	  var t = $('#'+objId).combotree('tree');
	  var o=t.tree('getSelected');
	  return o;
}

function setClipboard() {
    var clipBoardContent = "";
    var args = arguments;
    if (args.length == 1) {
        clipBoardContent += args[0];
    } else if (args.length == 2) {
        var tmp = "<a href=\"" + args[0] + "\" target=\"_blank\">" + args[1] + "</a>";
        clipBoardContent += tmp;
    }
    if (window.clipboardData) {
        window.clipboardData.clearData();
        window.clipboardData.setData("Text", clipBoardContent);
    } else if (navigator.userAgent.indexOf("Opera") != -1) {
        window.location = clipBoardContent;
    } else if (window.netscape) {
        try {
            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
        } catch (e) {
            alert("您的当前浏览器设置已关闭此功能！请按以下步骤开启此功能！\n新开一个浏览器，在浏览器地址栏输入'about:config'并回车。\n然后找到'signed.applets.codebase_principal_support'项，双击后设置为'true'。\n声明：本功能不会危极您计算机或数据的安全！");
        }
        var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
        if (!clip) return;
        var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
        if (!trans) return;
        trans.addDataFlavor('text/unicode');
        var str = new Object();
        var len = new Object();
        var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
        var copytext = clipBoardContent;
        str.data = copytext;
        trans.setTransferData("text/unicode", str, copytext.length * 2);
        var clipid = Components.interfaces.nsIClipboard;
        if (!clip) return false;
        clip.setData(trans, null, clipid.kGlobalClipboard);
    }

}


//帮助层
function helplayer(sw, obj, they, thex) {
    var sh = (document.getElementById) ? true : false;
    if (sw && sh) {
        document.getElementById(obj).style.top = document.documentElement.scrollTop + they + 'px';
        document.getElementById(obj).style.left = document.documentElement.scrollLeft + thex + 'px';
        document.getElementById(obj).style.display = 'block';
    }
    if (!sw && sh) {
        document.getElementById(obj).style.display = 'none';
    }
}

/*全选*/
function checkAll(e, itemName)
{
    var aa = document.getElementsByName(itemName);
    for (var i = 0; i < aa.length; i++)
        aa[i].checked = e.checked;
}
function checkItem(e, allName)
{
    var all = document.getElementsByName(allName)[0];
    if (!e.checked) all.checked = false;
    else
    {
        var aa = document.getElementsByName(e.name);
        for (var i = 0; i < aa.length; i++)
            if (!aa[i].checked) return;
        all.checked = true;
    }
}

//选项标签
function artnTabs(thisObj, Num) {
    if (thisObj.className == "active")return;
    var tabObj = thisObj.parentNode.id;
    var tabList = document.getElementById(tabObj).getElementsByTagName("dt");
    for (i = 0; i < tabList.length; i++)
    {
        if (i == Num)
        {
            thisObj.className = "active";
            document.getElementById(tabObj + "_artc" + i).style.display = "block";
        } else {
            tabList[i].className = "normal";
            document.getElementById(tabObj + "_artc" + i).style.display = "none";
        }
    }
}

function clearTable(tableId) {
/*    var table = $("#"+tableId);
    table.empty();*/
	if(tableId==undefined)
		tableId="bbstr";
	
	$("#"+tableId+" tr:gt(0)").remove();
}

//去除标题上的html标签
function htmlToText(str) {
    if (str == null)
        return '';
    str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
    str.value = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    return str;
}
function isMaxLen(o) {
    var nMaxLen = o.getAttribute ? parseInt(o.getAttribute("maxlength")) : "";
    if (o.getAttribute && o.value.length > nMaxLen) {
        o.value = o.value.substring(0, nMaxLen)
    }

}
function closeme(info){
	var title = '确定要取消并关闭编辑窗口吗？';
	if(info!=undefined)
		title = info;
	
	ajaxMessager.confirm('确认信息', title, function(r){
		if (r){
			if(window.parent.dialogClosed)
				window.parent.dialogClosed(false);
		}
	});
}

function showSimpleProgress(text){
	
	if(text==null || text==""){
		text = "处理中,请稍候...";
	}
	$.messager.progress({text:text});
}

function closeProgress(){
	$.messager.progress('close');
}

/*树*/
function Ob(o) {
    var o = document.getElementById(o) ? document.getElementById(o) : o;
    return o;
}
function Hd(o) {
    Ob(o).style.display = "none";
}
function Sw(o) {
    Ob(o).style.display = "";
}
function ExCls(o, a, b, n) {
    var o = Ob(o);
    for (i = 0; i < n; i++) {
        o = o.parentNode;
    }
    o.className = o.className == a ? b : a;
}
function CNLTreeMenu(id, TagName0) {
    this.id = id;
    this.TagName0 = TagName0 == "" ? "li" : TagName0;
    this.AllNodes = Ob(this.id).getElementsByTagName(TagName0);
    this.InitCss = function (ClassName0, ClassName1, ClassName2, ImgUrl) {
        this.ClassName0 = ClassName0;
        this.ClassName1 = ClassName1;
        this.ClassName2 = ClassName2;
        this.ImgUrl = ImgUrl || (window.ctx+"/resources/images/s.gif");
        this.ImgBlankA = "<img src=\"" + this.ImgUrl + "\" class=\"s\" onclick=\"ExCls(this,'" + ClassName0 + "','" + ClassName1 + "',1);\" alt=\"展开/折叠\" />";
        this.ImgBlankB = "<img src=\"" + this.ImgUrl + "\" class=\"s\" />";
        for (i = 0; i < this.AllNodes.length; i++) {
            this.AllNodes[i].className == "" ? this.AllNodes[i].className = ClassName1 : "";
            this.AllNodes[i].innerHTML = (this.AllNodes[i].className == ClassName2 ? this.ImgBlankB : this.ImgBlankA) + this.AllNodes[i].innerHTML;
        }
    }
    this.SetNodes = function (n) {
        var sClsName = n == 0 ? this.ClassName0 : this.ClassName1;
        for (i = 0; i < this.AllNodes.length; i++) {
            this.AllNodes[i].className == this.ClassName2 ? "" : this.AllNodes[i].className = sClsName;
        }
    }
}

var GetLength = function (str) {
    ///<summary>获得字符串实际长度，中文2，英文1</summary>
    ///<param name="str">要获得长度的字符串</param>
    var realLength = 0, len = str.length, charCode = -1;
    for (var i = 0; i < len; i++) {
        charCode = str.charCodeAt(i);
        if (charCode >= 0 && charCode <= 128) realLength += 1;
        else realLength += 2;
    }
    return realLength;
};

//js截取字符串，中英文都能用
//如果给定的字符串大于指定长度，截取指定长度返回，否者返回源字符串。
//字符串，长度

/**
 * js截取字符串，中英文都能用
 * @param str：需要截取的字符串
 * @param len: 需要截取的长度
 */
function cutstr(str, len) {
    var str_length = 0;
    var str_len = 0;
    str_cut = new String();
    str_len = str.length;
    for (var i = 0; i < str_len; i++) {
        a = str.charAt(i);
        str_length++;
        if (escape(a).length > 4) {
            //中文字符的长度经编码之后大于4
            str_length++;
        }
        str_cut = str_cut.concat(a);
        if (str_length >= len) {
            str_cut = str_cut.concat("...");
            return str_cut;
        }
    }
    //如果给定字符串小于指定长度，则返回源字符串；
    if (str_length < len) {
        return str;
    }
}