/**
 * 对原生js的一些扩展，及常用函数封装
 * 2014-4-10
 */
/**
 * Html元素使用的扩展方法，解决IE6，7，8不支持Html元素的prototype问题
 * @param name - 事件名称
 * @param fn - 事件响应函数
 */
function HtmlElementExtend(name, fn) {
    if (typeof(HTMLElement) != "undefined") {
        HTMLElement.prototype[name] = fn;
    } else {
        var _getElementById = document.getElementById;
        document.getElementById = function(id) {
            var _elem = _getElementById(id);
            if (_elem != null) _elem[name] = fn;
            return _elem;
        };

        var _getElementByTagName = document.getElementsByTagName;
        document.getElementsByTagName = function(tag) {
            var _elem = _getElementByTagName(tag);
            if (_elem != null) {
                var len = _elem.length;
                for (var i = 0; i < len; i++) {
                    _elem[i][name] = fn;
                }
            }
            return _elem;
        };

        var _createElement = document.createElement;
        document.createElement = function(tag) {
            var _elem = _createElement(tag);
            if (_elem != null) _elem[name] = fn;
            return _elem;
        };

        var _documentElement = document.documentElement;
        if (_documentElement != null) _documentElement[name] = fn;

        var _documentBody = document.body;
        if (_documentBody != null) _documentBody[name] = fn;
    }
};
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
};

String.prototype.leftTrim = function() {
    return this.replace(/(^\s*)/g, "");
};

String.prototype.rightTrim = function() {
    return this.replace(/(\s*$)/g, "");
};

String.prototype.encodeAllHtml = function() {
    return this ? this.replace(/[&<">'](?:(amp|lt|quot|gt|#39|nbsp);)?/g, function(a, b) {
        if (b) {
            return a;
        } else {
            return {
                '<': '&lt;',
                '&': '&amp;',
                '"': '&quot;',
                '>': '&gt;',
                "'": '&#39;'
            }[a]
        }
    }) : '';
};

String.prototype.encodeXml = function() {
    return this.replace(/[<>]/g, function(m) {
        return {
            "<": "&lt;",
            ">": "&gt;"
        }[m];
    });
};

Array.prototype.remove=function(dx){
    if(isNaN(dx)||dx>this.length){return false;}
    for(var i=0,n=0;i<this.length;i++)
    {
        if(this[i]!=this[dx]){
            this[n++]=this[i];
        }
    }
    this.length-=1;
};

Array.prototype.contain = function(e) {
    for(i=0;i<this.length;i++) {
        if(this[i] == e)
            return true;
    }
    return false;
};

Date.prototype.format = function(fmt){
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
};

/**
 * 事件绑定
 * @param evenetName 事件名字，如click,change,blur
 * @param callback 绑定的事件处理函数
 */
HtmlElementExtend("bindEvent", function(eventName, callback) {

    if (this == null || !this) return false;
    if (typeof(callback) !== 'function') return false;

    if (window.attachEvent) {
        this.attachEvent('on' + eventName, callback);
    } else if (window.addEventListener) {
        this.addEventListener(eventName, callback, false);
    }
});

/**
 * 事件移除
 * @param evenetName 事件名字，如click,change,blur
 * @param callback 绑定的事件处理函数
 */
HtmlElementExtend("removeEvent", function(eventName, callback) {
    if (this == null || !this) return false;
    if (typeof(callback) !== 'function') return false;

    if (window.detachEvent) {
        this.detachEvent('on' + eventName, callback);
    } else if (window.removeEventListener) {
        this.removeEventListener(eventName, callback, false);
    }
});

/**
 * jQuery扩展，将Form表单序列化为js Object对象
 * @returns {{}}
 */
