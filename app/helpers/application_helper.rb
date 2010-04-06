module ApplicationHelper
  def themed_stylesheet_link_tag(args)
    result = stylesheet_link_tag(args)
    result << build_resource_tags("stylesheets").html_safe
  end
  
  def themed_javascript_include_tag(args)
    result = javascript_include_tag(args)
    result << build_resource_tags("javascripts").html_safe
  end
  
  def application_name
    Setting.application.value("name")
  end
  
  def file_path(document)
    document_path(document, 'file')
  end
  
  def thumbnail_path(document)
    document_path(document, 'thumbnail')
  end
  
  def user_plugin_links
    plugin_links('user')
  end
  
  def admin_plugin_links
    plugin_links('admin')
  end
  
  private
  def build_resource_tags(resource)
    result = ""
    File.nested("#{THEMES_DIR}/#{Setting.application.value("theme")}/#{resource}").each do |file|
      file = File.name_and_ext(file)
      result << stylesheet_link_tag(theme_resource_path("#{resource}", file[:name], file[:extension]))
    end
    result
  end
  
  def document_path(document, type)
    file_download_path(document.catalog.id, type, document.name, document.extension)
  end
  
  def plugin_links(type)
    links = ""
    
    PLUGIN_CONFIG.each do |key, value|
      value['links'][type].each do |link|
        links << link_to(link['label'], eval(link['generator']))
      end
    end
    
    links.html_safe
  end
end
