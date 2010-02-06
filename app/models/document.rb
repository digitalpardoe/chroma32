class Document < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :size
  
  belongs_to :catalog
  
  attr_accessor :file
  
  def before_save
    File.open(File.join(Rails.root, "tmp", "cache", "#{id}#{file.extname}"), "wb") { |f| f.write(file.read) }
  end
end
