class PreviewImage < ActiveRecord::Base
	def get_image
		"#{self.id}_#{self.user_id}#{self.extension}"
	end
end
