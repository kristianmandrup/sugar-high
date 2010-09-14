class Array
  def args
    flatten.map{|a| a.args}.flatten
  end
end

class Symbol
  def args
    [to_s]
  end
end

class String
  def args
    (self =~ /\w+\s+\w+/) ? self.split : self
  end
end

def last_option *args
  default = last_arg({}, *args)
  last = args.flatten.last
  last.kind_of?(Hash) ? last : default    
end

def last_arg default, *args
  last = args.flatten.last
  last.kind_of?(Hash) ? last : default
end

def last_arg_value default, *args
  last = args.flatten.last
  res = last.kind_of?(Hash) ? last : default
  return res[default.keys.first] if default.kind_of? Hash
  res
end
