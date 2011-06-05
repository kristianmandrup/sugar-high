module SugarHigh
  module FileMutate
    module Mutate
      module ClassMethods
        def mutate_file file, marker, place, &block
         raise ArgumentError, "You must define a replacement marker for a :before, :before_last or :after key" if !marker 

         file = File.get_file(file)

         if place == :before_last
           content = file.read
           content = content.insert_before_last yield, marker
           file.overwrite content
           return
         end

         marker_found = file.has_content? marker
         return nil if !marker_found

         replace_in_file file, /(#{marker})/mi do |match|
           place == :after ? "#{match}\n  #{yield}" : "#{yield}\n  #{match}"         
         end
         true
        end  

        def replace_in_file(file, regexp, *args, &block)
         file = File.get_file(file)
         content = file.read.gsub(regexp, *args, &block)
         file.overwrite content
        end    


        def get_file file_name
          case file_name
          when PathString, String 
            File.new file_name
          when File
            file_name
          else
            raise ArgumentError, "Could not be converted to a File object: #{file_name}"
          end
        end  

        def get_filepath file
          case file
          when PathString, String 
            file
          when File
            file.path
          else
            raise ArgumentError, "Could not be converted to a file path: #{file_name}"
          end
        end
      end 
    end  
  end
end