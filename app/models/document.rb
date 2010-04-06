class Document < ActiveRecord::Base
  validates_presence_of :document, :if => Proc.new { |document| document.signature == nil }
  validates_presence_of :name, :size, :content_type, :signature, :catalog_id, :if => Proc.new { |document| document.document != nil }
  
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
  
  PLUGIN_CONFIG.each_key do |plugin|
    model_extension = File.join(PLUGINS_DIR, plugin.to_s, 'app', 'models', 'extensions', 'document.rb')
    eval (File.open(model_extension, "r").read) if File.exists?(model_extension)
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
    
    if self.image?
      generate_thumbnail
    end
  end
  
  def save_to_disk
    unless File.exists?(DOCUMENT_CACHE)
      FileUtils.mkdir_p(DOCUMENT_CACHE)
    end
    
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
  
  def generate_thumbnail
    unless File.exists?(THUMBNAIL_CACHE)
      FileUtils.mkdir_p(THUMBNAIL_CACHE)
    end
    
    ImageScience.with_image(File.join(DOCUMENT_CACHE, "#{self.signature}")) do |img|
      img.cropped_thumbnail(100) do |thumb|
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
end
