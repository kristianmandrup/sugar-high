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
  def blank?
    self.empty?
  end

  def wblank?
    self.strip.blank?
  end
end  

