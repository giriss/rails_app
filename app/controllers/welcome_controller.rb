class WelcomeController < ApplicationController
  before_action :login_check, only: [:index]
  before_action :redirect_to_https, only: [:index]
  def index
  	@user = User.new
  end

  def learn_more
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
      unless session[:user_id].nil?
        redirect_to user_home_path
      end
    end

end