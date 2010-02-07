class Document < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :size
  validates_presence_of :content_type
  
  belongs_to :catalog
  
  attr_accessor :document
  
  def before_validation
    file_ext = File.extname(File.basename(document.original_filename)).gsub(".","")
    file_name = File.basename(document.original_filename, file_ext).chomp(".")
    
    
    self.name = file_name
    self.extension = file_ext
    self.content_type = document.content_type
    
    File.open(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"), "wb") { |f| f.write(document.read) }
    
    self.size = File.size(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"))
  end
end
