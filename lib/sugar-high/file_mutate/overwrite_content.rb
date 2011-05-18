class File  
  def overwrite content=nil, &block           
    File.overwrite self.path, content, &block
  end

  def self.overwrite file, content=nil, &block
    filepath = case file
    when PathString, String
      file
    when File
      file.path
    else
      raise ArgumentError, "Expected first argument to be a File instance or a path indicating file to overwrite"
    end
    File.open(filepath, 'w') do |f|
      f.puts content ||= yield
    end
  end
end
