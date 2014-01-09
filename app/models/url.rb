require 'Base66'

class Url < ActiveRecord::Base
	belongs_to :user

	before_validation :init
	after_create :add_key

	validates :target, :user_id, :views, :unique_views, presence: true
	validates :key, uniqueness: true, length: { is: 4 }, allow_nil: true

	private
		def init
			self.user_id ||= 0
			self.views ||= 0
			self.unique_views ||= 0
		end

		def add_key
			key = Base66.encode self.id
			self.update_attributes :key => key
		end
end
