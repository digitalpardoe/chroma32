class Catalog < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to :catalogs
  has_many :catalogs, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  
  def self.root
    self.where(:name => "root").order("created_at ASC").limit(1).first
  end
  
  # TODO: Check the 'catalog' methods below out, they should be created by the
  # relationship above but appear to be missing.
  
  def catalog
    Catalog.find(self.catalog_id)
  end
  
  def catalog=(catalog)
    self.catalog_id = Catalog.find(catalog).id
  end
  
  def destroy
    if self.name == 'root' && !self.catalog
      raise ActiveRecord::ActiveRecordError, "cannot delete 'root' catalog" 
    else
      super
    end
  end
end
