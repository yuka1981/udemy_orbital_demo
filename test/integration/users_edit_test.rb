require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:reid)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    patch user_path(@user), params: { user: { name: '', email: 'reid@example', password: 'pass', password_confirmation: 'word' } }
    assert_template 'users/edit'
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user) # log_in_as method need to be defined in test helper file
    # assert_template 'users/edit'
    assert_redirected_to edit_user_path(@user) # freindly forwarding

    name = 'Touya'
    email = 'touaylin@gmail.com'
    patch user_path(@user), params: { user: { name: name, email: email, password: '', password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @user

    @user.reload # reload user information from database
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
