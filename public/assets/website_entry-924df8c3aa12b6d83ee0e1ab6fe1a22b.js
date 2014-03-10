document.write("<script src=\"http://localhost:3000/assets/jquery.cookie.min.js\"></script>");

//---------------//
//var ilyio_user_id = 2;
//var ilyio_delay = 5000;
//var ilyio_interval = 5;
//var ilyio_maximum = 5;
//---------------//

$(document).ready(function(){
	setTimeout(function(){
		var max_expire = new Date();
		var flag_expire = new Date();
		var date = new Date();
		var time_in_seconds = (date.getHours() * 3600) + (date.getMinutes() * 60) + date.getSeconds();
		var max_cookie_time = (24*3600) - time_in_seconds;
		max_expire.setTime(date.getTime() + (max_cookie_time * 1000));
		flag_expire.setTime(date.getTime() + (ilyio_interval * 60 * 1000));

		if($.cookie("ilyio_flag") == undefined){
			$.cookie('ilyio_flag', true, { expires: flag_expire });
			if($.cookie('ilyio_num_times') == undefined){
				$.cookie('ilyio_num_times', 0, { expires: max_expire })
				window.location = "http://localhost:3000/"+ilyio_user_id+"+/"+window.location.href
			}else if($.cookie("ilyio_num_times") != ilyio_maximum){
				var i = parseInt($.cookie('ilyio_num_times')) + 1;
				$.cookie('ilyio_num_times', i, { expires: max_expire } )
				window.location = "http://localhost:3000/"+ilyio_user_id+"+/"+window.location.href
			}else{
				$.removeCookie("ilyio_flag")
			}
		}

	}, parseInt(ilyio_delay))
})
;
