Dir.glob("#{PLUGINS_DIR}/*").each do |dir|
  Dir.glob("#{dir}/generators/*").each do |fs_obj|
    if File.file?(fs_obj)
      require fs_obj
    end
  end
end
