require 'test_helper'

class Admin::CatalogsControllerTest < ActionController::TestCase
  setup :admin_setup
  
  test "index page loads" do
    get :index
    assert_response :success
  end
  
  test "show page loads" do
    get :show, :id => @catalog.id
    assert_response :success
  end
end
