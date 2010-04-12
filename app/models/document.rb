class Document < ActiveRecord::Base
  # Make sure the user has uploaded a file if this is obviously not an update
  validates_presence_of :document, :if => Proc.new { |document| document.signature == nil }
  
  # Make sure fields are set correctly if this is an update
  validates_presence_of :name, :size, :content_type, :signature, :catalog_id, :if => Proc.new { |document| document.document != nil }
  
  # Find all documents that are images
  scope :images, where("content_type LIKE 'image%'")
  
  belongs_to :catalog
  
  # Before validating the model on create, persist the file to
  # the filesystem
  before_validation :persist_document, :on => :create
  
  # When a model is deleted be sure to clean up the files
  # in the filesystem
  before_destroy :cleanup_document
  
  attr_accessor :document
  
  # Storage locations of documents and their thumbnails
  DOCUMENT_CACHE = File.join(Rails.root, "tmp", "documents")
  THUMBNAIL_CACHE = File.join(DOCUMENT_CACHE, "thumbnails")
  
  
  def file
    # Return the file path to the document
    File.join(DOCUMENT_CACHE, "#{self.signature}")
  end

  def thumbnail
    # Return the file path to a documents thumbnail
    File.join(THUMBNAIL_CACHE, "#{self.signature}")
  end
  
  def image?
    # Check if the current document is an image
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
    # Check the MIME type doesn't already exist before registering
    if !Mime::Type.lookup_by_extension(self.extension)
      Mime::Type.register self.content_type, self.extension
    end
  end
  
  def generate_thumbnail
    unless File.exists?(THUMBNAIL_CACHE)
      FileUtils.mkdir_p(THUMBNAIL_CACHE)
    end
    
    # Use ImageScience to create a thumbnail
    ImageScience.with_image(File.join(DOCUMENT_CACHE, "#{self.signature}")) do |img|
      img.thumbnail(400) do |thumb|
        thumb.save File.join(THUMBNAIL_CACHE, self.signature)
      end
		end
  end
  
  def cleanup_document
    # Delete the document from the filesystem if it exists nowhere
    # else in the database
    if Document.where(:signature => self.signature).count(:id) <= 1
      File.delete(File.join(DOCUMENT_CACHE, "#{self.signature}"))
      
      if self.image?
        File.delete(File.join(THUMBNAIL_CACHE, "#{self.signature}"))
      end
    end
  end
  
  # Load model extensions from plugins
  acts_as_pluggable
end
