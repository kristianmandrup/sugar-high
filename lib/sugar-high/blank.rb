class NilClass #:nodoc:
  def blank?
    true
  end
  alias_method :empty?, :blank?
end

class FalseClass #:nodoc:
  def blank?
    true
  end
end

class TrueClass #:nodoc:
  def blank?
    false
  end
end

class Array #:nodoc:
  alias_method :blank?, :empty?
end

class Hash #:nodoc:
  alias_method :blank?, :empty?
end

class String  
  def blank?
    self !~ /\S/
  end unless "".respond_to? :blank
end  


