/**
 * easyui datagrid扩展跨页面多选
 */

jslist = function (){
    this._CROSS_PAGE_STORE = {};
}

jslist.prototype = {
    //添加元素
    addItem : function(_key, _val){
        if(typeof (""+_key) === 'string'){
            this._CROSS_PAGE_STORE[_key] = _val;
        }
    },
    //移除元素
    removeItem : function(_key){
        if(this._CROSS_PAGE_STORE[_key]){
            delete this._CROSS_PAGE_STORE[_key];
        }
    },

    //返回存放的对象
    getItems : function(){
        return this._CROSS_PAGE_STORE;
    },

    //返回一个JSON串，key为','分隔的id，value为','分隔的值
    getJson : function(){
        var keys = "" , values = "";
        for(var _key in this._CROSS_PAGE_STORE){
            keys += _key + ",";
            values += this._CROSS_PAGE_STORE[_key] + ",";
        }

        if(keys.length > 0){
            keys = keys.substr(0, keys.length -1 );
        }
        if(values.length > 0){
            values = values.substr(0, values.length -1);
        }

        return {key : keys, value : values};
    }
}

