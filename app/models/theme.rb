class Theme
  attr_accessor :canonical, :name, :description
  
  class << self
    def all
      themes = []
      
      # Find all the themes in the theme directory
      Dir.glob("#{THEMES_DIR}/*").each do |dir|
        theme = Theme.new
        
        # Save the theme's directory name - this is stored in the database
        # and used when calling theme resources
        theme.canonical = File.basename(dir)
        
        # Store the theme's description from the 'about' file
        theme.description = File.open(File.join(dir, 'about.textile'), "r").read.to_s
        
        # Parse the name of the theme from the first line of the description
        theme.name = theme.description.split(/\r?\n/)[0].gsub("h1.", "").strip
        themes << theme
      end
      
      themes
    end
    
    # Returns an instance of a theme with the important information
    # (canonical name) set to the query string
    def where(options = {})
      theme = Theme.new
      theme.canonical = options[:name]
      theme
    end
  end
  
  # Used simply to provide a fuller simulation of AR, not
  # strictly necessary
  def first
    self
  end
  
  # Accesses the application settings and stores the theme's canonical
  # name as the setting value
  def save
    setting = Setting.application.key("theme").first
    setting.value = self.canonical
    setting.save
  end
end