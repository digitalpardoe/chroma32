class Catalog < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to :catalogs
  has_many :catalogs
  has_many :documents
  
  def self.root
    self.where(:name => "root").order("created_at ASC").limit(1).first
  end
end
