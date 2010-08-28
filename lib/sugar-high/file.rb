require 'sugar-high/blank'

class File
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
    File.open(path, 'w+') do |f|
      f.puts content ||= yield
    end
  end 
  
  # replaces content found at replacement_expr with content resulting from yielding block
  # File.replace_content_from 'myfile.txt', where => /HelloWorld/, with => 'GoodBye'
  def self.replace_content_from file_name, options = {}, &block
    replacement_expr = options[:where]
    new_content = options[:with]

    replacement_expr = case replacement_expr
    when Regexp
      replacement_expr
    when String
      /#{Regexp.escape(replacement_expr)}/
    else
      raise ArgumentError, "Content to be replaced must be specified as either a String or Regexp in a :where option"
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

  # TODO: Needs spec
  def self.remove_content_from file_name, options = {}, &block
    replace_content_from file_name, options.merge(:with => ''), &block
  end    
end                  

class Array
  def file_names ext = '*'
    self.map{|a| a.gsub( /(.*)\//, '').gsub(/\.#{Regexp.escape(ext)}/, '')}
  end
end

class String  
  def path
    self.extend PathString
  end 
end

module PathString
  def up lv
    ('../' * lv) + self
  end

  def down lv
    up_dir = Regexp.escape('../')
    orig = self.clone
    lv.times do
      self.gsub! /^#{up_dir}/, ''
      return self if self == orig
    end
    self
  end
end