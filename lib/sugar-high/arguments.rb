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
  last = args.flatten.last
  last.kind_of?(Hash) ? last : {}    
end
