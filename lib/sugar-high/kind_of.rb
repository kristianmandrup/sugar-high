class Object
  def any_kind_of? *kinds
    kinds.each do |kind|
      return true if self.kind_of? kind
    end
    false
  end

  def kind_of_label?
    self.any_kind_of? String, Symbol          
  end
end