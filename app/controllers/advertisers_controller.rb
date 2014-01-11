class AdvertisersController < ApplicationController

	before_action :login_check

	def index
		@action = 'index'
		@styles = ['index']
		@scripts = ['index']
	end

	def wallet
		@action = 'wallet'
		@styles = ['wallet']
		@scripts = ['wallet']
		@wallet_total = 0.0
		@page_number = params[:page_number].nil? ? 1 : params[:page_number]
		deposits = Deposit.where user_id: session[:user_id]
		deposits.each do |deposit|
			@wallet_total += deposit.received_amount.to_f.round(2)
		end
		@wallet_used = 50.0
	end

	def create_ad
		@action = 'create_ad'
		@styles = ['create_ad']
		@scripts = ['create_ad']
    @ads = Advert.where user_id: session[:user_id]
	end

	def create_ad_post
		new_ad = Advert.new get_create_ad_params.merge!({user_id: session[:user_id]})
		if new_ad.save
			flash[:success] = true
		end
		redirect_to advertiser_create_ad_path
	end

	def campaign
		@action = 'campaign'
		@styles = []
		@scripts = []
	end

	def account
		@action = 'account'
		@styles = []
		@scripts = []
	end

	private

		def login_check
			if session[:user_id].nil? || session[:api_key].nil?
				redirect_to root_path
			else
				if session[:api_key] != User.find(session[:user_id]).get_api_key
					session.delete(:user_id)
					session.delete(:api_key)
					redirect_to root_path
				else
			        @name = User.find(session[:user_id]).full_name
				end
			end
		end

		def get_create_ad_params
			params.require(:create_ad).permit(:name, :type, :url)
		end

end
