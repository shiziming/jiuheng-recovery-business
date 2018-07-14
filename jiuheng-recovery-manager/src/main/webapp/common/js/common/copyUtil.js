/**
 * 此JS必须与clipboard.swf配合使用，且clipboard.swf必须与此js在同目录
 * 2014-5-29 17:02:49
 * 复制html元素内容，兼容IE6+,FireFox,Chrome,Safari.
 */
//引入prototype.js,需要使用里面的bindEvent方法
document.write(decodeURIComponent('%3Cscript type="text/javascript" src="'+ctx+'/resources/js/common/prototype.js"%3E%3C/script%3E'));

/**
 * 生成对应指定元素的复制按钮
 * opt :参数 - source  : 复制内容的来源元素的id
 * 			- target : 生成的按钮放置的容器的id 默认放置在来源元素的后面
 *			- tip : 复制按钮的提示信息，默认为''
 */
function createCopy(opt) {
    opt = opt || {};
    if (opt.source == null) return false;
    var inElement = document.getElementById(opt.source);
    var target = document.getElementById(opt.target);
    var tip = opt.tip || '';

    var flashcopier = 'flashcopier_' + inElement.id;
    var copierContainer = document.getElementById(flashcopier);

    if (!copierContainer || copierContainer == null) {
        var divholder = document.createElement('div');
        divholder.id = flashcopier;
        divholder.style.display = 'block';

        if (target != null && target) {
            target.appendChild(divholder);
        } else {
            divholder.style.position = 'absolute';
            divholder.style.top = inElement.offsetTop + 3 + 'px';
            divholder.style.left = inElement.offsetLeft + inElement.clientWidth - 15 + 'px';
            document.body.appendChild(divholder);
        }

        copierContainer = document.getElementById(flashcopier);
        //给复制的来源元素添加change事件监听
        inElement.bindEvent('keyup', function() {
            createCopy(opt);
        });
    }
    copierContainer.innerHTML = '';
    var divinfo = '<embed src="'+ctx+'/resources/js/common/clipboard.swf" flashvars="clipboard=' + encodeURIComponent(inElement.value) + '" wmode="transparent"  width="15"  height="20"  allowscriptaccess="always" quality="high" type="application/x-shockwave-flash">' + tip + '</embed>';
    copierContainer.innerHTML = divinfo;
};