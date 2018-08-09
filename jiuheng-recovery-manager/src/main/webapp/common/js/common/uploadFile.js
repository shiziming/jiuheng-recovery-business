/**
 * Created by Tiany on 2014/12/12 0012.
 */
/**
 * 使用ajaxupload上传文件<br>
 * 只引入这个js和jquery就可以
 */
// document.write("<script language=javascript src='http://10.2.135.36:8083/jiuheng-recovery-manager/common/js/common/ajaxupload.js?_=1533652379671'><\/script>");
// document.write("<script language='text/javascript' src='common/js/common/ajaxupload.js'><\/script>");
// document.write(decodeURIComponent('%3Cscript type="text/javascript" src="common/js/common/ajaxupload.js"%3E%3C/script%3E'));
/**
 * ajaxupload的封装，在ajaxupload的基础上添加了文件后缀验证。
 * @param opts - name : 上传文件的表单名称，对象后台接收对象，默认为file
 * action : 文件上传请求地址
 * fileType : 上传的文件类型，pic - 图片,video - 视频，attach - 附件
 * fileNum : 一次能同时上传的文件数量，默认1
 * onSubmit : 请求提交前的回调方法，return false 则不提交，参数文件和后缀（如：zip,jpg,gif）
 * onComplete : 请求完成的回调方法，参数文件和响应
 */
$.fn.extend({
    ajaxUpload : function(opts){
        var interval = null;
        var _this = this;
        var _thisOrginalText = null;
        var options = {
            fileType : opts.fileType || "pic",
            fileNum : (opts.fileNum && !isNaN(opts.fileNum)) ? opts.fileNum : 1,
            submit : opts.onSubmit,
            complete : opts.onComplete ,
            name : opts.name || "file",
            action : opts.action || ""
        };

        var ajaxUplaod = new AjaxUpload(_this,{
            action : options.action,
            name :  options.name,
            onSubmit : function(file, ext){
                try{
                    if(!checkType(options.fileType,ext)){
                        return false;
                    }
                }catch (e){}
                if(typeof (options.submit) == "function"){
                    options.submit(file, ext);
                }
            },
            onComplete : function(file, response){
                _this.text(_thisOrginalText);
                clearInterval(interval);
                _this.removeAttr("disabled");
                if(typeof (options.complete) == "function"){

                    response = response || "";
                    response = response.replace(/^.*(\{.*\}).*$/g, function (a, b) {
                        return b;
                    });

                    try{
                        response = $.parseJSON(response);
                    }catch (e){
                        try {
                            response = eval("("+response+")");
                        }catch(e1) {}
                    }
                    options.complete(file, response);
                }
            }
        });

        var checkType = function(type,ext){
            var flag = true;
            switch (type){
                case "pic":
                    if(!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))){
                        $.messager.alert("警告", "请选择图片文件！");
                        flag = false;
                    }
                    break;
                case "video":
                    if(!(ext && /^(flv|mp4|mpeg4|rmvb|avi)$/).test(ext)){
                        $.messager.alert("警告", "请选择视频文件,支持.rmvb,.mp4,.avi.flv格式视频！");
                        flag = false;
                    }
                    break;
                case "attach":
                    if(!(ext && /^(zip)$/).test(ext)){
                        $.messager.alert("警告", "附件只支持.zip格式文件！");
                        flag = false;
                    }
                    break;
                default :
                    flag = false;
                    break;
            }

            if(flag){
                showLoading();
            }
            return flag;
        };

        var showLoading = function (){
            _thisOrginalText = _this.text();
            _this.text('文件上传中');

            if( options.fileNum == 1)
                _this.attr("disabled","disabled");

            interval = window.setInterval(function(){
                var text = _this.text();
                if (text.length < 14){
                    _this.text(text + '.');
                } else {
                    _this.text('文件上传中');
                }
            }, 200);
        };
    }
});