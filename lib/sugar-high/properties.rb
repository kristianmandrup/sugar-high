# From: http://www.infoq.com/articles/properties-metaprogramming

module Properties
  def self.extended(base)
    base.class_eval %{
      def fire_event_for(sym, arg)
        return if !@listener[sym]
        @listener[sym].each {|l| l.call(arg) }
      end
    }
  end

  # def property(sym, &predicate)
  def property(sym, predicate=nil)
    define_method(sym) do
      instance_variable_get("@#{sym}")
    end

    define_method("#{sym}=") do |arg|
      return if !predicate.call(arg) if predicate
      instance_variable_set("@#{sym}", arg)
      fire_event_for(sym, arg)
    end

    define_method("add_#{sym}_listener") do |x|
      @listener ||= {}
      @listener[sym] ||= []
      @listener[sym] << x
    end

    define_method("remove_#{sym}_listener") do |x|
      return if !@listener[sym]
      @listener[sym].delete_at(x)
    end
  end

  def is(test)
    lambda {|val| test === val }
  end
end
