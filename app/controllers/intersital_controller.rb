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
		render layout: "plain_with_background"
	end
end
