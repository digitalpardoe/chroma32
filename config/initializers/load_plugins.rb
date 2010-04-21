# Limit this 'require' to when the application is initialised from the 'rails' command
Dir["#{PLUGINS_DIR}/**/generators/*.rb"].each {|f| require f} if File.basename( $0 ) == "rails"

module Plugins
  class Helper
    def self.find_plugins(directory)
      plugin_config = {}
      
      # Store the configuration information for each plugin in the hash
      Dir.glob(File.join(directory, '*')).each do |path|
        plugin_config = plugin_config.merge( { File.basename(path).to_sym => File.open(File.join(path, 'config', 'config.yml')) { |yf| YAML::load( yf ) } } )
      end
      
      plugin_config
    end
  end
end

PLUGIN_CONFIG = Plugins::Helper.find_plugins(PLUGINS_DIR)
INACTIVE_PLUGIN_CONFIG = Plugins::Helper.find_plugins(INACTIVE_PLUGINS_DIR)