$.fn.serializeObject = function() {
    var o = {};
    $.each(this.serializeArray(), function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$.dialog = $.extend({},$.dialog, {
    options : {},
    __init__:function(){
        var _this = this;
        if($("#_jkx_dialog_box")[0] == null){
            $(document.body).append('<div class="laybox" id="_jkx_dialog_box"></div>');
        }else {
            $("#_jkx_dialog_box").empty();
        }

        $("#_jkx_dialog_box").append('<div class="layout ignore_lay"><dl><dt class="close"></dt><dd>'+ (this.options.title || "") +'</dd></dl>' +
            '<div class="box"><p class="tswz">'+ (this.options.content || "") +'</p>' +
            '<p class="butbox"><span><a href="javascript:;" class="butWhite cancel">取消</a><a href="javascript:;" class="butBlue sure">确定</a>' +
            '</span></p></div></div>');

        $("#_jkx_dialog_box .close").click(function(){_this._close(false)});
    },
    _close:function(ok){
        if(this.options.callback && typeof this.options.callback === "function") {
            this.options.callback.call(this, ok);
        }

        $("#_jkx_dialog_box").hide();
    },
    _show:function(){
        $("#_jkx_dialog_box").show();
    },
    alert:function() {
        var _this = this;
        var i, callback,length=arguments.length, opts, item;
        if(length < 3) {
            throw Error("参数长度为[" + length + "]的方法未定义");
        }

        this.options["title"] = (arguments[0] || '').encodeAllHtml();
        this.options["content"] = arguments[1] || '';
        callback = arguments[2];
        if(typeof callback === "function"){
            this.options["callback"] = callback;
            i = 3;
        }else {
            i = 2;
        }
        for(; i < length ; i++){
            if(( opts = arguments[i]) != null) {
                for(item in opts) {
                    this.options[item] = opts[item];
                }
            }
        }

        this.__init__();
        if(!this.options.title) {
            this.setTitle("提示");
        }

        $("#_jkx_dialog_box .cancel").remove();
        $("#_jkx_dialog_box .sure").click(function(){
            _this._close(true);
        });

        this._show();
    },
    confirm:function(){
        var _this = this;
        var i,length=arguments.length, opts, item;
        if(length < 3) {
            throw Error("参数长度为[" + length + "]的方法未定义");
        }

        this.options["title"] = (arguments[0] || '').encodeAllHtml();
        this.options["content"] = arguments[1] || '';
        var callback = arguments[2];
        if(typeof callback === "function"){
            this.options["callback"] = callback;
            i = 3;
        }else {
            i = 2;
        }
        for(; i < length ; i++){
            if(( opts = arguments[i]) != null) {
                for(item in opts) {
                    this.options[item] = opts[item];
                }
            }
        }

        this.__init__();

        if(!this.options.title) {
            this.setTitle("确认");
        }

        $(".sure", "#_jkx_dialog_box").click(function(){
            _this._close(true);
        });

        $(".cancel", "#_jkx_dialog_box").click(function(){
            _this._close(false);
        });

        this._show();
    },
    setTitle:function(title){
        title = title.encodeAllHtml();
        $("dd","#_jkx_dialog_box").html(title);
    },
    setContent:function(content){
        $(".tswz","#_jkx_dialog_box").html(content);
    }
});

/**
 * easyui扩展方法 使datagrid的列中能显示row中的对象里的属性
 * 无需调用自动执行 Field：Staff.JoinDate
 **/
/**
$.fn.datagrid.defaults.view = $.extend({}, $.fn.datagrid.defaults.view, {
    renderRow: function (target, fields, frozen, rowIndex, rowData) {
        var opts = $.data(target, 'datagrid').options;
        var cc = [];
        if (frozen && opts.rownumbers) {
            var rownumber = rowIndex + 1;
            if (opts.pagination) {
                rownumber += (opts.pageNumber - 1) * opts.pageSize;
            }
            cc.push('<td class="datagrid-td-rownumber"><div class="datagrid-cell-rownumber">' + rownumber + '</div></td>');
        }
        for (var i = 0; i < fields.length; i++) {
            var field = fields[i];
            var col = $(target).datagrid('getColumnOption', field);
            var fieldSp = field.split(".");
            var dta = rowData[fieldSp[0]];
            for (var j = 1; j < fieldSp.length; j++) {
                dta = dta[fieldSp[j]];
            }
            if (col) {
                // get the cell style attribute
                var styleValue = col.styler ? (col.styler(dta, rowData, rowIndex) || '') : '';
                var style = col.hidden ? 'style="display:none;' + styleValue + '"' : (styleValue ? 'style="' + styleValue + '"' : '');

                cc.push('<td field="' + field + '" ' + style + '>');

                var style = 'width:' + (col.boxWidth) + 'px;';
                style += 'text-align:' + (col.align || 'left') + ';';
                style += opts.nowrap == false ? 'white-space:normal;' : '';

                cc.push('<div style="' + style + '" ');
                if (col.checkbox) {
                    cc.push('class="datagrid-cell-check ');
                } else {
                    cc.push('class="datagrid-cell ');
                }
                cc.push('">');

                if (col.checkbox) {
                    cc.push("<input type=\"checkbox\" " + (rowData.checked ? "checked=\"checked\"" : ""));
                    cc.push(" name=\"" + field + "\" value=\"" + (dta != undefined ? dta : "") + "\">");
                } else if (col.formatter) {
                    cc.push(col.formatter(dta, rowData, rowIndex));
                } else {
                    cc.push(dta);
                }

                cc.push('</div>');
                cc.push('</td>');
            }
        }
        return cc.join('');
    }
});
**/