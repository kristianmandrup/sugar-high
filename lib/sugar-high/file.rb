require 'sugar-high/string'

class File
  def self.blank? file_name
    raise ArgumentError, "Filename argument must not be blank" if file_name.blank?
    raise ArgumentError, "There is no file at: #{file_name}" if !File.file?(file_name)
    File.zero?(file_name)
  end
  
  def blank?
    File.zero?(self.path)
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