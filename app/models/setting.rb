class Setting < ActiveRecord::Base
  validates_presence_of :resource, :key, :value
  validates_uniqueness_of :key, :scope => [:resource]
  
  scope :resource, lambda { |resource| where("settings.resource = ?", resource) }
  scope :application, resource(RESOURCE_ID)
  scope :key, lambda { |key| where("settings.key = ?", key) }
  
  def self.value(key)
    self.key(key).first.value
  end
end
