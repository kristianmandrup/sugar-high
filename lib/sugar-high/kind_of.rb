require "active_support/inflector"
require "sugar-high/enumerable"

class Object
  def kinda_file?
    any_kind_of?(File, Dir)
  end

  def any_kind_of? *kinds
    kinds.all_kinds.each do |kind|
      return true if self.kind_of? kind
    end
    false
  end

  def not_any_kind_of? *kinds
    kinds.all_kinds.each do |kind|
      return false if self.kind_of? kind
    end
    true
  end

  def kind_of_label?
    self.any_kind_of? String, Symbol
  end

  def kind_of_number?
    self.any_kind_of? Numeric
  end


  def kind_of_symbol?
    self.any_kind_of? Symbols, Symbol
  end
end

class Kinds
  attr_accessor :kinds

  def initialize *kinds
    self.kinds = *kinds
  end
end
