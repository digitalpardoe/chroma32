class User < ActiveRecord::Base
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  
  def role?(role)
    roles.where(:name => role.to_s).count > 0
  end
end
