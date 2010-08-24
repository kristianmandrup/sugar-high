require 'active_support/inflector'

def modules *module_names, &block
  module_names.flatten.each do |name|
    class_eval %{
      module #{name.to_s.camelize}
        #{yield block if block}
      end
    }    
  end
end 

def nested_modules *module_names, &block
  module_names.flatten.inject([]) do |res, name|  
    res << %{
      module #{name.to_s.camelize}
        #{yield block if block}
      end}  
  end.flatten.join("\n")
end

