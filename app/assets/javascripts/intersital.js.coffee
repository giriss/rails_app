
jQuery ->

	csrf_token = $("meta[name=csrf-token]").attr "content"
	csrf_param = $("meta[name=csrf-param]").attr "content"

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

	$("[data-method=post]")
	.click (event) ->
		event.preventDefault()
		url = $(this).attr "href"
		$id_form = $ "#form"
		$id_form.attr("action", url).attr "method", "post"
		$id_form.html "<input type='hidden' name='"+csrf_param+"' value='"+csrf_token+"' />"
		$id_form.submit()
