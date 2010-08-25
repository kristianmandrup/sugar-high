require 'active_support/inflector'

def includes *module_names
  module_names.flatten.each do |name|
    class_eval %{
      include #{name.to_s.camelize}
    }    
  end
end 
