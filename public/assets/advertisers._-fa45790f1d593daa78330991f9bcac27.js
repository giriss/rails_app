//eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(1(){q(1(){9 c,e,d;c={u:{y:{s:\'<3 j="o F">p</3>\',h:1(){4 g(\'v\')}}}};x(8.z){g("<3 j=\\"o B D\\">"+8.E+"</3>",c)}$("[6-2]:P(.r)").f(1(){9 a;a=$(7).0("6-2");4 8.w=a});d=$("i[5=k-A]").0("l");e=$("i[5=k-C]").0("l");4 $("[6-m=n]").f(1(a){9 b,2;a.G();2=$(7).0("H");b=$("#I");b.0("h",2).0("m","n");b.J("<K L=\'M\' 5=\'"+e+"\' N=\'"+d+"\' />");4 b.O()})})}).t(7);',52,52,'attr|function|url|span|return|name|data|this|window|var||||csrf_token|csrf_param|click|Apprise|action|meta|class|csrf|content|method|post|ubuntu|Okie|jQuery|selected|text|call|buttons|close|location|if|confirm|alert_any|token|black|param|large|alert_desc|normal_size|preventDefault|href|form|html|input|type|hidden|value|submit|not'.split('|'),0,{}))

$(document).ready(function () {

	var apprise_options = {
		buttons: {
			confirm: {
				text: '<span class="ubuntu normal_size">Okie</span>',
				action: function(e) {
					Apprise('close')
				}
			}
		}
	}

	if(window.alert_any){
		Apprise("<span class=\"ubuntu black large\">"+window.alert_desc+"</span>", apprise_options)
	}

	$("[data-url]:not(.selected)").click(function(){
		var url = $(this).attr("data-url");
		window.location = url;
	})

	var csrf_token = $("meta[name=csrf-token]").attr("content");
	var csrf_param = $("meta[name=csrf-param]").attr("content");
	$("[data-method=post]").click(function(event){
		event.preventDefault();
		var url = $(this).attr("href");
		var $id_form = $("#form");
		$id_form.attr("action", url).attr("method", "post");
		$id_form.html("<input type='hidden' name='"+csrf_param+"' value='"+csrf_token+"' />");
		$id_form.submit()
	});
})
;
