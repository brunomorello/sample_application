class User < ActiveRecord::Base

	# Callbacks
	before_save { self.email = email.downcase }

	# Validations
	validates :name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, 
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: true

	has_secure_password
	validates :password, length: { minimum: 6 }
end
