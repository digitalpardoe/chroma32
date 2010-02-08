class Document < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :size
  validates_presence_of :content_type
  validates_presence_of :signature
  validates_presence_of :catalog_id
  validates_uniqueness_of :name, :scope => [:catalog_id]
  
  belongs_to :catalog
  
  before_validation :persist_document, :on => :create
  
  attr_accessor :document
  
  DOCUMENT_CACHE = File.join(Rails.root, "tmp", "cache")
  
  def persist_document
    # This bit handles the uploading.
    file_ext = File.extname(File.basename(document.original_filename)).gsub(".","")
    file_name = File.basename(document.original_filename, file_ext).chomp(".")
    
    self.name = file_name
    self.extension = file_ext
    self.content_type = document.content_type
    
    File.open(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"), "wb") { |f| f.write(document.read) }
    self.signature = MD5.new(IO.read(File.join(Rails.root, "tmp", "cache", "#{self.name}.#{self.extension}"))).hexdigest
    
    self.size = File.size(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"))
    
    File.move(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"), File.join(DOCUMENT_CACHE, "#{self.signature}"))
  
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
    
    # Need to register the MIME type.
    if !Mime::Type.lookup_by_extension(file_ext)
      Mime::Type.register self.content_type, self.extension
    end
  end
  
  def before_destroy
    if Document.where(:signature => self.signature).count(:id) <= 1
      File.delete(File.join(DOCUMENT_CACHE, "#{self.signature}"))
    end
  end
  
  def file
    File.join(DOCUMENT_CACHE, "#{self.signature}")
  end
end
