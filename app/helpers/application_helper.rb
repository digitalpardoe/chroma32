module ApplicationHelper
  # Builds theme appropriate stylesheet link tags
  def themed_stylesheet_link_tag(args)
    result = stylesheet_link_tag(args)
    result << build_themed_resource_tags("stylesheets").html_safe
  end
  
  # Builds theme appropriate JavaScript link tags
  def themed_javascript_include_tag(args)
    result = javascript_include_tag(args)
    result << build_themed_resource_tags("javascripts").html_safe
  end
  
  # Builds plugin appropriate stylesheet link tags
  def plugin_stylesheet_link_tag
    build_plugin_resource_tags("stylesheets").html_safe
  end
  
  # Builds plugin appropriate JavaScript link tags
  def plugin_javascript_include_tag
    build_plugin_resource_tags("javascripts").html_safe
  end

  # Returns the application name from the application settings
  def application_name
    Setting.application.value("name")
  end
  
  # Builds the file path (URL) of a document object
  def file_path(document)
    document_path(document, 'file')
  end
  
  # Builds the thumbnail path (URL) of a document object
  def thumbnail_path(document)
    document_path(document, 'thumbnail')
  end
  
  # Generate user links for plugins
  def user_plugin_links
    plugin_links('user')
  end
  
  # Generate admin links for plugins
  def admin_plugin_links
    plugin_links('admin')
  end
  
  private
  
  # All the methods below are the actual implementations for the
  # methods above, the separation is present to prevent massive
  # amounts of code duplication
  
  def build_themed_resource_tags(resource)
    result = ""
    File.nested("#{THEMES_DIR}/#{Setting.application.value("theme")}/#{resource}").each do |file|
      file = File.name_and_ext(file)
      if resource == "stylesheets" then result << stylesheet_link_tag(theme_resource_path("#{resource}", file[:name], file[:extension])) end
      if resource == "javascripts" then result << javascript_include_tag(theme_resource_path("#{resource}", file[:name], file[:extension])) end
    end
    result
  end
  
  def build_plugin_resource_tags(resource)
    result = ""
    PLUGIN_CONFIG.each_key do |key|
      File.nested("#{PLUGINS_DIR}/#{key}/public/#{resource}").each do |file|
        file = File.name_and_ext(file)
        if resource == "stylesheets" then result << stylesheet_link_tag(plugin_resource_path(key, "#{resource}", file[:name], file[:extension])) end
        if resource == "javascripts" then result << javascript_include_tag(plugin_resource_path(key, "#{resource}", file[:name], file[:extension])) end
      end
    end
    result
  end
  
  def document_path(document, type)
    file_download_path(document.catalog.id, type, document.name, document.extension)
  end
  
  def plugin_links(type)
    links_public = []
    links_secure = []
    
    PLUGIN_CONFIG.each do |key, value|
      value['links'][type].each do |link|
        if !link['secure']
          links_public << link_to(link['label'], eval(link['generator'])).html_safe
        elsif link['secure'] && current_user
          links_secure << link_to(link['label'], eval(link['generator'])).html_safe
        end
      end
    end
    
    links_public + links_secure
  end
end
