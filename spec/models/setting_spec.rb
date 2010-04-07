require 'spec_helper'

describe Setting do
  it "should not save without resource" do
    setting = Setting.new(Setting.plan(:resource => nil))
    lambda { setting.save! }.should raise_error(ActiveRecord::RecordInvalid)
  end
 
  it "should not save without key" do
    setting = Setting.new(Setting.plan(:key => nil))
    lambda { setting.save! }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should not save without value" do
    setting = Setting.new(Setting.plan(:value => nil))
    lambda { setting.save! }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should not save duplicate key in one resource space" do
    setting = Setting.plan
    Setting.new(setting).save!
    lambda { Setting.new(setting).save! }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should return the value for a key" do
    setting = Setting.make
    Setting.resource(setting.resource).value(setting.key).should == setting.value
  end
  
  it "should persist the settings change" do
    settings = []
    (1..5).each { |i| settings << Setting.make(:resource => RESOURCE_ID) }
    
    params = {}
    settings.each do |setting|
      params = params.merge( { setting.key => setting.value } )
    end
    
    params.each do |key,value|
      params[key] = "value"
    end
    
    settings = Setting::Composite.new(params)
    settings.save
    
    params.each do |key,value|
      Setting.application.value(key).should == "value"
    end
  end
end
