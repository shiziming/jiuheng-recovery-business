

  var _t = true;
  var box = new LightBox();

  function ckshow(orderId,file,type) {

      box.Show();
      _t = true;
      var _h = document.documentElement.clientHeight;
      var _m = (_h - 500) * 0.5;
      if (_m < 0) {
          _m = 0;
      }
      CKobject._K_('video').style.top = _m + 'px';
      CKobject._K_('video').style.display = 'block';
      var url = window.ctx+'/orderVideo/getFileUrl?orderId='+orderId+'&f='+file+(type!=undefined?('&type='+type):"");

      var flashvars = {
          //f: file,//'http://v2.jikexiu.com/jikexiutest/src/J1142687729922868/06M00S.mp4',//'http://movie.ks.js.cn/flv/other/2014/06/20-2.flv',
          f:url,
          s:1,
          c: 0,
          loaded:'loadedHandler'
      };
      //var video = ['http://v2.jikexiu.com/jikexiutest/src/J1142687729922868/06M00S.mp4->video/mp4'];//['http://movie.ks.js.cn/flv/other/2014/06/20-2.mp4->video/mp4'];
      CKobject.embed(window.ctx+'/resources/ckplayer/ckplayer.swf', 'a1', 'ckplayer_a1', '1000', '500', false, flashvars);//, video);
  }
  function loadedHandler(){
  	CKobject._K_('yytf').style.display='none';
  	if(CKobject._K_('a1').innerHTML!=''){
  		CKobject.getObjectById('ckplayer_a1').videoPlay();
  	}
  }
  function ckclose() {
      box.Close();
      CKobject._K_('video').style.display = 'none';
      CKobject._K_('a1').innerHTML = '';
  }

  function getstart(){
  	var a=CKobject.getObjectById('ckplayer_a1').getStatus();
  	var ss='';
  	for (var k in a){
  		ss+=k+":"+a[k]+'\n';
  	}
  	alert(ss);
  }


  function dl(file){
  	$.download(encodeURI(file),'','get' );
  }
  