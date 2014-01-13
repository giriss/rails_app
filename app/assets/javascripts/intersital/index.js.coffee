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

jQuery ->
	# Adjusts the publisher_ad_div's width
	adjustSizes()
	$("body").css("visibility", "visible")
	$(window).resize -> adjustSizes()