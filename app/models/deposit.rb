class Deposit < ActiveRecord::Base
	self.inheritance_column = nil

	before_validation :add_received_amount

	validates :token, uniqueness: true, presence: true
	validates :amount, :received_amount, presence: true

	private
		def add_received_amount
			self.received_amount = 0.97 * (self.amount - 0.3)
		end
end
