require 'test_helper'

class Admin::DocumentsControllerTest < ActionController::TestCase
  setup :admin_setup
  
  test "show page loads" do
    get :show, :catalog_id => @document.catalog.id, :id => @document.id
    assert_response :success
  end
end
