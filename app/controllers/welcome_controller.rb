class WelcomeController < ApplicationController

  #before_action :login_check, only: [:index]

  def index
  	@user = User.new
	render :text => "Hi"
  end

  def learnMore
  	@who = params[:who]
  	if @who == "publisher" || @who == "pub"

  	elsif @who  == "advertiser" || @who == "adv"

  	else
  		flash[:error] = "Invalid url"
  		redirect_to root_path
  	end
  end

  private

    def login_check
      if !session[:user_id].nil? || !session[:api_key].nil?
        if session[:api_key] != User.find(session[:user_id]).get_api_key
          session.delete(:user_id)
          session.delete(:api_key)
        else
          redirect_to user_home_path
        end
      end
    end

end