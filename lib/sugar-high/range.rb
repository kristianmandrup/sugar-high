class Range  
  def intersection(other)  
    raise ArgumentError, 'value must be a Range' unless other.kind_of?(Range)  
  
    min, max = first, exclude_end? ? max : last  
    other_min, other_max = other.first, other.exclude_end? ? other.max : other.last  
  
    new_min = self === other_min ? other_min : other === min ? min : nil  
    new_max = self === other_max ? other_max : other === max ? max : nil  
  
    new_min && new_max ? new_min..new_max : nil  
  end

  def intersect(other)  
    raise ArgumentError, 'value must be a Range' unless other.kind_of?(Range)  

    new_min = self.cover?(other.min) ? other.min : other.cover?(min) ? min : nil  
    new_max = self.cover?(other.max) ? other.max : other.cover?(max) ? max : nil  

    new_min && new_max ? new_min..new_max : nil  

  rescue # if above doesn't work for ruby version
    intersection(other)
  end  
  alias_method :&, :intersect
end
