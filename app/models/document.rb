class Document < ActiveRecord::Base
  validates_presence_of :document, :if => Proc.new { |document| document.signature == nil }
  validates_presence_of :name, :size, :content_type, :signature, :catalog_id, :if => Proc.new { |document| document.document != nil }
  
  scope :images, where("content_type LIKE 'image%'")
  
  belongs_to :catalog
    
  before_validation :persist_document, :on => :create
  before_destroy :cleanup_document
  
  attr_accessor :document
  
  DOCUMENT_CACHE = File.join(Rails.root, "tmp", "documents")
  THUMBNAIL_CACHE = File.join(DOCUMENT_CACHE, "thumbnails")
  
  def file
    File.join(DOCUMENT_CACHE, "#{self.signature}")
  end
  
  def thumbnail
    File.join(THUMBNAIL_CACHE, "#{self.signature}")
  end
  
  def image?
    self.content_type =~ /image/ ? true : false
  end

  private
  def persist_document
    return if !document
    
    # Extract the file name and extension
    file = File.name_and_ext(File.basename(document.original_filename))

    self.name = file[:name]
    self.extension = file[:extension]
    self.content_type = document.content_type
    
    save_to_disk
    check_duplicate_names
    register_mime_type
    
    if self.image?
      generate_thumbnail
    end
  end
  
  def save_to_disk
    unless File.exists?(DOCUMENT_CACHE)
      FileUtils.mkdir_p(DOCUMENT_CACHE)
    end
    
    # Write the file to disk and generate the signature
    File.open(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"), "wb") { |f| f.write(document.read) }
    self.signature = MD5.new(IO.read(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"))).hexdigest
    
    # Determining the file size
    self.size = File.size(File.join(DOCUMENT_CACHE, "#{self.name}.#{self.extension}"))
    
    # Moving the file to the correct storage location (named by hash)
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
  
  def generate_thumbnail
    unless File.exists?(THUMBNAIL_CACHE)
      FileUtils.mkdir_p(THUMBNAIL_CACHE)
    end
    
    ImageScience.with_image(File.join(DOCUMENT_CACHE, "#{self.signature}")) do |img|
      img.thumbnail(400) do |thumb|
        thumb.save File.join(THUMBNAIL_CACHE, self.signature)
      end
		end
  end
  
  def cleanup_document
    if Document.where(:signature => self.signature).count(:id) <= 1
      File.delete(File.join(DOCUMENT_CACHE, "#{self.signature}"))
      
      if self.image?
        File.delete(File.join(THUMBNAIL_CACHE, "#{self.signature}"))
      end
    end
  end
  
  acts_as_pluggable
end
