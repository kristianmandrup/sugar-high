require 'active_support/inflector'

class Module
  def includes *module_names
    module_names.flatten.each do |name|
      class_eval %{
        include #{name.to_s.camelize}
      }    
    end
  end 

  def extends *module_names
    module_names.flatten.each do |name|
      class_eval %{
        extend #{name.to_s.camelize}
      }    
    end
  end 

  def includes_and_extends *module_names
    includes module_names
    extends module_names
  end    

  alias_method :extends_and_includes, :includes_and_extends
end