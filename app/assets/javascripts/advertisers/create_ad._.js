/**
 * Created by Akhilesh on 12/27/13.
 */

var toogle_url = function(val){
	var $create_ad_url = $("#create_ad_url");
	var $url_tr = $("#url_tr");
	var $create_ad_commit= $("#create_ad_commit");
	if(val == "2"){
		$url_tr.addClass("nodisplay");
		$create_ad_url.val("");
		$create_ad_commit.val("Proceed to design mode")
	}else{
		$url_tr.removeClass("nodisplay");
		$create_ad_url.val("");
		$create_ad_commit.val("Create")
	}
};

$( document ).ready(function(){

	$("#create_ad_now_button").click(function(){
		$("#ad_count_num_div").addClass("nodisplay");
		$("#create_ad_div").removeClass("nodisplay");
	});
	$("#create_ad_cancel_button").click(function(event){
		event.preventDefault();
		$("#ad_count_num_div").removeClass("nodisplay");
		$("#create_ad_div").addClass("nodisplay");
	});
	$("#create_ad_type").change(function(){
		toogle_url($(this).val())
	})
});