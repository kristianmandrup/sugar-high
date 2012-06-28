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

class MatchData
  def offset_after
    offset(0)[1] +1
  end

  def offset_before
    offset(0)[0] -1
  end
end

class Array
  def grep_it expr
    return self if !expr
    self.grep(expr.to_regexp)
  end
end