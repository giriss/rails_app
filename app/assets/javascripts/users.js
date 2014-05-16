function adjust_width(){
	if(window.NUM_URLS > 1){

		$("#inside_slideable_when_first_time").addClass('nodisplay');

		var left = parseInt($("#slideable").css("left").split("px")[0]);
		var max_left = parseInt(-(window.NUM_PAGES-1) * 780);

		if( left < max_left ){
			var new_left = left + 780;
			$("#slideable").animate({"left": new_left+"px"}, 1000)
		}
		$("#links > div:nth-child(2)").width(window.NUM_PAGES * 780);
		if( NUM_PAGES == 1 ){
			$("#next_prev").css({"display":"none"});
		}else{
			$("#next_prev").css({"display":"block"});
		}
	}else if(window.NUM_URLS == 1){
		$("#inside_slideable_when_first_time").addClass('nodisplay');
		$("#slideable").prev().css({"display": "block"});
		$("#slideable").parent().parent().next().css({"display": "none"})
	}else{
		$("#inside_slideable_when_first_time").removeClass('nodisplay');
		$("#slideable").prev().css({"display": "none"});
		$("#slideable").parent().parent().next().css({"display": "none"}); // similar to $("#next_prev").css...
	}

}

delete_url = function(self){
	var csrf_token = $("meta[name=csrf-token]").attr("content");
	var link_number = $(self).attr("data-number");
	var confirm_text = "Are you sure to delete the link #"+link_number+" ?\nRemember that deleting links will NOT result in loss of monthly revenue";
	if(window.confirm(confirm_text)){
		var url = $(self).attr("href");
		var urlid = $(self).attr("data-urlid");
		$.ajax({
			url: url,
			type: "post",
			data: {"authenticity_token": csrf_token},
			success: function(html){
				if(html == "1"){
					$.ajax("/url_action/update_urls", {
						type: "post",
						data: {"authenticity_token": csrf_token},
						success: function(html){
							$("#slideable").html(html);
							window.NUM_PAGES = $(".tables").size();
							window.NUM_URLS = $("#slideable table tr").size();
							adjust_width();
							$("#slideable table tr .delete").on("click", function(event){
								event.preventDefault();
								delete_url(this)
							});
						}
					});
				}else{
					Apprise("<span class=\"ubuntu black large\">Unknown error occured!<br />Try again</span>");
				}
			}
		})
	}
}

$( window ).bind("load", function(){
	window.ANNOUNCEMENTS_WIDTH = 0;
	$("#announcements > marquee > div > div").each(function(){
		window.ANNOUNCEMENTS_WIDTH = window.ANNOUNCEMENTS_WIDTH + $(this).width();
	})
	$("#announcements > marquee > div").width(window.ANNOUNCEMENTS_WIDTH+2);
})

$( document ).ready(function(){

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

	window.NUM_PAGES = $(".tables").size();
	window.NUM_URLS  = $("#slideable table tr").size();

	adjust_width();

	$("#announcements > marquee > div > div:last-child > span:last-child").remove();

	window.csrf_token = $("meta[name=csrf-token]").attr("content");
	window.csrf_param = $("meta[name=csrf-param]").attr("content");
	$("[data-method=post]").click(function(event){
		event.preventDefault();
		var url = $(this).attr("href");
		$("#form").attr("action", url).attr("method", "post");
		$("#form").html("<input type='hidden' name='"+window.csrf_param+"' value='"+window.csrf_token+"' />");
		$("#form").submit()
	});

	$("#next_button").click(function(){
		var left = parseInt($("#slideable").css("left").split("px")[0]);
		if(left % 780 == 0){
			var max_left = - (window.NUM_PAGES-1) * 780;
			if(left != max_left){
				var new_left = left - 780
				$("#slideable").animate({"left": new_left+"px"}, 1000)
			}else{
				Apprise("<span class=\"ubuntu black large\">No more pages !</span>", apprise_options)
			}
		}
	});

	$("#prev_button").click(function(){
		var left = parseInt($("#slideable").css("left").split("px")[0]);
		if(left % 780 == 0){
			var max_left = - (window.NUM_PAGES-1) * 780;
			if(left != 0){
				var new_left = left + 780
				$("#slideable").animate({"left": new_left+"px"}, 1000)
			}else{
				Apprise("<span class=\"ubuntu black large\">No more pages !</span>", apprise_options)
			}
		}
	});
	$("#shrink_button").click(function(event){
		event.preventDefault();
		var csrf_token = $("meta[name=csrf-token]").attr("content");
		var key		   = "~~~~";
		$.ajax({
			url: "/url_action/shrink",
			type: "post",
			data: {"authenticity_token": csrf_token, "shrink[target]": $("#shrink_target").val()},
			success: function(html){
				$.ajax("/url_action/update_urls", {
					type: "post",
					data: {"authenticity_token": csrf_token},
					success: function(html){
						$("#slideable").html(html);
						adjust_width();
						window.NUM_PAGES = $(".tables").size();
						window.NUM_URLS = $("#slideable table tr").size();
						adjust_width();
						$("#slideable table tr .delete").on("click", function(event){
							event.preventDefault();
							delete_url(this)
						});
					}
				});
				key = html
				$("#shrink_target").prop("disabled", true);
				$("#shrink_button").prop("disabled", true);
				$("#shorten_textarea").html("http://ily.io/"+key);
				$("#scrollable").animate({"top": "-48px"}, 500);
				$("#try_another_div").html("shrink another");
				$("#shorten_textarea").on("click", function(){
					$(this).select();
				})
			}
		})
	})

	$("#try_another_div").click(function(){
		$("#shrink_target").prop("disabled", false);
		$("#shrink_target").val("");
		$("#shrink_button").prop("disabled", false);
		$("#shorten_textarea").html("");
		$("#scrollable").animate({"top": "0px"}, 500);
		$("#try_another_div").html("");
	})

/*
	$("#scrollable").click(function(){
		$(this).animate({"top": "-48px"}, 500)
	})
*/

	$(".delete").click(function(event){
		event.preventDefault();
		delete_url(this)
	})

	$("[data-url]:not(.selected)").click(function(){
		var url = $(this).attr("data-url");
		window.location = url;
	})

/*
	$("body").click(function(){
		var selected = new Array();
		$("#links_list input[name=url_id]:checked").each(function(){
			selected.push($(this).attr("value"))
		})
	})
*/


//------------------------------------------------------------------------------------------------

//	javascript:void(location.href='http://adf.ly/shortener/bml?url='+encodeURIComponent(location.href))
	//$("body").html(encodeURIComponent(location.href))

});
