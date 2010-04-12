class Setting < ActiveRecord::Base
  validates_presence_of :resource, :key, :value
  validates_uniqueness_of :key, :scope => [:resource]
  
  scope :resource, lambda { |resource| where("settings.resource = ?", resource) }
  
  # Find all application settings
  scope :application, resource(RESOURCE_ID)
  scope :key, lambda { |key| where("settings.key = ?", key) }
  scope :visible, where(:hidden => false)
  scope :hidden, where(:hidden => true)
  
  attr_protected :hidden
  attr_readonly :hidden
  
  def self.value(key)
    # Return the value of a key
    self.key(key).first.value
  end
  
  # Internal class to handle marshalling of key-value pairs
  class Composite
    attr_accessor :data
    
    def initialize(parameters)
      @data = parameters
    end
    
    def save
      # Iterate through each hash element returned by the form
      @data.each do |key,value|
        
        # If the field has been blanked, ignore it, all settings
        # are there for a reason and cannot be blanked
        if value
          
          # Lookup the setting by the key of the hash element
          setting = Setting.application.key(key).first
          
          # If the setting is settable store the new setting
          if setting.hidden == false
            setting.value = value 
            setting.save
          end
        end
      end
    end
  end
  
  # Load model extensions from plugins
  acts_as_pluggable
end
