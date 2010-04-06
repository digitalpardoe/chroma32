class Catalog < ActiveRecord::Base
  ROOT_NAME = "root"
  
  validates_presence_of :name
  validates_exclusion_of :name, :in => ROOT_NAME, :message => "is reserved", :if => Proc.new { |catalog| catalog.name }
  
  belongs_to :catalogs
  has_many :catalogs, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  
  scope :sans_root, where("name != ?", ROOT_NAME)
  
  before_validation :generate_complex_name
  
  def self.root
    self.where(:name => ROOT_NAME).order("created_at ASC").limit(1).first
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
  
  PLUGIN_CONFIG.each_key do |plugin|
    model_extension = File.join(PLUGINS_DIR, plugin.to_s, 'app', 'models', 'extensions', 'catalog.rb')
    eval (File.open(model_extension, "r").read) if File.exists?(model_extension)
  end
  
  private
  def generate_complex_name
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
end
