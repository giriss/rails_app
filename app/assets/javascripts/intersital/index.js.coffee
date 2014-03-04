isGreater = (num1, num2) ->
	num1 > num2

returnGreater = (num1, num2) ->
	if num1 >= num2 then num1 else num2

adjustSizes = ->
	window_width = $( window ).innerWidth()
	$("#publisher_ad_div").innerWidth(window_width - 300)
	$ad_div = $ "#publisher_ad_div"
	window_height = $(window).height()
	$ad_div.height(window_height - 75)
	$("#ad_iframe")
	.width(window_width - 300)
	.height(window_height - 75)
	$("#official_sponsors_div").css({"max-height": window_height-75+"px"})

$( window ).bind "load", ->   # This binds a function to when all the FONTS and DOM is loaded
	adjustSizes()
	window.setTimeout adjustSizes, 1
	window.setTimeout adjustSizes, 2

coutdownDone = ->
	$("#goto_site").removeAttr("disabled")
	$("#countdown_div").html("")
	$.post "/intersital/request_campaign", {authenticity_token: window._csrf_token_}, (json) ->
		$("#question_div").html json.question + "?"
		$("#answers_div").html ""
		$.each json.options, (key, value) ->
			i = key + 1
			color = (num) ->
				if num % 2 == 0
					"_cyan"
				else
					"_blue"
			$("#answers_div").append "<div class=\"answer_div\"><a data-number=\"" + i + "\" class=\"answer_a "+color(i)+" elevated_button\">"+i+". "+value+"</a></div>"

jQuery ->

	window._csrf_token_ = $("meta[name=csrf-token]").attr "content"
	window._csrf_param_ = $("meta[name=csrf-param]").attr "content"
	csrf_token = $("meta[name=csrf-token]").attr "content"
	csrf_param = $("meta[name=csrf-param]").attr "content"

	# Adjusts the publisher_ad_div's width
	adjustSizes()
	$("body").css("visibility", "visible")
	$(window).resize -> adjustSizes()

	$("#goto_site").click (event) ->
		$("#question_answer_outer_div").css "display", "block"
		$("#question_answer_div_close").css "display", "block"

	$("#question_answer_div_close").click (event) ->
		$("#question_answer_outer_div").css "display", "none"
		$(this).css "display", "none"

	$("#question_answer_inner_div").height $(window).innerHeight() - 100
	$("#question_answer_inner_inner_div").height $(window).innerHeight() - 120

	decrement_time = window.setInterval ->
		$("#countdown_span").html parseInt($("#countdown_span").html()) - 1
		window.clearInterval(decrement_time) if $("#countdown_span").html() == "0"
		coutdownDone() if $("#countdown_span").html() == "0"
	, 1000

	window.setTimeout ->
		$.post "/intersital/request_campaign", {authenticity_token: csrf_token}, (json) ->
			$.each json, (key, value) ->
				console.log "Key: " + key + "; Value: " + value  ###### Only for testing ######
	, 29000