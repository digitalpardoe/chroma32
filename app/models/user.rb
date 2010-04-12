class User < ActiveRecord::Base
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  
  # Check if user has a role
  def role?(role)
    roles.where(:name => role.to_s).count > 0
  end
  
  before_validation :add_default_role, :on => :create
  
  # Make sure last admin user cannot be destroyed
  def destroy
    unless self.role?(:admin) && Role.where(:name => 'admin').count <= 1
      super
    end
  end

  private
  # Give every user created the role of 'client'
  def add_default_role
    self.roles << Role.where(:name => 'client').limit(1).first
  end
  
  # Load model extensions from plugins
  acts_as_pluggable
end
