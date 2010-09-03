require 'sugar-high/methods'
require 'sugar-high/hash'

class Module         
  
  # multi_alias name, :create => :new, :insert_into => [:inject_into, :update], :read => :X_content
  #                   :options => :after  
  # 
  # create_xxx becomes new_xxx
  # insert_into_xxx becomes inject_into_xxx and update_xxx
  # read_xxx becomes xxx_content (overriding default :after action to insert at the X)
  
  def multi_alias *args
    name = case args.first
    when Symbol, String            
      args.first.to_s
    when Hash    
      # default is :after
      args.first[:_before_] ? :before : :after
    end
    
    if name.kind_of? Symbol
      config_options = name
      options = args.first
      name = options[:"_#{name}_"]
    else
      options = args[1]
    end          
    
    raise ArgumentError, "Name of method pattern to alias not specified. Please pass name as either first argument or as :_before_ or :_after_ option" if !name

    options.delete(:_after_)
    options.delete(:_before_)
    direction = options.delete(:_direction_)
    
    options = options.hash_revert if direction == :reverse
    
    options.each_pair do |original, aliases|
      alias_methods name.to_sym, original, [aliases].flatten, config_options
    end            
  end

  def alias_methods name, original, aliases, config_options
    aliases.each do |alias_name|                       
      new_alias     = make_name(name, alias_name.to_s, config_options)
      original_name = make_name(name, original.to_s, config_options)
      begin         
        alias_method new_alias, original_name
      rescue
        raise ArgumentError, "Error creating alias for ##{original_name} with ##{new_alias}"
      end        
    end
  end

  def alias_for(original, *aliases)
    aliases.each do |alias_meth|
      class_eval "alias_method :#{alias_meth}, :#{original} if respond_to? :#{original}"  
    end
  end
  alias_method :aliases_for, :alias_for

  protected

  def make_name name, alias_name, config_options
    return alias_name.gsub(/X/, name.to_s) if alias_name =~ /X/    
    case config_options
    when :before
      "#{name}_#{alias_name}"
    else # default
      "#{alias_name}_#{name}"
    end
  end
end