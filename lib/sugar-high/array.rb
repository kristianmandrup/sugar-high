require 'sugar-high/kind_of'
require 'sugar-high/enumerable'
require 'sugar-high/path'

class Array
  def pick_one!
    index = Kernel.rand(self.size)
    self[index]
  end

  def pick num
    num.times.inject([]) {|res, x| res << pick_one!}
  end

  def without(*values)
     copy = self.dup
     values.flatten.each { |value| copy.delete(value) }
     copy
  end

  def to_symbols
    res = self.flatten.select_labels
    res = res.map{|a| a.to_s.to_sym } if res
    res || []
  end

  def to_symbols!
   self.flatten!
   self.select_labels!
   self.map!{|a| a.to_s.to_sym }
   self
  end

  def to_symbols_num
    self.flatten.map{|a| a.kind_of?(Fixnum) ? "_#{a}" : a}.map{|a| a.to_s.to_sym }
  end

  def to_symbols_num!
    self.flatten!
    self.map!{|a| a.kind_of?(Fixnum) ? "_#{a}" : a}.map!{|a| a.to_s.to_sym }
  end

  def to_symbols_uniq
    to_symbols.uniq
  end

  def to_symbols_uniq!
    self.to_symbols!.uniq!
  end

  def to_strings!
    self.flatten!
    self.select_labels!.map!(&:to_s)
  end  

  def to_strings
    self.flatten.select_labels.map(&:to_s)
  end  

  def to_filenames
    self.to_strings.map(&:underscore)
  end  

  def to_filenames!
    self.to_strings!.map!(&:underscore)
  end  

  def to_paths
    self.map(&:path)
  end

  def to_paths!
    self.map!(&:path)
    self
  end

  def file_join
    File.join(*self.flatten)
  end    

  def to_files
    self.map{|fp| fp.path.to_file }
    self.extend FilesArray    
  end

  def to_files!
    self.map!{|fp| fp.path.to_file }
    self.extend FilesArray    
  end
  
  def none?
    self.flatten.compact.empty?
  end unless [].respond_to? :none?  
  
  def flat_uniq
   self.flatten.compact.uniq
  end 

  def flat_uniq!
   self.flatten!
   self.compact!
   self.uniq!
   self
  end 

  def extract(sym)
   map { |e| e.send(sym) }
  end

  # Repeat overall-used method here, to use it without Rails
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end unless [].respond_to? :extract_options!

  def select! &block
    replace select &block
  end unless [].respond_to? :select!
end

module MathArray
  def sum
   inject( 0 ) { |sum,x| sum + x }
  end

  def mean
   (size > 0) ? sum.to_f / size : 0
  end 
end  

module FilesArray
  def delete_all!
    self.each do |f| 
      f.delete! if f.kind_of?(File)
    end
  end
end

class NilClass  
  def flat_uniq  
    []
  end
  
  def none?
    true
  end
end


