class File
  class << self
    def nested(base)
      refined_files = Array.new
      dig_files(base).each { |file| refined_files.push(file.gsub(base + "/", "")) }
      refined_files
    end
    
    def name_and_ext(file)
      file_ext = File.extname(file).gsub(".","")
      file_name = file.gsub(".#{file_ext}", "")
      
      { :name => file_name, :extension => file_ext }
    end
    
    private
    def dig_files(base)
      files = Array.new
      
      Dir.glob(base + "/*").each do |node|
        if directory?(node)
          dig_files(node).each do |inner_node|
            files.push(inner_node)
          end
        else
          files.push(node)
        end
      end
      
      files
    end
  end
end