class File
  module EscapedString
    def escaped?
      true
    end
  end

  module Mutate     
    def self.mutate_file file, marker, place, &block
     raise ArgumentError, "You must define a replacement marker for a :before, :before_last or :after key" if !marker 

     file = get_file(file_name)

     if place == :before_last
       content = file.read
       content = content.insert_before_last yield, marker
       f.overwrite content
       return
     end

     marker_found = file.has_content? marker
     return nil if !marker_found

     replace_in_file file, /(#{marker})/mi do |match|
       place == :after ? "#{match}\n  #{yield}" : "#{yield}\n  #{match}"         
     end
     true
    end  

    def self.replace_in_file(file, regexp, *args, &block)
     file = get_file(file_name)
     content = file.read.gsub(regexp, *args, &block)
     f.overwrite content
    end    
  end
  
  protected

  def self.get_file file_name
    file = case file_name
    when PathString, String 
      File.new file_name
    when File
      file_name
    else
      raise ArgumentError, "Could not be converted to a File object: #{file_name}"
    end
  end  
end