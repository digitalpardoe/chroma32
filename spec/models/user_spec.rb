require 'spec_helper'

describe User do
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
end