class PreviewAdvertDetail < ActiveRecord::Base
	def get_images_array
		self.images.split(";").map do |image_id|
			image = Image.find image_id
			"#{image_id}_#{image.user_id}#{image.extension}"
		end
	end
end
