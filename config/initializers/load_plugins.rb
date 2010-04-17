# Limit this 'require' to when the application is initialised from the 'rails' command
Dir["#{PLUGINS_DIR}/**/generators/*.rb"].each {|f| require f} if File.basename( $0 ) == "rails"

plugin_config = {}

# Store the configuration information for each plugin in the hash
Dir.glob(File.join(PLUGINS_DIR, '*')).each do |path|
  plugin_config = plugin_config.merge( { File.basename(path).to_sym => File.open(File.join(path, 'config', 'config.yml')) { |yf| YAML::load( yf ) } } )
end

# Turn the hash into an application constant
PLUGIN_CONFIG = plugin_config
