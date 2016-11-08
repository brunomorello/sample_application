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

	# Encrypt the default password used in Users Fixture for Users Login Test
	# This method was copied by Rails Tutorial - Safari Books
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
end
