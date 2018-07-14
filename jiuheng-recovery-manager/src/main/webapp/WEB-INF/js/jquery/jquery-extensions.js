$(function(){   
	$.fn.serializeObject = function() {
	    var o = {};
	    var a = this.serializeArray();
	    $.each(a, function() {
	        if (o[this.name]) {
	            if (!o[this.name].push) {
	                o[this.name] = [ o[this.name] ];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });
	    return o;
	}
	
	$.fn.getPosition = function() {    
	    var tempArr=[];  
	    this.each(function(){  
	        var elmt = this;     
	        var offsetTop = elmt.offsetTop;     
	        var offsetLeft = elmt.offsetLeft;     
	        var offsetHeight = elmt.offsetHeight;   
	        var offsetWidth=elmt.offsetWidth;  
	        while (elmt = elmt.offsetParent) {     
	            // add this judge     
	            if (elmt.style.position == 'absolute'|| elmt.style.position == 'relative'||(elmt.style.overflow != 'visible' && elmt.style.overflow != '')) {     
	               break;     
	            }     
	             offsetTop += elmt.offsetTop;     
	             offsetLeft += elmt.offsetLeft;     
	        }  
	        tempArr[tempArr.length]={ Top: offsetTop, Left: offsetLeft, Width: offsetWidth, Height: offsetHeight };     
	    });  
	    return tempArr;  
	}
	
	//EasyUI validator 扩展
	$.extend($.fn.validatebox.defaults.rules, {
		equalTo: { 
			validator: function (value, param) { 
				return $(param[0]).val() == value; 
			}, 
			message: '字段不匹配' 
		},
		notEqualTo: { 
			validator: function (value, param) { 
				return $(param[0]).val() != value; 
			}, 
			message: '新密码不能与原密码一样' 
		},
		positiveInt:{     
	        validator:function(value,param){     
	            if (value){     
	                return value.length <= param[0] && /^[0-9]*[1-9][0-9]*$/.test(value);     
	            } else {     
	                return true;     
	            }     
	        },     
	        message:'只能输入长度为 {0} 位以内的正整数.'    
	    },
	    transInterval: {
	    	validator:function(value,param){     
	            if (value) {
	            	return value.length <= 2 && (/^[0-9]*[1-9][0-9]*$/.test(value));   
	            } else {     
	                return true;     
	            }     
	        },     
	        message:'只能输入小于100的正整数.'  	    	
	    },
	    transTimes: {
	    	validator:function(value,param){     
	            if (value) {
	            	if (value.length <= 100) {
	            		var times = value.split(';');
	            		for (var i = 0; i < times.length; i++) {
	            			if (!/^(([01]?[0-9])|(2[0-3])):[0-5]?[0-9]$/.test(times[i])) {
	            				return false;
	            			}
	            		}
	            		return true;
	            	}
	            	return false;  
	            } else {     
	                return true;     
	            }     
	        },     
	        message:'只能输入hh:mm(时:分)格式的时间类型,多个格式间用(;)分开.且最多100个字符'   	    	
	    }	    
	});
}); 

