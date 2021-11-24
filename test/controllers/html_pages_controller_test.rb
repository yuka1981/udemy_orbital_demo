require 'test_helper'

class HtmlPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "Home | Orbit Feedback Application"
  end

  test "should get help" do
    get help_url
    assert_response :success
    assert_select "title", "Help | Orbit Feedback Application"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | Orbit Feedback Application"
  end

  test "should get contact" do
    get contact_url
    assert_response :success
    assert_select "title", "Contact | Orbit Feedback Application"
  end
end
