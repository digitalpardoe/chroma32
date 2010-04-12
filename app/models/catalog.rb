class Catalog < ActiveRecord::Base
  ROOT_NAME = "root"
  
  validates_presence_of :name
  
  # Checks to make sure the root catalog name is not duplicated
  validates_exclusion_of :name, :in => ROOT_NAME, :message => "is reserved", :if => Proc.new { |catalog| catalog.name }
  
  belongs_to :catalogs
  has_many :catalogs, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  
  # Find all catalogs excluding the root catalog
  scope :sans_root, where("name != ?", ROOT_NAME)
  
  # Create a complex name before model validation occurs
  before_validation :generate_complex_name
  
  def self.root
    # Find the root catalog
    self.where(:name => ROOT_NAME).order("created_at ASC").limit(1).first
  end

  # TODO: Check the 'catalog' methods below out, they should be created by the
  # relationship above but appear to be missing
  
  # The two catalog methods below create an object-based relationship
  # between a catalog and it's parent
  
  def catalog
    Catalog.find(self.catalog_id)
  end
  
  def catalog=(catalog)
    self.catalog_id = Catalog.find(catalog).id
  end
  
  def destroy
    # Ensure that the root catalog cannot be destroyed
    if self.name == ROOT_NAME && !self.catalog
      raise ActiveRecord::ActiveRecordError, "cannot delete '#{ROOT_NAME}' catalog" 
    else
      super
    end
  end
  
  private
  def generate_complex_name
    # Create a complex name (full path) for a catalog
    if self.name && self.name != ROOT_NAME
      catalog = self.catalog
      complex_name = [ self.name ]
    
      while (catalog.name != ROOT_NAME)
        complex_name << catalog.name
        catalog = catalog.catalog
      end
    
      self.complex_name = complex_name.reverse.join(" - ")
    end
  end
  
  # Load model extensions from plugins
  acts_as_pluggable
end
