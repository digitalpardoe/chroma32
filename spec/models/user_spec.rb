require 'spec_helper'

describe User do
  it "should not allow deletion of last admin user" do
    lambda { User.where(:email => 'example@example.com').first.destroy }.should change(User, :count).by(0)
  end
  
  it "should be an admin user" do
    user = User.make(:admin)
    user.role?(:admin).should be true
    user.role?(:client).should be true
  end
  
  it "should be a standard user" do
    user = User.make(:client)
    user.role?(:admin).should be false
    user.role?(:client).should be true
  end
  
  it "should automatically 'client' role" do
    user = User.make(:sans_role)
    user.roles.count.should > 0
  end
end
