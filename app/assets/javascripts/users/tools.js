$( document).ready(function(){

	$("#ms_shrink > button").click(function(){
		if (!$(this).hasClass("stop")){
			$("#ms_shrink > button").addClass("stop");
			var urls = $("#ms_tool_textarea > textarea").val();
			$.ajax("/url_action/mass_shrink" ,{
				type: "post",
				data: {"authenticity_token": window.csrf_token, "urls": urls},
				success: function(html){
					if (html != "0"){
						$("#ms_tool_textarea > textarea").val(html);
					}else{
						Apprise("<span class=\"ubuntu black large\">Cannot shrink more than 25 urls in a single go</span>")
					}
				}
			})
		}else{
			Apprise("<span class=\"ubuntu black large\">You cannot perform this operation</span>")
		}
	})

	$("#mls_shrink > button").click(function(){
		if (!$(this).hasClass("stop")){
			$("#mls_shrink > button").addClass("stop");
			var links = $("#mls_tool_textarea > textarea").val();
			$.ajax("/url_action/multi_links_shrink" ,{
				type: "post",
				data: {"authenticity_token": window.csrf_token, "links": links},
				success: function(html){
					if (html != "0"){
						$("#mls_tool_textarea > textarea").val(html);
					}else{
						Apprise("<span class=\"ubuntu black large\">Cannot shrink more than 25 urls in a single go</span>")
					}
				}
			})
		}else{
			Apprise("<span class=\"ubuntu black large\">You cannot perform this operation</span>")
		}
	})

	$("#ms_tool_textarea > textarea").change(function(){
		$("#ms_shrink > button").removeClass("stop")
	})

	$("#mls_tool_textarea > textarea").change(function(){
		$("#mls_shrink > button").removeClass("stop")
	})

	$(".tools").click(function(){
		if( !$(this).hasClass("selected") ){
			var name = $(this).attr("data-name");
			$(".tools").removeClass("selected");
			$(this).addClass("selected");
			$("#tool_div > div").addClass("nodisplay");
			$("#tool_div > #"+name+"_div").removeClass("nodisplay")
		}
	})

	$("#change_tracker_code").click(function(event){
		event.preventDefault();
		$("#current_tracker_code_div").addClass("nodisplay");
		$("#change_tracker_code_div").removeClass("nodisplay");
	})

	$("#cancel_tracker_change").click(function(event){
		event.preventDefault();
		$("#current_tracker_code_div").removeClass("nodisplay");
		$("#change_tracker_code_div").addClass("nodisplay");
	})

})