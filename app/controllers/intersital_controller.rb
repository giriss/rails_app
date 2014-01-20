class IntersitalController < ApplicationController
	def index
		@action = 'index'
		@styles = ['index']
		@scripts = ['index']
	end

	def generate_ad
		@action = 'generate_ad'
		@styles = ['generate_ad']
		@scripts = ['generate_ad']
		advert_id = params[:id]
		#@advert = Advert.find advert_id
		@advert_detail = AdvertDetail.find_by advert_id: advert_id
		@images = @advert_detail.get_images_array
		render layout: "plain_with_background"
	end

	def generate_ad_preview
		@action = 'generate_ad'
		@styles = ['generate_ad']
		@scripts = ['generate_ad']
		advert_id = params[:id]
		#@advert = Advert.find advert_id
		@advert_detail = PreviewAdvertDetail.find_by advert_id: advert_id
		@images = @advert_detail.get_images_array
		render layout: "plain_with_background", template: "intersital/generate_ad"
	end
end