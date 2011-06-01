module SugarHigh
  module FileMutate
    module AppendContent
      def append content=nil, &block
        File.append self.path, content, &block
      end

      module ClassMethods
        def append path, content=nil, &block
          File.open(path, 'a') do |f|
            f.puts content ||= yield
          end
        end 
      end
    end
  end
end
