require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test "is 'signup' title right" do
    get signup_path
    assert_select 'title', 'Sign Up'
  end
end
