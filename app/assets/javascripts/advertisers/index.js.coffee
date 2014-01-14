$ ->


$(window).bind "load", ->
	$("body").css "visibility", "visible"
	if $(window).height() > 75+30+$("#body").outerHeight()+20+164
		$("footer").height $(window).height() - (75+30+$("#body").outerHeight()+20)