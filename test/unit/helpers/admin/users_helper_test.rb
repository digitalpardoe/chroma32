require 'test_helper'

class Admin::UsersHelperTest < ActionView::TestCase
  test "roles" do
    user = User.make(:admin)
    text = roles(user)
    
    assert_equal "Admin, Client, Client", text
  end
end
