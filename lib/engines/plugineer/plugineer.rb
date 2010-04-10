class Plugineer < Rails::Engine
  # Load the initialization file, performed in this manner as it required
  # both by this file and on the initialization path of the main application
  eval (File.open(initializer = File.join(File.dirname(__FILE__), 'initializer.rb'), "r").read)
  
  # If we don't clear some paths first we get conflicts in the main application
  paths.config.routes = {}
  paths.lib = {}
  paths.lib.tasks = {}
  paths.config.initializers = initializer
  
  # Iterate through plugins adding their paths
  Dir.glob(File.join(PLUGINS_DIR, '*')).each do |path|
    paths.app << "#{path}/app" if File.exists?("#{path}/app")
    paths.app.views << "#{path}/app/views" if File.exists?("#{path}/app/views")
    paths.config.routes << "#{path}/config/routes.rb" if File.exists?("#{path}/config/routes.rb")
    paths.lib << "#{path}/lib" if File.exists?("#{path}/lib")
    paths.lib.tasks << "#{path}/lib/tasks" if File.exists?("#{path}/lib/tasks")
  end
end
