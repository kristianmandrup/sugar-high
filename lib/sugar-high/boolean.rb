require 'sugar-high/array'

class Boolean
  def self.random
    [true, false].pick_one!
  end
end
