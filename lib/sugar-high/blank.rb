class NilClass
  def blank?
    true
  end
  alias_method :wblank?, :blank?

  def any?
    false
  end

  def empty?
    true
  end
end

class String
  def blank?
    self.empty?
  end

  def wblank?
    self.strip.blank?
  end
end  

