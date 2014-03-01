jQuery ->

	$("[data-url]:not(.selected)").click ->
		url = $(this).attr("data-url")
		window.location = url

	apprise_options =
		buttons:
			confirm:
				text: '<span class="ubuntu normal_size">Okie</span>'
				action: -> Apprise('close')

	if window.alert_any
		Apprise("<span class=\"ubuntu black large\">"+window.alert_desc+"</span>", apprise_options)

	csrf_token = $("meta[name=csrf-token]").attr "content"
	csrf_param = $("meta[name=csrf-param]").attr "content"
	$("[data-method=post]")
	.click (event) ->
		event.preventDefault()
		url = $(this).attr "href"
		$id_form = $ "#form"
		$id_form.attr("action", url).attr "method", "post"
		$id_form.html "<input type='hidden' name='"+csrf_param+"' value='"+csrf_token+"' />"
		$id_form.submit()

	$("#goto_site").click (event) ->
		$("#question_answer_outer_div").css "display", "block"
		$("#question_answer_div_close").css "display", "block"

	$("#question_answer_div_close").click (event) ->
		$("#question_answer_outer_div").css "display", "none"
		$(this).css "display", "none"

	$("#question_answer_inner_div").height $(window).innerHeight() - 100