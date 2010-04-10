class File
  class << self
    # Return all files held under a top level directory
    def nested(base)
      refined_files = Array.new
      dig_files(base).each { |file| refined_files.push(file.gsub(base + "/", "")) }
      refined_files
    end
    
    # Extract the file name and extension of a file into
    # a hash for simple use of the two elements
    def name_and_ext(file)
      file_ext = File.extname(file).gsub(".","")
      file_name = file.gsub(".#{file_ext}", "")
      
      { :name => file_name, :extension => file_ext }
    end
    
    private
    # Recursive method that 'digs' through a file system tree
    # recording the files it comes across
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
