require 'Base66'

class EmailValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
			record.errors[attribute] << (options[:message] || 'is not an email')
		end
	end
end

class PasswordValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		if (value =~ /[0-9]+/).nil? || (value =~ /[a-z]+/).nil? || (value =~ /[A-Z]+/).nil?
			record.errors[attribute] << (options[:message] || "must contain at least 1 lowercase, 1 uppercase and 1 number")
		end
	end
end

class User < ActiveRecord::Base
	has_many :url
	after_validation :digest_password

	validates :full_name, :email, :password, presence: true
	validates :full_name, length: { in: 5..50 }
	validates :email, uniqueness: true, email: true
	validates :password, length: { in: 6..20 }, password: true

	def get_api_key
		user_id = self.id.to_s
		user_key = Base66.encode user_id
		api_key_1 = Digest::MD5.hexdigest user_id + user_key
		api_key_2 = Digest::MD5.hexdigest user_key + user_id
		api_key = api_key_1 + api_key_2
	end

	private
		def digest_password
			self.password = Digest::MD5.hexdigest self.password
		end
end
