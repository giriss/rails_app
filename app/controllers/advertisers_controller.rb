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

	def design_ad
		if request.post?
			@params = get_design_ad_params
			@ad = Advert.find(@params[:advert_id])
			if @ad.user_id != session[:user_id]
				redirect_to root_path
			else
				if AdvertDetail.find_by(advert_id: @params[:advert_id]).nil?
					@ad_det = AdvertDetail.new advert_id: @params[:advert_id]
				else
					@ad_det = AdvertDetail.find_by(advert_id: @params[:advert_id])
				end
				@ad.name = @params[:name]
				@ad.question = @params[:question]
				@ad.right_option = @params[:right_option]
				@ad.wrong_option1 = @params[:wrong_option1]
				@ad.wrong_option2 = @params[:wrong_option2]
				@ad.wrong_option3 = @params[:wrong_option3]
				@ad.wrong_option4 = @params[:wrong_option4]
				@ad.save
				@ad_det.ad_title = @params[:ad_title]
				@ad_det.website = @params[:website]
				@ad_det.description = @params[:description]
				@imgs_ids = Array.new
				unless @params[:image].nil?
					@images = @params[:image].values
					@images.each do |image|
						new_image = Image.new user_id: session[:user_id], extension: File.extname(image.original_filename)
						new_image.save
						file_name = "#{new_image.id}_#{session[:user_id]}#{File.extname(image.original_filename)}"
						File.open(Rails.root.join('public', 'images', 'uploads', file_name), 'wb') do |file|
							file.write(image.read)
						end
						@imgs_ids << new_image.id
					end
				end
				unless @params[:uploaded_image].nil?
					@uploaded_images = @params[:uploaded_image].values
					@uploaded_images.each do |uploaded_image|
						if uploaded_image.split("_")[1].split(".")[0].to_s == session[:user_id].to_s
							@imgs_ids << uploaded_image.split("_")[0]
						end
					end
				end
				if @imgs_ids.length > 6
					@imgs_ids = @imgs_ids[0, 5]
				end
				@ad_det.images = @imgs_ids.join(";")
				@ad_det.save
				redirect_to advertiser_create_ad_path
			end
		else
			@action = 'design_ad'
			@styles = ['design_ad']
			@scripts = ['design_ad']
			if flash[:preview_ad_id].nil?
				@ad_id = params[:id]
				@ad = Advert.find(@ad_id)
				if @ad.type.to_i != 2
					redirect_to advertiser_create_ad_path
				else
					@ad_det = AdvertDetail.new
					@ad_det = AdvertDetail.find_by advert_id: @ad_id
					if !@ad_det.nil?
						images = @ad_det.get_images_array
						@images = []
						(0..5).each do |i|
							@images << (images[i].nil? ? "" : images[i])
						end
					end
					render layout: "no_menu"
				end
			else
				@preview = true
				@params = flash[:preview_ad_details]
				@ad = Advert.find @params[:advert_id]
				@ad_det = PreviewAdvertDetail.new
				@ad_det = PreviewAdvertDetail.find_by advert_id: @params[:advert_id]
				if !@ad_det.nil?
					images = @ad_det.get_images_array
					@images = []
					(0..5).each do |i|
						@images << (images[i].nil? ? "" : images[i])
					end
				end
				render layout: "no_menu"
			end
		end
	end

	def create_ad_preview
		@action = "design_ad_preview"
		@params = get_design_ad_params
		@ad = Advert.find(@params[:advert_id])
		if @ad.user_id != session[:user_id]
			redirect_to root_path
		else
			if PreviewAdvertDetail.find_by(advert_id: @params[:advert_id]).nil?
				@ad_det = PreviewAdvertDetail.new advert_id: @params[:advert_id]
			else
				@ad_det = PreviewAdvertDetail.find_by(advert_id: @params[:advert_id])
			end
#			@ad.name = @params[:name]
#			@ad.question = @params[:question]
#			@ad.right_option = @params[:right_option]
#			@ad.wrong_option1 = @params[:wrong_option1]
#			@ad.wrong_option2 = @params[:wrong_option2]
#			@ad.wrong_option3 = @params[:wrong_option3]
#			@ad.wrong_option4 = @params[:wrong_option4]
#			@ad.save
			@ad_det.ad_title = @params[:ad_title]
			@ad_det.website = @params[:website]
			@ad_det.description = @params[:description]
			@imgs_ids = Array.new
			unless @params[:image].nil?
				@images = @params[:image].values
				@images.each do |image|
					new_image = Image.new user_id: session[:user_id], extension: File.extname(image.original_filename)
					new_image.save
					file_name = "#{new_image.id}_#{session[:user_id]}#{File.extname(image.original_filename)}"
					File.open(Rails.root.join('public', 'images', 'uploads', file_name), 'wb') do |file|
						file.write(image.read)
					end
					@imgs_ids << new_image.id
				end
			end
			unless @params[:uploaded_image].nil?
				@uploaded_images = @params[:uploaded_image].values
				@uploaded_images.each do |uploaded_image|
					if uploaded_image.split("_")[1].split(".")[0].to_s == session[:user_id].to_s
						@imgs_ids << uploaded_image.split("_")[0]
					end
				end
			end
			if @imgs_ids.length > 6
				@imgs_ids = @imgs_ids[0, 5]
			end
			@ad_det.images = @imgs_ids.join(";")
			@ad_det.save
			flash[:preview_ad_id] = @ad_det.id
			@get_design_ad_params = get_design_ad_params
			@get_design_ad_params[:image] = nil
			flash[:preview_ad_details] = @get_design_ad_params
			redirect_to advertiser_design_ad_path @params[:advert_id]
		end
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
			params.require(:create_ad).permit :name, :type, :url
		end

		def get_design_ad_params
			one_to_six = ["0", "1", "2", "3", "4", "5"]
			params.require(:design_ad).permit :advert_id, :name, :website, :ad_title, :description, :question, :right_option, :wrong_option1, :wrong_option2, :wrong_option3, :wrong_option4, :image => one_to_six, :uploaded_image => one_to_six
		end

end
