class Setting < ActiveRecord::Base
  validates_presence_of :resource, :key, :value
  validates_uniqueness_of :key, :scope => [:resource]
  
  scope :resource, lambda { |resource| where("settings.resource = ?", resource) }
  scope :application, resource(RESOURCE_ID)
  scope :key, lambda { |key| where("settings.key = ?", key) }
  scope :visible, where(:hidden => false)
  scope :hidden, where(:hidden => true)
  
  attr_protected :hidden
  attr_readonly :hidden
  
  def self.value(key)
    self.key(key).first.value
  end
  
  class Composite
    attr_accessor :data
    
    def initialize(parameters)
      @data = parameters
    end
    
    def save
      @data.each do |key,value|
        if value
          setting = Setting.application.key(key).first
          if setting.hidden == false
            setting.value = value 
            setting.save
          end
        end
      end
    end
  end
  
  acts_as_pluggable
end
