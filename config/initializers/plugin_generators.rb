Dir["#{PLUGINS_DIR}/**/generators/*.rb"].each {|f| require f} if File.basename( $0 ) == "rails"
