module Plugins
  module ActiveRecord
    def acts_as_pluggable
      PLUGIN_CONFIG.each_key do |plugin|
        # Load the correct model's extensions based on the name of the current model
        model_extension = File.join(PLUGINS_DIR, plugin.to_s, 'app', 'models', 'extensions', "#{base_class.to_s.underscore}.rb")
        eval (File.open(model_extension, "r").read) if File.exists?(model_extension)
      end
    end
  end
end

# Incoroprate my module into ActiveRecord
ActiveRecord::Base.send(:extend, Plugins::ActiveRecord)
