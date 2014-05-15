class UsersController < ApplicationController

	before_action :login_check, only: [:home, :tools, :add_google_analytics, :destroy_google_analytics]
	before_action :redirect_to_http, only: [:home]

	def home
		# @ip = request.remote_ip      #Gets the ip of the visitor which allows to get location
		@action = 'home'
		@styles = ['home']
		@scripts = ['home']
		@new_urls = get_urls
		@announcements = Announcement.where for: %q{p}    # for: "p" || :for => "p"
	end

	def login
		@error = false
		@password = get_user_login_params[:password]
		@email    = get_user_login_params[:email]
		@find_user= User.find_by(email: @email)
		if !@find_user.nil?
			@db_pass  = @find_user.password
			if @db_pass == @password
				@user = User.find_by(email: @email)
				session[:user_id] = @user.id
			else
				@error = true
				flash[:error] = "Wrong password inserted<br />Check if caps lock is on and try again"
			end
		else
			@error = true
			flash[:error] = "Email does not exist in our database<br />Please, register first"
		end

		if @error
			redirect_to root_path
		else
			redirect_to user_home_path
		end
	end

	def logout
		session.delete(:user_id)
		redirect_to root_path
	end

	def create
		@user = User.new(get_user_register_params)
		@user.save
		if @user.errors.any?
			flash[:error] = @user.errors.full_messages.join("<br />")
		else
			session[:user_id] = @user.id
		end
		redirect_to root_path # not user_home_path since there might be errors
	end

	def referals
		render text: 'Ok'
	end

	def add_google_analytics
		@tracker_code = params.require(:google_analytics).permit(:tracker_code)[:tracker_code]
		if UserOtherDetail.find_by(user_id: session[:user_id]).nil?
			@user_add_analytics = UserOtherDetail.new({tracker_code: @tracker_code, user_id: session[:user_id]})
			@user_add_analytics.save
		else
			@current_record = UserOtherDetail.find_by(user_id: session[:user_id])
			@current_record.tracker_code = @tracker_code
			@current_record.save
		end
		redirect_to u_tools_path
	end

	def destroy_google_analytics
		if !UserOtherDetail.find_by(user_id: session[:user_id]).nil?
			@current_record = UserOtherDetail.find_by(user_id: session[:user_id])
			@current_record.destroy
			redirect_to u_tools_path
		end
	end

	def tools
		@action = 'tools'
		@styles = ['tools']
		@scripts = ['tools']
	end

	def withdraw
		@action = 'withdraw'
		@styles = []
		@scripts = []
	end

	def account
		@action = 'account'
		@styles = []
		@scripts = []
	end

	def new
	end

	def edit
	end

	def show
	end

	def update
	end

	def destroy
	end

	private

		def login_check
			if session[:user_id].nil?
				redirect_to root_path
			else
				@name = User.find(session[:user_id]).full_name
			end
		end

		def get_user_login_params
			@params = params.require(:user_login).permit(:email, :password)
			@password = Digest::MD5.hexdigest(@params[:password])
			@params[:password] = @password
			@params
		end

		def get_user_register_params
			params.require(:user_register).permit(:full_name, :email, :password)
		end

		def get_urls
			urls = Array.new
			urls = Url.where(:user_id => session[:user_id])
			new_urls = Array.new
			if urls.size > 0
				pages = 1..(urls.size / 10.0).ceil
				pages.each do |page|
					x = (page-1)*10
					array = Array.new
					if page == pages.end
						if urls.length % 10 == 0
							y = x + 9
						else
							y = x - 1 + (urls.length % 10)
						end
						(x..y).each do |i|
							array << urls[i]
						end
					else
						y = x + 9
						(x..y).each do |i|
							array << urls[i]
						end
					end
					new_urls << array
				end
			end
			new_urls
		end

end