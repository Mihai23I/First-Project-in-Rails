require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup; end

  test "should get 'root'" do
    get root_path
    assert_response :success
  end

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
    operations['about'] = -> { get about_path }
    operations['help'] = -> { get help_path }
    operations['home'] = -> { get home_path }
    operations['contact'] = -> { get contact_path }
    operations[page].call
  end
end
