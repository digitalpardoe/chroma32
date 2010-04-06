Dir["#{PLUGINS_DIR}/**/generators/*.rb"].each {|f| require f} if File.basename( $0 ) == "rails"

plugin_config = {}

Dir.glob(File.join(PLUGINS_DIR, '*')).each do |path|
  plugin_config = plugin_config.merge( { File.basename(path).to_sym => File.open(File.join(path, 'config', 'config.yml')) { |yf| YAML::load( yf ) } } )
end

PLUGIN_CONFIG = plugin_config
