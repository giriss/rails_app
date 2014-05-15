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

	after_create :digest_password
	validates :full_name, :email, :password, presence: true
	validates :full_name, length: { in: 5..50 }
	validates :email, uniqueness: true, email: true
	### Create validation for password ###

	def get_api_key
		if api_key.nil?
			api_key_ = Digest::MD5.hexdigest "USER_ID=#{id}&TIMESTAMP=#{Time.now.to_s}&RAND_NUM=#{Random.new.rand(1000)}"
			update api_key: api_key_
		else
			api_key_ = api_key
		end
		api_key_
	end

	private
		def digest_password
			self.password = Digest::MD5.hexdigest self.password
		end
end
