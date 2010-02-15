require 'spec_helper'

describe Catalog do
  it "should create a new catalog" do
    lambda do
      Catalog.make
    end.should change(Catalog, :count).by(1)
  end
  
  it "should not create a new catalog" do
    lambda { Catalog.make(:name => nil) }.should raise_error(ActiveRecord::RecordInvalid)
  end
end