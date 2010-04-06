class Article < ActiveRecord::Base
  validates_presence_of :title, :body, :author
  
  belongs_to :document
end
