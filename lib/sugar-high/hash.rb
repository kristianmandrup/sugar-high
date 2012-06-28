require 'sugar-high/arguments'

class Hash

  # http://www.dweebd.com/ruby/hash-key-rewrite/
  def rewrite mapping
    inject({}) do |rewritten_hash, (original_key, value)|
      rewritten_hash[mapping.fetch(original_key, original_key)] = value
      rewritten_hash
    end
  end

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
