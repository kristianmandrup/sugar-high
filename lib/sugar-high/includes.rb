require 'active_support/inflector'
require 'sugar-high/array'

class Module
  [:include, :extend].each do |name|
    plural = name.to_s.pluralize
    class_eval %{
      def #{plural} *module_names
        module_names.to_symbols.each do |name|
          class_eval %{
            #{name} \#{name.to_s.camelize}
          }
        end
      end

      def #{name}_from module_name, *sub_modules
        sub_modules.to_symbols.each do |name|
          class_eval %{
            #{name} \#{module_name.to_s.camelize}::\#{name.to_s.camelize}
          }
        end
      end
    }
  end

  def includes_and_extends *module_names
    includes module_names
    extends module_names
  end

  def includes_and_extends_from module_name, *sub_modules
    includes module_name, *sub_modules
    extends module_name, *sub_modules
  end

  alias_method :extends_and_includes, :includes_and_extends
  alias_method :extends_and_includes_from, :includes_and_extends_from
end