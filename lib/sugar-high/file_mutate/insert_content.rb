class File
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

    # no content to insert?
    return nil if content.blank? 

    file = begin
      get_file(file_name)
    rescue
      return nil
    end

    # already inserted?
    return nil if !options[:repeat] && file.has_content?(content)

    # find where to insert
    place, marker = if options[:before] 
        [ :before, options[:before] ]
      elsif options[:before_last]
        [ :before_last, options[:before_last] ]
      else
        [ :after, options[:after] ]
    end 

    marker_found = file.has_content?(marker)
    return nil if !marker_found

    # do mutation
    res = file.mutate marker, place do
       content
    end
    res
  end
  
  module Insert
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
end