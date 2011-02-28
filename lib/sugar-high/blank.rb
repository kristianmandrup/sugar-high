class NilClass
  def blank?
    true
  end

  alias_method :wblank?, :blank?
  alias_method :empty?, :blank?

  def any?
    false
  end
end

class String
  def wblank?
    self.strip == ''
  end
  
  if !defined? ::Rails  
    def blank?
      self.strip == ''
    end
  end
end  


