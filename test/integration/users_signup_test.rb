require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
  	get signup_path

  	assert_no_difference 'User.count' do
	  	post users_path, user: { name: "",
	  	                         email:"user@inavalid",
	  	                         password: "foo",
	  	                         password_confirmation: "foo"}
  	end

  	assert_template 'users/new'
  end

  test "valid signup information" do
  	get signup_path

  	assert_difference 'User.count', 1 do
	  	post users_path, user: { name: "Example User",
	  	                         email:"user@example.com",
	  	                         password: "password",
	  	                         password_confirmation: "password"}
  	end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # Try to login before activation
    log_in_as(user)
    assert_not is_logged_in?

    # Invalid Activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?

    # Invalid Email with Valid Account Activation
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?

    # Valid Account Activation and Email
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!

  	assert_template 'users/show'
    # Method is_logged_in? was defined in test_helper
    assert is_logged_in?
  end
end
