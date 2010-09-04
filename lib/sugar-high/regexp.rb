class String 
  def to_regexp
    /#{Regexp.escape(self)}/
  end
end

class Regexp
  def to_regexp
    self
  end
end

class Array
  def grep_it expr
    return self if !expr
    self.grep(expr.to_regexp)
  end
end