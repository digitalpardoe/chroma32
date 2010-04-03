class Role < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_and_belongs_to_many :users
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  scope :visible, where(:protected => false)
  scope :hidden, where(:protected => true)
  
  attr_protected :protected
  attr_readonly :protected
end
