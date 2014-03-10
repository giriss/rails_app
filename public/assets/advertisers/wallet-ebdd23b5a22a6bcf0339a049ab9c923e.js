$(document).ready(function(){

	$("#deposit_type").change(function(){
		if($(this).val() == "paypal"){
			$("#deposit_form").attr("action", "/deposits/set_express_checkout_paypal")
		}else{
			$("#deposit_form").attr("action", "/deposits/set_express_checkout_payza")
		}
	})

})
;
