adjustImgHeight = ->
	imgs = $("#img_div > img")
	for image in imgs
		if $(image).height() > 400
			$(image).height(400)
			width = $(image).width()
			$(image).width(800) if width > 800
			$(image).css("height", "auto") if width > 800
		else if $(image).width > 800
			$(image).width(800)
			height = $(image).height()
			$(image).height(400) if height > 400
			$(image).css("width", "auto") if height > 400

adjustImgMargin = ->
	imgs = $("#img_div > img")
	for image in imgs
		height = $(image).height()
		margin_top = (400 - height) / 2
		$(image).css("margin-top", margin_top + "px")

window.count = 0
toogleImage = ->
	if window.count == window.num_imgs - 2
		clearInterval window.hide
		setTimeout ->
			$("#goto_div").animate({"opacity": "1"}, 1000)
		, 1000
	$($("#img_div > img")[window.count]).animate {"opacity":"0"}, 500, ->
		$($("#img_div > img")[window.count]).addClass("nodisplay")
		$($("#img_div > img")[window.count]).removeClass("current")
		$($("#img_div > img")[window.count + 1]).removeClass("nodisplay")
		$($("#img_div > img")[window.count + 1]).addClass("current")
		$($("#img_div > img")[window.count + 1]).animate {"opacity":"1"}, 500
		window.count = window.count + 1

goto_image = (event) ->
	self = event.currentTarget
	num = $(self).attr("data-num")
	console.log num
	$("#img_div > img.current").animate {"opacity":"0"}, 1000, ->
		$("#img_div > img.current").addClass("nodisplay")
		$("#img_div > img.current").removeClass("current")
		$($("#img_div > img")[num-1]).removeClass("nodisplay")
		$($("#img_div > img")[num-1]).addClass("current")
		$("#goto_div > span.current").removeClass("current")
		$(self).addClass("current")
		$($("#img_div > img")[num-1]).animate {"opacity":"1"}, 1000

jQuery ->
	$imgs = $("#img_div > img")
	window.num_imgs = $imgs.length
	interval = 30000 / num_imgs
	window.hide = setInterval toogleImage, interval
	$imgs.on 'load', ->
		adjustImgHeight()
		adjustImgMargin()
	$("#goto_div > span").click (event) -> goto_image(event)