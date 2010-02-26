class Document < ActiveRecord::Base
  validates_presence_of :document, :if => Proc.new { |document| document.signature == nil }
  validates_presence_of :name, :size, :content_type, :signature, :catalog_id, :if => Proc.new { |document| document.document != nil }
  validates_uniqueness_of :name, :scope => [:catalog_id]
  
  belongs_to :catalog
  
  before_validation :persist_document, :on => :create
  before_destroy :cleanup_document
  
  attr_accessor :document
  
  DOCUMENT_CACHE = File.join(Rails.root, "tmp", "documents")
  
  def file
    File.join(DOCUMENT_CACHE, "#{self.signature}")
  end
  
  private
  def persist_document
    return if !document
    
    # This bit handles the uploading.
    file = File.name_and_ext(File.basename(document.original_filename))

    self.name = file[:name]
    self.extension = file[:extension]
    self.content_type = document.content_type
    
    save_to_disk
    check_duplicate_names
    register_mime_type
  end
  
  def save_to_disk
    File.open(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"), "wb") { |f| f.write(document.read) }
    self.signature = MD5.new(IO.read(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"))).hexdigest
    
    self.size = File.size(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"))
    
    File.move(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"), File.join(DOCUMENT_CACHE, "#{self.signature}"))
  end
  
  def check_duplicate_names
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
  
  def register_mime_type
    if !Mime::Type.lookup_by_extension(self.extension)
      Mime::Type.register self.content_type, self.extension
    end
  end
  
  def cleanup_document
    if Document.where(:signature => self.signature).count(:id) <= 1
      File.delete(File.join(DOCUMENT_CACHE, "#{self.signature}"))
    end
  end
end
