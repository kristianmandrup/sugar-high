class File
  def append content=nil, &block
    File.append self.path, content, &block
  end

  def self.append path, content=nil, &block
    File.open(path, 'a') do |f|
      f.puts content ||= yield
    end
  end 
end
