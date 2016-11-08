module SessionsHelper

	# Logs in the given user.
	def log_in(user)
		session[:user_id] = user.id
	end

	# Returns the current logged-in user(if any)
	def current_user
		# Following the Ruby Convetion - Uses Memoization
		@current_user ||= User.find_by(id: session[:user_id])

		# The line above is the same:
		# @current_user = @current_user || User.find_by(id: session[:user_id])
		# if @current_user.nil?
		# 	@current_user = User.find_by(id: session[:user_id])
		# else 
		# 	@current_user
		# end
	end

	# Returns true if the user is logged-in
	def logged_in?
		!current_user.nil?
	end	

	
end
