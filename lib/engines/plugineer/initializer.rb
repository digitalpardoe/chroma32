dir = "lib/plugins"

# Set the plugins dir, varies depending on if the 'Rails'
# variable is available
PLUGINS_DIR = Rails.root == nil ? dir : "#{Rails.root}/#{dir}"
