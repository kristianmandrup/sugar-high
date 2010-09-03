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