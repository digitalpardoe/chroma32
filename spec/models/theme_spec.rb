require 'spec_helper'

describe Theme do
  it "should list available themes" do
    Theme.all.size > 0
  end
  
  it "should return a theme of the correct name" do
    Theme.where(:name => "chroma32").first.canonical.should == "chroma32"
  end
  
  it "should change the active theme" do
    old_theme = Setting.application.value("theme")
    Theme.where(:name => "new_theme").first.save
    Setting.application.value("theme").should_not == old_theme
    Setting.application.value("theme").should == "new_theme"
  end
end
