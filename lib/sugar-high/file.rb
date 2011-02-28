require 'sugar-high/blank'
require 'sugar-high/arguments'
require 'sugar-high/path'
require 'sugar-high/regexp'
require 'sugar-high/string'
require 'sugar-high/file_mutate'

class File   
  def self.blank? file_name
    raise ArgumentError, "Filename argument must not be blank" if file_name.blank?
    raise ArgumentError, "There is no file at: #{file_name}" if !File.file?(file_name)
    File.zero?(file_name)
  end
  
  def blank?
    File.zero?(self.path)
  end   

  def self.has_content? file_name, content_matcher, &block
    File.new(file_name).has_content? content_matcher, &block  
  end

  def has_content? content_matcher = nil, &block  
    content_matcher ||= yield
    begin
      content_matcher = content_matcher.to_regexp
    rescue
      raise ArgumentError, "Content match must be specified as either a String or Regexp"
    end
    !(self.read =~ content_matcher).nil?
  end

  def read_content options = {}, &block
    File.read_from self.path, options, &block
  end
  alias_method :with_content, :read_content

  class << self

    def read_from file_name, options = {}, &block
      raise ArgumentError, "File to read from not found or not a file: #{file_name}" if !File.file? file_name
      content = File.read file_name
    
      if options[:before] 
        begin
          regexp = options[:before].to_regexp
          index = content.match(regexp).offset_before
          content = content[0..index]
        rescue
          raise ArgumentError, ":before option must be a string or regular expression, was : #{options[:before]}"
        end
      end 

      if options[:after]   
        begin
          regexp = options[:after].to_regexp
          index = content.match(regexp).offset_after
          content = content[index..-1]      
        rescue
          raise ArgumentError, ":after option must be a string or regular expression, was : #{options[:after]}"
        end      
      end
      yield content if block
      content
    end
    alias_method :read_content_from, :read_from
    alias_method :with_content_from, :read_from
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
    return File.new(self) if File.file?(self)
    raise "No file found at #{self}"
  end

  def dir
    return Directory.new(self) if File.directory?(self)
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

class Symbol
  def as_filename
    self.to_s.underscore  
  end
  
  def valid_file_command?
    [:read, :remove, :delete].include? self
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
