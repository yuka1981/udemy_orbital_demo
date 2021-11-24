require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Test User', email: 'test_user@example.com', password: 'password123', password_confirmation: 'password123')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '     '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'name cannot be too long' do
    @user.name = 'a' * 61
    assert_not @user.valid?
  end

  test 'email cannot be too long' do
    @user.email = "#{'a' * 255}@example.com"
    assert_not @user.valid?
  end

  test 'email validation should accept valid addreses' do
    valid_addresses = %w[tony@example.com JOHN@test.com MARY_smith-01@new.com tony.smith@example.com tony+smith@example.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should not accept invalid addreses' do
    invalid_addresses = %w[test@example,com test_at_example.com test@example. test@ex+ample.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    # duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (cannot be blank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password have a minimum length' do
    @user.password = @user.password_confirmation = 'p' * 5
    assert_not @user.valid?
  end
end
