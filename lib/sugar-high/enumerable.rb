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

  def select_kinds_of! *kinds
    select!{|a| a.any_kind_of? *kinds }
  end

  def select_labels
    select{|a| a.kind_of_label? }
  end

  def select_labels!
    select! {|a| a.kind_of_label? }
  end


  def select_symbols
    select_only :symbol
  end

  def select_symbols!
    select_only! :symbol
  end

  def select_uniq_symbols!
    select_only!(:symbol).uniq!
  end

  def select_strings
    select_only :string
  end

  def select_strings
    select_only :string
  end

  def select_only type    
    const = type.kind_of_label? ? "#{type.to_s.camelize}".constantize : type
    select{|a| a.kind_of? const}
  end

  def select_only! type    
    const = type.kind_of_label? ? "#{type.to_s.camelize}".constantize : type
    select!{|a| a.kind_of? const}
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