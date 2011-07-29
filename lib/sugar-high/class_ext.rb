require 'sugar-high/kind_of'
require 'sugar-high/array'

class Module
  def include_and_extend(the_module, options={})
    options[:instance_methods] ||= :InstanceMethods
    options[:class_methods] ||= :ClassMethods
    # Mainly include but be flexible
    main_module = const_get(the_module.to_s.to_sym)
    include main_module # for an extend_and_include method, change this to extend main_module
    include main_module.const_get(options[:instance_methods]) if main_module.const_defined?(options[:instance_methods])
    extend main_module.const_get(options[:class_methods]) if main_module.const_defined?(options[:class_methods])
  end

  def autoload_modules *args

    options = args.extract_options!
    root = options[:root] || AutoLoader.root || ''
    path = root.strip.empty? ? self.name.to_s.underscore : [root, self.name.to_s.underscore].join('/')
    from = options[:from] || path

    # Here also could be adding of the file in top of load_paths like: $:.unshift File.dirname(__FILE__)
    # It is very useful for situations of having not load_paths built Rails or Gems way.
    args.each do |req_name|
      ruby_file = req_name.to_s.underscore

      send :autoload, req_name, AutoLoader.translate("#{from}/#{ruby_file}")
    end
  end

end

module AutoLoader
  @@root = ''
  @@namespaces = {}

  def self.root
    @@root
  end

  def self.namespaces
    @@namespaces
  end

  def self.root= root
    @@root = root
  end

  def self.namespaces= namespaces
    @@namespaces = namespaces
  end

  def self.translate name
    names = name.split('/')
    names.map do |name|
      clazz_name = name.to_s.camelize
      namespaces[clazz_name.to_sym] ? namespaces[clazz_name.to_sym] : name
    end.join('/')
  end
end

module ClassExt
  def get_module name
    # Module.const_get(name)
    name.to_s.camelize.constantize
  rescue
    nil
  end

  def is_class?(clazz)
    clazz.is_a?(Class) && (clazz.respond_to? :new)
  end

  def is_module?(clazz)
    clazz.is_a?(Module) && !(clazz.respond_to? :new)
  end

  def class_exists?(name)
    is_class? get_module(name)
  rescue
    return false
  end

  def module_exists?(name)
    is_module? get_module(name)
  rescue NameError
    return false
  end

  def try_class name
    return name if name.kind_of?(Class)
    found = get_module(name) if name.kind_of_label?
    return found if found.is_a?(Class)
  rescue
    false
  end

  def try_module name
    return name if name.kind_of?(Module)
    found = get_module(name) if name.kind_of_label?
    return found if found.is_a?(Module)
  rescue
    false
  end

  def try_module_only name
    return name if is_module?(name)
    found = get_module(name) if name.kind_of_label?
    return found if is_module?(found)
  rescue
    false
  end


  def find_first_class *names
    classes = names.flatten.compact.uniq.inject([]) do |res, class_name|
      found_class = try_class(class_name.to_s.camelize)
      res << found_class if found_class
      res
    end
    raise "Not one Class for any of: #{names} is currently loaded" if classes.empty?
    classes.first
  end

  def find_first_module *names
    modules = names.flatten.compact.uniq.inject([]) do |res, class_name|
      found_class = try_module(class_name.to_s.camelize)
      res << found_class if found_class
      res
    end
    raise "Not one Module for any of: #{names} is currently loaded" if modules.empty?
    modules.first
  end
end 
