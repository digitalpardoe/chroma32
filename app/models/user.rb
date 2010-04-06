class User < ActiveRecord::Base
  acts_as_authentic
  
  has_and_belongs_to_many :roles
  
  def role?(role)
    roles.where(:name => role.to_s).count > 0
  end
  
  before_validation :add_default_role, :on => :create
  
  def destroy
    unless self.role?(:admin) && Role.where(:name => 'admin').count <= 1
      super
    end
  end
  
  PLUGIN_CONFIG.each_key do |plugin|
    model_extension = File.join(PLUGINS_DIR, plugin.to_s, 'app', 'models', 'extensions', 'user.rb')
    eval (File.open(model_extension, "r").read) if File.exists?(model_extension)
  end
  
  private
  def add_default_role
    self.roles << Role.where(:name => 'client').limit(1).first
  end
end
