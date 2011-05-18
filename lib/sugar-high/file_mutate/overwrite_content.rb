class File  
  def overwrite content=nil, &block           
    File.overwrite self.path, content, &block
  end

  def self.overwrite file, content=nil, &block
    File.open(get_filepath(file).path, 'w') do |f|
      f.puts content ||= yield
    end
  end
end
