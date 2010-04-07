require 'spec_helper'

describe Role do
  it "should not create a new role" do
    lambda { Role.create!(:name => nil) }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should not allow duplicate names" do
    role = Role.make
    lambda { Role.create!(:name => role.name) }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should not allow mass assignment of hidden attribute" do
    role = Role.create!(:name => 'Test', :hidden => true)
    role.hidden.should == false
  end
end
