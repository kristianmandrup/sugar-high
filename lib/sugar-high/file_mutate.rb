require 'sugar-high/blank'
require 'sugar-high/arguments'
require 'sugar-high/path'
require 'sugar-high/regexp'
require 'sugar-high/string'
require 'sugar-high/file'

class File
  class << self
    def delete! name
      return nil if !File.exist?(name)
      File.delete name
    end
    alias_method :delete_file!, :delete!
  end

  def delete!
    File.delete(self.path)
  end
  alias_method :delete_file!, :delete!
  
  
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

  def append content=nil, &block
    File.append self.path, content, &block
  end

  def self.append path, content=nil, &block
    File.open(path, 'a') do |f|
      f.puts content ||= yield
    end
  end 

  def remove_content options=nil, &block
    opt_str = case options
    when String
      options
    when Hash
      content = options[:content] || options[:where]
      raise ArgumentError, "Bad :content value in Hash" if !content || content.strip.empty?
      content.strip
    else
      raise ArgumentError, "non-block argument must be either String or Hash with a :content option" if !block
    end    
    content = block ? yield : opt_str
    File.remove_content_from self.path, :content => content, :with => '', &block
  end
  alias_method :remove, :remove_content

  def self.remove_from file_name, content=nil, &block
    content ||= yield
    replace_content_from file_name, :content => content, :with => '', &block
  end
   
  def self.remove_content_from file_name, options = {}, &block
    replace_content_from file_name, options.merge(:with => ''), &block
  end

  def replace_content options = {}, &block
    File.replace_content_from self.path, options, &block
  end

  # replaces content found at replacement_expr with content resulting from yielding block
  # File.replace_content_from 'myfile.txt', where => /HelloWorld/, with => 'GoodBye'
  def self.replace_content_from file_name, options = {}, &block
    replacement_expr = options[:where] || options[:content]
    new_content = options[:with]

    begin
      replacement_expr = replacement_expr.to_regexp
    rescue
      raise ArgumentError, "Content to be replaced must be specified as either a String or Regexp in a :where or :content option"
    end

    # get existing file content
    content = File.read file_name 

    # return nil if no mathing replacement found
    return nil if !(content =~ replacement_expr)

    new_content ||= yield if block

    raise ArgumentError, "Content to be replaced with must be specified as a :with option or as a block" if !new_content
  
    # remove content that matches expr, by replacing with empty
    mutated_content = content.gsub replacement_expr, new_content

    # write mutated content as new file
    File.overwrite file_name, mutated_content

    true # signal success!
  end

  def insert *args, &block
    File.insert_into self.path, *args, &block
  end
  
  # insert_into 'my_file.txt', :after => 'Blip', :content => 'Hello
  # insert_into 'my_file.txt', 'Hello', :after => 'Blip' 
  # insert_into 'my_file.txt', :after => 'Blip' do 
  #  'Hello'
  # end  
  def self.insert_into file_name, *args, &block
    options = last_option args
    content = Insert.content options, *args, &block

    file = File.new(file_name)
    return nil if !File.exist?(file)

    # already inserted?
    return nil if content.blank? 
    return nil if !options[:repeat] && (file.read =~ /#{Regexp.escape(content.to_s)}/)

    place, marker = if options[:before] 
        [ :before, options[:before] ]
      elsif options[:before_last]
        [ :before_last, options[:before_last] ]
      else
        [ :after, options[:after] ]
    end 
    

    marker = Insert.get_marker marker

    return nil if !(File.new(file.path).read =~ /#{Regexp.escape(marker.to_s)}/)
    
    Mutate.mutate_file file.path, marker, place do
       content
    end
  end   

  module Insert
   def self.get_marker marker
     marker = case marker
     when String
       Regexp.escape(marker)
     when Regexp
       marker.source  
     end
   end

   def self.content options = {}, *args, &block
     case args.first
     when String
       args.first
     when Hash
       options[:content] || (yield if block)      
     else
       return yield if block
       raise ArgumentError, "You must supply content to insert, either as a String before the options hash, a :content option or a block" 
     end     
   end
  end

  module Mutate     
   def self.mutate_file file, marker, place, &block
     raise ArgumentError, "You must define a replacement marker for a :before, :before_last or :after key" if !marker 
   
     if place == :before_last
       content = File.read(file)
       content = content.insert_before_last yield, marker
       File.open(file, 'wb') { |file| file.write(content) }         
       return
     end
                 
     replace_in_file file, /(#{Regexp.escape(marker.to_s)})/mi do |match|
       place == :after ? "#{match}\n  #{yield}" : "#{yield}\n  #{match}"         
     end
   end  

   def self.replace_in_file(path, regexp, *args, &block)
     content = File.read(path).gsub(regexp, *args, &block)
     File.open(path, 'wb') { |file| file.write(content) }
   end    
  end
end