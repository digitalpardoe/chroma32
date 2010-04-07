require 'test_helper'

class Admin::RolesControllerTest < ActionController::TestCase
  setup :admin_setup
  
  test "index page loads" do
    get :index
    assert_response :success
  end
  
  test "show page loads" do
    get :show, :id => @role.id
    assert_response :success
  end
end
