require 'spec_helper'

describe Catalog do
  it "should create a new catalog" do
    lambda { Catalog.create(Catalog.plan) }.should change(Catalog, :count).by(1)
  end
  
  it "should not create a new catalog" do
    lambda { Catalog.make(:name => nil) }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should retrieve the root catalog" do
    Catalog.root.name.should == 'root'
  end
  
  it "should allow deletion of the catalog" do
    catalog = Catalog.make
    lambda { catalog.destroy }.should change(Catalog, :count).by(-1)
  end
  
  it "should not allow deletion of the 'root' catalog" do
    lambda { Catalog.root.destroy }.should raise_error(ActiveRecord::ActiveRecordError)
  end
  
  it "should cascade delete catalogs" do
    catalog = Catalog.make
    Catalog.make(:catalog_id => catalog.id)
    lambda { catalog.destroy }.should change(Catalog, :count).by(-2)
  end
end
