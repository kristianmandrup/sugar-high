class Object
  def self.metaclass
    class << self; self; end
  end
end
