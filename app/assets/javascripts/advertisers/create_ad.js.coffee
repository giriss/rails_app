toogle_url = (val) ->
	$create_ad_url = $ "#create_ad_url"
	$url_tr = $ "#url_tr"
	$create_ad_commit= $ "#create_ad_commit"
	$create_ad_form = $ "#create_ad_form"
	if val == "2"
		$url_tr.addClass "nodisplay"
		$create_ad_url.val ""
#		$create_ad_commit.val "Proceed to design mode"
	else
		$url_tr.removeClass "nodisplay"
		$create_ad_url.val ""
#		$create_ad_commit.val "Create"



$( document ).ready ->
	csrf_token = $("meta[name=csrf-token]").attr "content"
	csrf_param = $("meta[name=csrf-param]").attr "content"
	$(".delete").click (event) ->
		event.preventDefault()
		event.stopPropagation()
		if(window.confirm("Are you sure to delete this advert?"))
			id = $(this).attr "data-id"
			url = "/advertiser/destroy_ad/" + id
			$id_form = $ "#form"
			$id_form.attr("action", url).attr "method", "post"
			$id_form.html "<input type='hidden' name='"+csrf_param+"' value='"+csrf_token+"' />"
			$id_form.submit()
	$("#create_ad_now_button").click ->
		$("#ad_count_num_div").addClass "nodisplay"
		$("#create_ad_div").removeClass "nodisplay"
	$("#create_ad_cancel_button").click (event) ->
		event.preventDefault()
		$("#ad_count_num_div").removeClass "nodisplay"
		$("#create_ad_div").addClass "nodisplay"

	$("#create_ad_type").change ->
		toogle_url $(this).val()

$(window).bind "load", ->
	$("body").css "visibility", "visible"
	if $(window).height() > 75+30+$("#body").outerHeight()+20+164
		$("footer").height $(window).height() - (75+30+$("#body").outerHeight()+20)