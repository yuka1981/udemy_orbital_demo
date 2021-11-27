require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: 'user@invalid_email',
                                         password: 'password',
                                         password_confirmation: 'pass' } }
    end

    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Reid Lin',
                                         email: 'reidlin@example.com',
                                         password: 'password123',
                                         password_confirmation: 'password123' } }
    end
    follow_redirect!
    assert_template 'users/show'
    # 這邊的 logged_in? 是自己在 test_helper 中定義的
    assert logged_in?
  end
end
