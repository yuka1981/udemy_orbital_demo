require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test 'login with invalid information' do
  #   get login_path
  #   assert_template 'sessions/new'
  #   post login_path, params: { session: { email: ' ', password: ' ' } }
  #   assert_template 'sessions/new'
  #   assert_not flash.empty?
  #   get root_path
  #   assert flash.empty?
  # end

  # test 'login with valid emailinformation' do
  #   get login_path
  #   assert_template 'sessions/new'
  #   post login_path, params: { session: { email: @user.email, password: 'password123' } }
  #   assert_redirected_to @user
  #   follow_redirect!
  #   assert_template 'users/show'
  #   assert_select 'a[href=?]', login_path, count: 0
  #   assert_select 'a[href=?]', logout_path
  #   assert_select 'a[href=?]', user_path(@user)
  # end

  def setup
    @user = users(:reid)
  end

  test 'login with valid email/invalid password information' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: { session: { email: @user.email, password: 'invalid' } }
    assert_not logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?

    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get login_path
    assert_template 'sessions/new'

    post login_path, params: { session: { email: @user.email, password: 'password123' } }
    assert logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    delete logout_path
    assert_not logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
