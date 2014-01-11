toogle_url = (val) ->
	$create_ad_url = $ "#create_ad_url"
	$url_tr = $ "#url_tr"
	$create_ad_commit= $ "#create_ad_commit"
	if val == "2"
		$url_tr.addClass "nodisplay"
		$create_ad_url.val ""
		$create_ad_commit.val "Proceed to design mode"
	else
		$url_tr.removeClass "nodisplay"
		$create_ad_url.val ""
		$create_ad_commit.val "Create"


$( document ).ready ->

	$("#create_ad_now_button").click ->
		$("#ad_count_num_div").addClass "nodisplay"
		$("#create_ad_div").removeClass "nodisplay"
	$("#create_ad_cancel_button").click (event) ->
		event.preventDefault()
		$("#ad_count_num_div").removeClass "nodisplay"
		$("#create_ad_div").addClass "nodisplay"

	$("#create_ad_type").change ->
		toogle_url $(this).val()