class Object
  def get_methods *types
    types.inject([]) do |list, type|
      list << case type
      when :all
        get_methods(:private, :protected, :public)
      when :private, :protected, :public
        send :"#{type}_methods"
      end
      list.flatten
    end.flatten.uniq
  end
end