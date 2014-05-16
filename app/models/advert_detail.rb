class AdvertDetail < ActiveRecord::Base
	belongs_to :advert
	serialize :images, Array
	def get_images_array
		images.map do |image_id|
			image = Image.find image_id
			"#{image_id}_#{image.user_id}#{image.extension}"
		end
	end
end
