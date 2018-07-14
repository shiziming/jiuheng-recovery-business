$.message = {
    /**
     * @param title:标题
     * @param content:内容
     * @param fn:回调
     * @param text : 按钮名称(默认:确定)
     */
    alert : function(title, content,fn, text) {
        $("#jikexiu_messsage_alert,#jikexiu_message_alert_bodybg").remove();
        var str = "<div id='jikexiu_messsage_alert' class='pay_lay_unsuccess'>";
        str += "<dl class='title'><dt class='close'></dt><dd>"+title+"</dd></dl>";
        str += "<div class='box'>";
        str += "<p>"+content+"</p>";
        str += "<button class='confirm' class='button'>"+(text || "确定")+"</button>";
        str  += "</div>";
        str  += "</div>";
        str += "<div id='jikexiu_message_alert_bodybg' class='bodybg'></div>";
        $(document.body).append(str);
        $("#jikexiu_message_alert_bodybg").height($(document).height());
        $("#jikexiu_message_alert_bodybg,#jikexiu_messsage_alert").show();

        $("#jikexiu_messsage_alert").find(".close").unbind("click").bind("click", function(){
            closeAlert();
        });

        $("#jikexiu_messsage_alert").find(".confirm").unbind("click").bind("click", function(){
            closeAlert();
        });

        function closeAlert() {
            $("#jikexiu_messsage_alert,#jikexiu_message_alert_bodybg").remove();
            if(fn) {
                fn();
            }
        }

    },
    /**
     *
     * @param title:标题
     * @param content:内容
     * @param fn:回调
     * @param confirmText:确认按钮提示文字(默认:确定)
     * @param cancelText:取消按钮提示文字(默认:取消)
     */
    confirm : function(title, content, fn , confirmText, cancelText) {
        $("#jikexiu_messsage_confirm,#jikexiu_messsage_confirm_bodybg").remove();
        var str = "<div id='jikexiu_messsage_confirm' class='pay_lay'>";
        str += "<dl class='title'><dt class='close'></dt><dd>"+title+"</dd></dl>";
        str += "<div class='box'>";
        str += "<p>" + content +"</p>";
        str += "<button class='button scuss'>"+(confirmText || "确定")+"</button>";
        str += "<button class='button que'>" + (cancelText || "取消") + "</button>";
        str += "</div>";
        str += "</div>";
        str += "<div id='jikexiu_messsage_confirm_bodybg' class='bodybg'></div>";
        $(document.body).append(str);
        $("#jikexiu_messsage_confirm_bodybg").height($(document).height());
        $("#jikexiu_messsage_confirm,#jikexiu_messsage_confirm_bodybg").show();
        $("#jikexiu_messsage_confirm .scuss").unbind("click").bind("click", function() {
            closeConfirm();
            fn(true);
        });

        $("#jikexiu_messsage_confirm .que").unbind("click").bind("click", function() {
            closeConfirm();
            fn(false);
        });

        function closeConfirm() {
            $("#jikexiu_messsage_confirm,#jikexiu_messsage_confirm_bodybg").remove();
        }
    }
};