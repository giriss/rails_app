class ReferalController < ApplicationController
	def initiate
		flash[:referer_key] = params[:referer_key]
		render text: :Ok
	end

	def create
	end

	def destroy
	end
end
