require 'active_support/inflector'

def modules *module_names, &block
  module_names.each do |name|
    class_eval %{
      module #{name.to_s.camelize}
        #{yield block if block}
      end
    }    
  end
end 

def nested_modules *module_names, &block
  module_names.inject([]) do |res, name|  
    res << %{
      module #{name.to_s.camelize}
        #{yield block if block}
      end}  
  end.join("\n")
end

