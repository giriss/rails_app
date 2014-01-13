$(document).ready(function(){
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

	// This checks and alert for any login or register error
	if(window.error_any){
		Apprise(window.error_desc, apprise_options);
	}

	// Function which slides the div
	$("#middle").click(function(){
		if($("#body > div").css("left") != "-600px"){
			$("#body > div").animate({"left": "-600px"}, 1000,function(){
				$("#middle table:nth-child(1)").toggleClass("nodisplay");
				$("#middle table:nth-child(1)").toggleClass("display");
				$("#middle table:nth-child(2)").toggleClass("nodisplay");
				$("#middle table:nth-child(2)").toggleClass("display");
			})
		}else{
			$("#body > div").animate({"left": "0px"}, 1000,function(){
				$("#middle table:nth-child(1)").toggleClass("nodisplay");
				$("#middle table:nth-child(1)").toggleClass("display");
				$("#middle table:nth-child(2)").toggleClass("nodisplay");
				$("#middle table:nth-child(2)").toggleClass("display");
			})
		}
	})

	// Checks whether passwords match during registering
	$("#register_form").submit(function(event){
		if(
			$("#user_register_repassword").val()
			!=
			$("#user_register_password").val()
		)
		{
			event.preventDefault();
			alert("Password does not match !!");
		}
	})

	$("#try_it").submit(function(event){
		event.preventDefault();
		var csrf_token = $("meta[name=csrf-token]").attr("content");
		var key		   = "~~~~";
		$.ajax({
			url: "/url_action/shrink",
			type: "post",
			data: {"authenticity_token": csrf_token, "shrink[target]": $("#shrink_target").val()},
			success: function(html){
				key = html
				$("#try_it div:nth-child(2) > *:nth-child(1) .textInput").prop("disabled", true);
				$("#try_it div:nth-child(2) > *:nth-child(2) .button").prop("disabled", true);
				$("#try_it div:nth-child(2) > *:nth-child(3)").html("<textarea id='short_link'>http://ily.io/"+key+"</textarea>");
				$("#try_it div:nth-child(2) > *:nth-child(4)").html("try another");
                $("#short_link").on("click", function(){
                    $(this).select();
                })
			}
		})
	})

	$("#try_it div:nth-child(2) > *:nth-child(4)").click(function(){
		$("#try_it div:nth-child(2) > *:nth-child(1) .textInput").prop("disabled", false);
		$("#try_it div:nth-child(2) > *:nth-child(2) .button").prop("disabled", false);
		$("#try_it div:nth-child(2) > *:nth-child(3)").html("");
		$("#try_it div:nth-child(2) > *:nth-child(4)").html("");
	})

	if($(window).height()>634){
		$("footer").height($(window).height() - 470);
	}

})