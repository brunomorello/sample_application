require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

	def setup
		@user = users(:bruno)
		remember(@user)
	end

	test "current_user returns right user when session in nil" do		
		assert_equal @user, current_user
		# is_logged_in? is from test_helper.rb
		assert is_logged_in?
	end

	test "current_user returns nil when remember digest wrong" do
		@user.update_attribute(:remember_digest, User.digest(User.new_token))
		assert_nil current_user
	end
end