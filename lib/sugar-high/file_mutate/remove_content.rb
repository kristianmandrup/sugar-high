module SugarHigh
  module FileMutate
    module RemoveContent
      def remove_content options=nil, &block
        opt_str = case options
        when String
          options
        when Hash
          content = options[:content] || options[:where]
          raise ArgumentError, "Bad :content value in Hash" if !content || content.strip.empty?
          content.strip
        else
          raise ArgumentError, "non-block argument must be either String or Hash with a :content option" if !block
        end    
        content = block ? yield : opt_str
    
        File.remove_content_from self.path, :content => content, :with => '', &block
      end
      alias_method :remove, :remove_content

      module ClassMethods
        def remove_from file_name, content=nil, &block
          content ||= yield
          replace_content_from file_name, :content => content, :with => '', &block
        end
   
        def remove_content_from file_name, options = {}, &block
          replace_content_from file_name, options.merge(:with => ''), &block
        end
      end
    end
  end
end