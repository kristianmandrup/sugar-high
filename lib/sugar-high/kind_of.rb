class Object
  def any_kind_of? *kinds
    kinds.all_kinds.each do |kind| 
      return true if self.kind_of? kind        
    end
    false
  end

  def kind_of_label?
    self.any_kind_of? String, Symbol          
  end

  def kind_of_symbol?
    self.any_kind_of? Symbols, Symbol          
  end
end

module Enumerable
  def only_kinds_of? *kinds    
    all?{|a| a.any_kind_of? *kinds }    
  end

  def only_labels?
    all?{|a| a.kind_of_label? }    
  end
  
  def select_kinds_of *kinds
    select{|a| a.any_kind_of? *kinds }
  end
  
  def all_kinds
    map do |a| 
      case a
      when Kinds
        a.kinds
      else
        a if a.kind_of?(Module)
      end
    end.compact.uniq.flatten
  end
end     

class Kinds            
  attr_accessor :kinds
  
  def initialize *kinds
    self.kinds = *kinds
  end
end