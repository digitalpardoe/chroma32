class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  scope :visible, where(:hidden => false)
  scope :hidden, where(:hidden => true)
  
  attr_protected :hidden
  attr_readonly :hidden
  
  PLUGIN_CONFIG.each_key do |plugin|
    model_extension = File.join(PLUGINS_DIR, plugin.to_s, 'app', 'models', 'extensions', 'role.rb')
    eval (File.open(model_extension, "r").read) if File.exists?(model_extension)
  end
end
