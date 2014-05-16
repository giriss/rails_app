class IntersitalController < ApplicationController
	def index
		@layout_details = {
			controller: params[:controller],
			action: params[:action],
			other_styles: [],
			other_scripts: [],
			title: 'ily.io'
		}
		if session[:skip_ad_token].nil?
			new_skip_ad = SkipAdDetail.new url_key: params[:key], start_time: Time.now.to_datetime, end_time: (Time.now + 30).to_datetime
			new_skip_ad.save
			session[:skip_ad_token] = new_skip_ad.id
		else
			current_skip_ad = SkipAdDetail.find(session[:skip_ad_token])
			current_skip_ad.url_key = params[:key]
			current_skip_ad.start_time = Time.now.to_datetime
			current_skip_ad.end_time = (Time.now + 30).to_datetime
			current_skip_ad.save
		end
	end

	def generate_ad
		@layout_details = {
			controller: params[:controller],
			action: params[:action],
			other_styles: ['intersital/generate_ad'],
			other_scripts: ['intersital/generate_ad'],
			title: 'ily.io'
		}
		advert_id = params[:id]
		#@advert = Advert.find advert_id
		@advert_detail = AdvertDetail.find_by advert_id: advert_id
		@images = @advert_detail.get_images_array
		render layout: "plain_with_background"
	end

	def generate_ad_preview
		@layout_details = {
			controller: params[:controller],
			action: params[:action],
			other_styles: ['intersital/generate_ad'],
			other_scripts: ['intersital/generate_ad'],
			title: 'ily.io'
		}
		advert_id = params[:id]
		#@advert = Advert.find advert_id
		@advert_detail = PreviewAdvertDetail.find_by advert_id: advert_id
		@images = @advert_detail.get_images_array
		render layout: "plain_with_background", template: "intersital/generate_ad"
	end

	def request_campaign
		if session[:skip_ad_token].nil?
			ret = '{"error": "unknown error"}'
		else
			skip_ad_detail = SkipAdDetail.find session[:skip_ad_token]
			if Time.now.to_datetime >= skip_ad_detail.end_time
				ret = %Q{
					{
						"question": "What is the purpose of ily.io",
						"options": ["One", "Two", "Three", "Four", "Five"]
					}
				}
			else
				ret = '{"error": "unknown error"}'
			end
		end
		render text: ret, content_type: "application/json"
	end

end