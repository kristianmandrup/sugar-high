module SugarHigh
  module FileExt
    module ClassMethods
      def blank? file_name
        raise ArgumentError, "Filename argument must not be blank" if file_name.blank?
        raise ArgumentError, "There is no file at: #{file_name}" if !File.file?(file_name)
        File.zero?(file_name)
      end

      def has_content? file_name, content_matcher, &block
        file = get_file file_name
        file.has_content? content_matcher, &block
      end

      def read_from file_name, options = {}, &block
        raise ArgumentError, "File to read from not found or not a file: #{file_name}" if !File.file? file_name
        content = File.read file_name

        if options[:before]
          begin
            regexp = options[:before].to_regexp
            index = content.match(regexp).offset_before
            content = content[0..index]
          rescue
            raise ArgumentError, ":before option must be a string or regular expression, was : #{options[:before]}"
          end
        end

        if options[:after]
          begin
            regexp = options[:after].to_regexp
            index = content.match(regexp).offset_after
            content = content[index..-1]
          rescue
            raise ArgumentError, ":after option must be a string or regular expression, was : #{options[:after]}"
          end
        end
        yield content if block
        content
      end
      alias_method :read_content_from, :read_from
      alias_method :with_content_from, :read_from
    end

    # instance methods

    def blank?
      File.zero?(self.path)
    end

    def has_content? content_matcher = nil, &block
      content_matcher ||= yield
      begin
        content_matcher = content_matcher.to_regexp
      rescue
        raise ArgumentError, "Content match must be specified as either a String or Regexp"
      end
      matched = self.read_content =~ content_matcher
      !(matched).nil?
    end

    def read_content options = {}, &block
      File.read_from self.path, options, &block
    end
    alias_method :with_content, :read_content
  end
end
