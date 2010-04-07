require 'test_helper'

class Admin::SettingsControllerTest < ActionController::TestCase
  setup :admin_setup
  
  test "index page loads" do
    get :index
    assert_response :success
  end
end
