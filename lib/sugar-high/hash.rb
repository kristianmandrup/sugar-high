class Hash
  def hash_revert
    r = Hash.new {|h,k| h[k] = []}
    each {|k,v| r[v] << k}
    r
  end
end
