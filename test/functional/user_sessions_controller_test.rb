require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  test "loads new" do
    get :new
    assert_response :success
  end
  
  test "can login" do
    put :create, :user_session => { :email => "example@example.com", :password => "changeme" }
    assert_redirected_to admin_root_path
    assert_match /success.*/, flash[:notice]
  end
  
  test "can logout" do
    put :create, :user_session => { :email => "example@example.com", :password => "changeme" }
    get :destroy
    assert_redirected_to root_path
    assert_match /success.*/, flash[:notice]
  end
end
