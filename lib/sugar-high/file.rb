require 'sugar-high/blank'
require 'sugar-high/arguments'
require 'sugar-high/path'
require 'sugar-high/regexp'
require 'sugar-high/string'
require 'sugar-high/file_mutate'
require 'sugar-high/file_ext'

class File   
  include SugarHigh::FileExt
end

class Symbol
  def as_filename
    self.to_s.underscore
  end
  
  def valid_file_command?
    [:read, :remove, :delete].include? self
  end
  
  def file
    as_filename.file
  end  
end                 

class NilClass
  def valid_file_command?
    false
  end
end  

class Array
  def file_names ext = '*'
    self.map{|a| a.gsub( /(.*)\//, '').gsub(/\.#{Regexp.escape(ext.to_s)}/, '')}
  end
end

class String
  def as_filename
    self.underscore  
  end

  def valid_file_command?
    self.to_sym.valid_file_command?
  end

  def file
    return ::File.new(self) if ::File.file?(self)
    raise "No file found at #{self}"
  end

  def dir
    return ::Dir.new(self) if ::File.directory?(self)
    raise "No file found at #{self}"
  end

  def new_file
    begin 
      file
    rescue
      File.open(self, 'w')    
    end
  end
end

