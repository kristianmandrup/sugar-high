module RSpec
  module Sugar
  end
end

module RSpec::Sugar
  module Matchers
    class HaveAliases

      attr_reader :method, :alias_methods, :cause

      def initialize method, *alias_methods
        @method = method
        @alias_methods = alias_methods.flatten
        @cause = []
      end

      def matches? obj, options={}
        if !obj.respond_to? method
          cause << "Method ##{method} to alias does NOT exist"
          return nil
        end

        alias_methods.each do |method|
          cause << "Alias method ##{method} does NOT exist" if !is_alias? obj, alias_meth
        end
        cause.empty?
      end

      def is_alias? obj, alias_meth
        obj.respond_to? alias_meth
      end

      def cause_msg
        cause[0..3].join('.')
      end

      def failure_message
        "Expected aliases to exist, but: #{cause_msg}"
      end

      def negative_failure_message
        "Did not expect aliases to exist but, #{cause_msg}".gsub /NOT/, ''
      end
    end

    def have_aliases method, *alias_methods
      HaveAliases.new method, *alias_methods
    end
  end
end

