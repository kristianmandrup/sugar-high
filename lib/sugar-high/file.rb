require 'sugar-high/blank'
require 'sugar-high/arguments'
require 'sugar-high/path'
require 'sugar-high/regexp'
require 'sugar-high/string'

class File 
  def self.delete! name
    return nil if !File.exist?(name)
    File.delete name
  end

  def self.delete_file! name
    return nil if !File.file?(name)
    File.delete name
  end
  
  def self.blank? file_name
    raise ArgumentError, "Filename argument must not be blank" if file_name.blank?
    raise ArgumentError, "There is no file at: #{file_name}" if !File.file?(file_name)
    File.zero?(file_name)
  end
  
  def blank?
    File.zero?(self.path)
  end   
  
  def self.overwrite path, content=nil, &block
    File.open(path, 'w') do |f|
      f.puts content ||= yield
    end
  end

  def self.append path, content=nil, &block
    File.open(path, 'a') do |f|
      f.puts content ||= yield
    end
  end 

  def self.remove_from file_name, content=nil, &block
    content ||= yield
    replace_content_from file_name, :content => content, :with => '', &block
  end
  
  # replaces content found at replacement_expr with content resulting from yielding block
  # File.replace_content_from 'myfile.txt', where => /HelloWorld/, with => 'GoodBye'
  def self.replace_content_from file_name, options = {}, &block
    replacement_expr = options[:where] || options[:content]
    new_content = options[:with]

    replacement_expr = case replacement_expr
    when Regexp
      replacement_expr
    when String
      /#{Regexp.escape(replacement_expr)}/
    else
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


  def self.read_from file_name, options = {}, &block
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

  def self.remove_content_from file_name, options = {}, &block
    replace_content_from file_name, options.merge(:with => ''), &block
  end   

  # TODO: Needs spec
  
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
    return nil if content.blank? || (file.read =~ /#{Regexp.escape(content)}/)

    place, marker = if options[:before] 
        [ :before, options[:before] ]
      elsif options[:before_last]
        [ :before_last, options[:before_last] ]
      else
        [ :after, options[:after] ]
    end 
    

    marker = Insert.get_marker marker

    return nil if !(File.new(file.path).read =~ /#{Regexp.escape(marker)}/)
    
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
                     
       replace_in_file file, /(#{Regexp.escape(marker)})/mi do |match|
         place == :after ? "#{match}\n  #{yield}" : "#{yield}\n  #{match}"         
       end
     end  
   
     def self.replace_in_file(path, regexp, *args, &block)
       content = File.read(path).gsub(regexp, *args, &block)
       File.open(path, 'wb') { |file| file.write(content) }
     end    
   end
end                  

class Array
  def file_names ext = '*'
    self.map{|a| a.gsub( /(.*)\//, '').gsub(/\.#{Regexp.escape(ext)}/, '')}
  end
end
