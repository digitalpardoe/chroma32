class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  scope :unprotected, where(:protected => false)
  scope :hidden, where(:protected => true)
end
