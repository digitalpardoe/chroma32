# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

unless File.basename( $0 ) == "rake"
  registered_types = []
  Document.all.each do |document|
    if !document.extension.blank? && !document.content_type.blank? && !registered_types.include?(document.extension)
      Mime::Type.register document.content_type, document.extension.to_sym
      registered_types << document.extension
    end
  end
end

# Registering useful MIME types for theming.
Mime::Type.register 'image/gif', :gif
Mime::Type.register 'application/x-shockwave-flash', :swf
