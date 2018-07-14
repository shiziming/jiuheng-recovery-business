    // ��Date����չ���� Date ת��Ϊָ����ʽ��String   
    // ��(M)����(d)��Сʱ(h)����(m)����(s)������(q) ������ 1-2 ��ռλ����   
    // ��(y)������ 1-4 ��ռλ��������(S)ֻ���� 1 ��ռλ��(�� 1-3 λ������)   
    // ���ӣ�   
    // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
    // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
    Date.prototype.format = function(fmt)   
    { //author: meizz   
      var o = {   
        "M+" : this.getMonth()+1,                 //�·�   
        "d+" : this.getDate(),                    //��   
        "h+" : this.getHours(),                   //Сʱ   
        "m+" : this.getMinutes(),                 //��   
        "s+" : this.getSeconds(),                 //��   
        "q+" : Math.floor((this.getMonth()+3)/3), //����   
        "S"  : this.getMilliseconds()             //����   
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

     //���ж��Ƿ�Ϊ�����ڸ�ʽ��YYYY-MM-DD������ǣ�����������00:00:00��ת��ΪYYYY-MM-DD hh:mm:ss��ʽ
     var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})/;   //�����ڸ�ʽ��������ʽ
     var r = strDate.match(reg);

     if (r != null)   //˵��strDate�Ƕ����ڸ�ʽ������ɳ����ڸ�ʽ
       strDate = strDate + " 00:00:00";

     reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})/;
     r = strDate.match(reg);
     if (r == null)
     {
      //alert("����������ڸ�ʽ������ȷ��ʽΪ��2004-12-01 �� 2004-12-01 12:23:45");
      return false;
     }

     var d = new Date(r[1], r[3]-1,r[4],r[5],r[6],r[7]);
     if (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]&&d.getHours()==r[5]&&d.getMinutes()==r[6]&&d.getSeconds()== r[7])
     {
      return d;
     }
     else
     {
      //alert("����������ڻ�ʱ�䳬����Ч��Χ������ϸ��飡");
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

   //����ɾ��
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
	        message: '���벻һ��.'  
	    }   
	}); 
	
//vmģ����Ҫ��$.post  merge��.post���������⴦��һ�� 
var ajaxPost = $.post;    
var ajaxMessager = $.messager;
var easyuiParser = $.parser;
    
/**
 * ת����server�˻�ȡ���������б����ݣ�������easyui��treenode
 */
function convertTreeData(rows) {

	var nodes = [];
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		nodes.push({
			id : row.id, // ���������ֶ�
			text : row.name, // ���������ֶ�
			state : row.leaves ? "closed" : "open",// ���������ֶ�
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
 * ��ȡtree���ڽڵ��ȫ·���ı�
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
            alert("���ĵ�ǰ����������ѹرմ˹��ܣ��밴���²��迪���˹��ܣ�\n�¿�һ������������������ַ������'about:config'���س���\nȻ���ҵ�'signed.applets.codebase_principal_support'�˫��������Ϊ'true'��\n�����������ܲ���Σ��������������ݵİ�ȫ��");
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


//������
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

/*ȫѡ*/
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

//ѡ���ǩ
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

//ȥ�������ϵ�html��ǩ
function htmlToText(str) {
    if (str == null)
        return '';
    str = str.replace(/<\/?[^>]*>/g, ''); //ȥ��HTML tag
    str.value = str.replace(/[ | ]*\n/g, '\n'); //ȥ����β�հ�
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //ȥ���������
    return str;
}
function isMaxLen(o) {
    var nMaxLen = o.getAttribute ? parseInt(o.getAttribute("maxlength")) : "";
    if (o.getAttribute && o.value.length > nMaxLen) {
        o.value = o.value.substring(0, nMaxLen)
    }

}
function closeme(info){
	var title = 'ȷ��Ҫȡ�����رձ༭������';
	if(info!=undefined)
		title = info;
	
	ajaxMessager.confirm('ȷ����Ϣ', title, function(r){
		if (r){
			if(window.parent.dialogClosed)
				window.parent.dialogClosed(false);
		}
	});
}

function showSimpleProgress(text){
	
	if(text==null || text==""){
		text = "������,���Ժ�...";
	}
	$.messager.progress({text:text});
}

function closeProgress(){
	$.messager.progress('close');
}

/*��*/
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
        this.ImgBlankA = "<img src=\"" + this.ImgUrl + "\" class=\"s\" onclick=\"ExCls(this,'" + ClassName0 + "','" + ClassName1 + "',1);\" alt=\"չ��/�۵�\" />";
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
    ///<summary>����ַ���ʵ�ʳ��ȣ�����2��Ӣ��1</summary>
    ///<param name="str">Ҫ��ó��ȵ��ַ���</param>
    var realLength = 0, len = str.length, charCode = -1;
    for (var i = 0; i < len; i++) {
        charCode = str.charCodeAt(i);
        if (charCode >= 0 && charCode <= 128) realLength += 1;
        else realLength += 2;
    }
    return realLength;
};

//js��ȡ�ַ�������Ӣ�Ķ�����
//����������ַ�������ָ�����ȣ���ȡָ�����ȷ��أ����߷���Դ�ַ�����
//�ַ���������

/**
 * js��ȡ�ַ�������Ӣ�Ķ�����
 * @param str����Ҫ��ȡ���ַ���
 * @param len: ��Ҫ��ȡ�ĳ���
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
            //�����ַ��ĳ��Ⱦ�����֮�����4
            str_length++;
        }
        str_cut = str_cut.concat(a);
        if (str_length >= len) {
            str_cut = str_cut.concat("...");
            return str_cut;
        }
    }
    //��������ַ���С��ָ�����ȣ��򷵻�Դ�ַ�����
    if (str_length < len) {
        return str;
    }
}