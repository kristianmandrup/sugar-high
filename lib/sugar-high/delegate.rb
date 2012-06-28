class Module
  unless respond_to? :delegate
    def delegate(*methods)
      options = methods.pop
      unless options.is_a?(Hash) && to = options[:to]
        raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."
      end

      if options[:prefix] == true && options[:to].to_s =~ /^[^a-z_]/
        raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
      end

      prefix = options[:prefix] && "#{options[:prefix] == true ? to : options[:prefix]}_" || ''

      file, line = caller.first.split(':', 2)
      line = line.to_i

      methods.each do |method|
        on_nil =
          if options[:allow_nil]
            'return'
          else
            %(raise "#{self}##{prefix}#{method} delegated to #{to}.#{method}, but #{to} is nil: \#{self.inspect}")
          end
        # def customer_name(*args, &block)
        module_eval %{
          def #{prefix}#{method}(*args, &block)
            #{to}.__send__(#{method.inspect}, *args, &block)
          rescue NoMethodError
            if #{to}.nil?
              #{on_nil}
            else
              raise
            end
          end
        }
      end
    end
  end
end
