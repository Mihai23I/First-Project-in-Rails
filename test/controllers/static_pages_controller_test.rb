require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup; end

  test "should get 'home'" do
    page_get 'home'
    assert_response :success
  end

  test "should get 'help'" do
    page_get 'help'
    assert_response :success
  end

  test "should get 'about'" do
    page_get 'about'
    assert_response :success
  end

  test "should get 'contact'" do
    page_get 'contact'
    assert_response :success
  end

  test "is 'home' title right" do
    page_get 'home'
    assert_select 'title', 'Home'
  end

  test "is 'help' title right" do
    page_get 'help'
    assert_select 'title', 'Help'
  end

  test "is 'about' title right" do
    page_get 'about'
    assert_select 'title', 'About'
  end

  test "is 'contact' title right" do
    page_get 'contact'
    assert_select 'title', 'Contact'
  end

  def page_get(page)
    operations = {}
    operations['about'] = -> { get static_pages_about_url }
    operations['help'] = -> { get static_pages_help_url }
    operations['home'] = -> { get static_pages_home_url }
    operations['contact'] = -> { get static_pages_contact_url }
    operations[page].call
  end
end
