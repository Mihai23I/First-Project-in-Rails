require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

  test "is home title right" do
    get static_pages_home_url
    assert_select 'title', 'Home'
  end

  test "is help title right" do
    get static_pages_help_url
    assert_select 'title', 'Help'
  end

  test "is about title right" do
    get static_pages_about_url
    assert_select 'title', 'About'
  end
end
