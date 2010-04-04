class Theme
  attr_accessor :canonical, :name, :description
  
  class << self
    def all
      themes = []
      
      Dir.glob("#{THEMES_DIR}/*").each do |dir|
        theme = Theme.new
        theme.canonical = File.basename(dir)
        theme.description = File.open(File.join(dir, 'about.textile'), "r").read.to_s
        theme.name = theme.description.split(/\r?\n/)[0].gsub("h1.", "").strip
        themes << theme
      end
      
      themes
    end
    
    def where(options = {})
      theme = Theme.new
      theme.canonical = options[:name]
      theme
    end
  end
  
  def first
    self
  end
  
  def save
    setting = Setting.application.key("theme").first
    setting.value = self.canonical
    setting.save
  end
end