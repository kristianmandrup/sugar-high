module NumericCheckExt
  def is_numeric? arg
    arg.is_a? Numeric
  end
  alias_method :numeric?, :is_numeric?

  def check_numeric! arg
    raise ArgumentError, "Argument must be Numeric" if !is_numeric? arg
  end  
end

module NumberDslExt   
  def thousand
    self * 1000
  end  

  def hundred
    self * 100
  end  
end

[Float, Numeric].each do |mod|
  mod.send :include, NumberDslExt
end