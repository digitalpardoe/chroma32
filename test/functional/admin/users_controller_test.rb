require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup :admin_setup
  
  test "index page loads" do
    get :index
    assert_response :success
  end
  
  test "show page loads" do
    get :show, :id => User.all.first.id
    assert_response :success
  end
end
