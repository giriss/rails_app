class Advert < ActiveRecord::Base
	self.inheritance_column = nil
	serialize :answers, Array
	has_one :advert_detail
end
