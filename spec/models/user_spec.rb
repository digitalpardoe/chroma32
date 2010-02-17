require 'spec_helper'

# Patching the user class so I can more effectively manage the
# contents of the 'ROLES' constant.

class User
  quietly { ROLES = %w[admin user] }
end

describe User do
  it "should store a single user role correctly" do
    user = User.make(:user)
    user.roles.should == ['user']
  end
  
  it "should store multiple user roles correctly" do
    user = User.make(:roles => ['admin', 'user'])
    user.roles.should == ['admin', 'user']
  end
end