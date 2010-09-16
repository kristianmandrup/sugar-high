require 'sugar-high/kind_of'

class Array    
  def to_symbols option=nil
    res = self.flatten
    res.map!{|a| a.kind_of?(Fixnum) ? "_#{a}" : a} if option == :num
    res.select_labels.map(&:to_s).map(&:to_sym)
  end  

  def to_strings option=nil
    self.flatten.select_labels.map(&:to_s)
  end  
end