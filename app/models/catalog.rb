class Catalog < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to :catalogs
  has_many :catalogs, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  
  def self.root
    self.where(:name => "root").order("created_at ASC").limit(1).first
  end
end
