class User < ActiveRecord::Base
  acts_as_authentic
  
  named_scope :with_role, lambda { |role| {:conditions => "role_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  
  # This is the hash of available roles, not stored the the database (what's the point),
  # always add new roles to the end of this list or it could go horribly wrong
  ROLES = %w[admin]
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def role?(role)
    roles.include? role.to_s
  end
end
