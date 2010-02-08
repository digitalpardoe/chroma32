class Document < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :size
  validates_presence_of :content_type
  validates_presence_of :signature
  validates_presence_of :catalog_id
  validates_uniqueness_of :name, :scope => [:catalog_id]
  
  belongs_to :catalog
  
  attr_accessor :document
  
  def before_validation
    # This bit handles the uploading.
    file_ext = File.extname(File.basename(document.original_filename)).gsub(".","")
    file_name = File.basename(document.original_filename, file_ext).chomp(".")
    
    self.name = file_name
    self.extension = file_ext
    self.content_type = document.content_type
    
    File.open(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"), "wb") { |f| f.write(document.read) }
    self.signature = MD5.new(IO.read(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"))).hexdigest
    
    self.size = File.size(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"))
    
    File.move(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"), File.join(Rails.root, "tmp", "cache", "#{self.signature}"))
  
    # This bit is responsible for handling duplicate file names.
    count = 1
    name = self.name
    while (true)
      if Document.where(:name => self.name, :catalog_id => self.catalog_id).count(:id) == 1
        self.name = "#{name}-#{count}"
        count += 1
      else
        break
      end
    end
  end
end
