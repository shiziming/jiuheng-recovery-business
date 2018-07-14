
/**
 * [checkpassword 校验密码是否符合规则，最低长度不能低于十位且必须包含数字字母及特殊字符] 
 * @param  String password 
 * @return boolean        
 */
function checkpassword(password){
	if (/^(?![a-zA-Z0-9]+$)(?![^a-zA-Z/D]+$).{10,20}$/.test(password)) {
		return true;
	}else{
		return false;
	}
}



/**
 * 校验输入字符串是否全为空格
 * @param  String str
 * @return boolean
 */
function checkspace(str){
	if(/^[^\s].*[^\s]$/.test(str)){
		return true;
	}else{
		return false;
	}
}

/**
 * 校验手机号是否输入正确
 * @param  number number
 * @return boolean
 */
function checkphonenumber(number){
	if(/^(((1[3|8][0-9])|(14[5|7])|(15[^4,\D])|(17[6|7|8]))\d{8}|(170[0|5|9])\d{7})$/.test(number)){
		return true;
	}else{
		return false;
	}
}

/**
 * emoji过滤
 * @param  {[type]} emoji [description]
 * @return {[type]}       [description]
 */
function filteremoji(emoji){
    var ranges = [
        '\ud83c[\udf00-\udfff]',
        '\ud83d[\udc00-\ude4f]',
        '\ud83d[\ude80-\udeff]'
    ];
    emoji = emoji .replace(new RegExp(ranges.join('|'), 'g'), '');
    return emoji;
}

/**
 * 银行卡号Luhm校验
 * @param  number bankno
 * @return boolean
 * Luhm校验规则：16位银行卡号（19位通用）:
 * 1.将未带校验位的 15（或18）位卡号从右依次编号 1 到 15（18），位于奇数位号上的数字乘以 2。
 * 2.将奇位乘积的个十位全部相加，再加上所有偶数位上的数字。
 * 3.将加法和加上校验位能被 10 整除。
 */
function luhmCheck(bankno){
    if (bankno.length < 16 || bankno.length > 19) {
        //$("#banknoInfo").html("银行卡号长度必须在16到19之间");
        return false;
    }
    var num = /^\d*$/;  //全数字
    if (!num.exec(bankno)) {
        //$("#banknoInfo").html("银行卡号必须全为数字");
        return false;
    }
    //开头6位
    var strBin="10,18,30,35,37,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,58,60,62,65,68,69,84,87,88,94,95,98,99";
    if (strBin.indexOf(bankno.substring(0, 2))== -1) {
        //$("#banknoInfo").html("银行卡号开头6位不符合规范");
        return false;
    }
    var lastNum=bankno.substr(bankno.length-1,1);//取出最后一位（与luhm进行比较）

    var first15Num=bankno.substr(0,bankno.length-1);//前15或18位
    var newArr=new Array();
    for(var i=first15Num.length-1;i>-1;i--){    //前15或18位倒序存进数组
        newArr.push(first15Num.substr(i,1));
    }
    var arrJiShu=new Array();  //奇数位*2的积 <9
    var arrJiShu2=new Array(); //奇数位*2的积 >9

    var arrOuShu=new Array();  //偶数位数组
    for(var j=0;j<newArr.length;j++){
        if((j+1)%2==1){//奇数位
            if(parseInt(newArr[j])*2<9)
                arrJiShu.push(parseInt(newArr[j])*2);
            else
                arrJiShu2.push(parseInt(newArr[j])*2);
        }
        else //偶数位
            arrOuShu.push(newArr[j]);
    }

    var jishu_child1=new Array();//奇数位*2 >9 的分割之后的数组个位数
    var jishu_child2=new Array();//奇数位*2 >9 的分割之后的数组十位数
    for(var h=0;h<arrJiShu2.length;h++){
        jishu_child1.push(parseInt(arrJiShu2[h])%10);
        jishu_child2.push(parseInt(arrJiShu2[h])/10);
    }

    var sumJiShu=0; //奇数位*2 < 9 的数组之和
    var sumOuShu=0; //偶数位数组之和
    var sumJiShuChild1=0; //奇数位*2 >9 的分割之后的数组个位数之和
    var sumJiShuChild2=0; //奇数位*2 >9 的分割之后的数组十位数之和
    var sumTotal=0;
    for(var m=0;m<arrJiShu.length;m++){
        sumJiShu=sumJiShu+parseInt(arrJiShu[m]);
    }

    for(var n=0;n<arrOuShu.length;n++){
        sumOuShu=sumOuShu+parseInt(arrOuShu[n]);
    }

    for(var p=0;p<jishu_child1.length;p++){
        sumJiShuChild1=sumJiShuChild1+parseInt(jishu_child1[p]);
        sumJiShuChild2=sumJiShuChild2+parseInt(jishu_child2[p]);
    }
    //计算总和
    sumTotal=parseInt(sumJiShu)+parseInt(sumOuShu)+parseInt(sumJiShuChild1)+parseInt(sumJiShuChild2);

    //计算Luhm值
    var k= parseInt(sumTotal)%10==0?10:parseInt(sumTotal)%10;
    var luhm= 10-k;

    if(lastNum==luhm){
        return true;
    }
    else{
        return false;
    }
}



/**
 * Map工具集
 * 付demo
 */

//  var map = new Map();
//  map.put("a", "aaa");
//  map.put("b","bbb");
//  map.put("cc","cccc");
//  map.put("c","ccc");
//  map.remove("cc");
//  var array = map.keySet();
//  for(var i in array) {
//  document.write("key:(" + array[i] +") <br>value: ("+map.get(array[i])+") <br>");
// }


//初始化
function Map(){
this.container = new Object();
}

//添加
Map.prototype.put = function(key, value){
this.container[key] = value;
}

//通过key获取
Map.prototype.get = function(key){
return this.container[key];
}


//把key转换成array数组
Map.prototype.keySet = function() {
var keyset = new Array();
var count = 0;
for (var key in this.container) {
// 跳过object的extend函数
if (key == 'extend') {
continue;
}
keyset[count] = key;
count++;
}
return keyset;
}

//获得map大小
Map.prototype.size = function() {
var count = 0;
for (var key in this.container) {
// 跳过object的extend函数
if (key == 'extend'){
continue;
}
count++;
}
return count;
}

//通过key移除map元素
Map.prototype.remove = function(key) {
delete this.container[key];
}

//把map集合转成字符串
Map.prototype.toString = function(){
var str = "";
for (var i = 0, keys = this.keySet(), len = keys.length; i < len; i++) {
str = str + keys[i] + "=" + this.container[keys[i]] + ";\n";
}
return str;
}