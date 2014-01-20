class TestController < ApplicationController
	def one
		flash[:one] = { name: "Akhilesh", age: 18 }
		redirect_to test_two_path
	end

	def two
		if flash[:one].nil?
			render text: "0k"
		else
			render text: "N0t 0k"
		end
	end

	def three
		redirect_to advertiser_design_ad_path 9
	end

	def four
	end
end
