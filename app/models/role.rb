class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  scope :visible, where(:hidden => false)
  scope :hidden, where(:hidden => true)
  
  attr_protected :hidden
  attr_readonly :hidden
  
  acts_as_pluggable
end
