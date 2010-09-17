require 'sugar-high/arguments'

class Hash
  def hash_revert
    r = Hash.new {|h,k| h[k] = []}
    each {|k,v| r[v] << k}
    r
  end 
  
  def try_keys *keys
    option = last_option keys
    keys.flatten.each do |key| 
      return self[key] if self[key]
    end    
    return option[:default] if option[:default]
    nil
  end
end
