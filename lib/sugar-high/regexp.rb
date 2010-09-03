class String 
  def to_regexp
    Regexp.escape(self)
  end
end

class Regexpr
  def to_regexp
    self
  end
end