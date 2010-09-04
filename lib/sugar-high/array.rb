require 'sugar-high/kind_of'

class Array    
  def to_symbols option=nil
    res = self.flatten
    res = case option
    when :num
      res.map{|a| a.kind_of?(Fixnum) ? "_#{a}" : a}
    else      
      res.reject{|a| a.kind_of? Fixnum}
    end    
    res.map(&:to_s).map(&:to_sym)
  end  
end