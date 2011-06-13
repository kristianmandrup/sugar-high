module NumericCheckExt
  def is_numeric? arg
    arg.is_a? Numeric
  end  

  alias_method :is_num?, :is_numeric?

  def check_numeric! arg
    raise ArgumentError, "Argument must be Numeric" if !is_numeric? arg
  end  
end
