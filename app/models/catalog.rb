class Catalog < ActiveRecord::Base
  validates_presence_of :name
  
  belongs_to :catalogs
  has_many :catalogs
  has_many :documents
end
