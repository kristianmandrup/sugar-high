class File
  def replace_content options = {}, &block
    File.replace_content_from self.path, options, &block
  end

  # replaces content found at replacement_expr with content resulting from yielding block
  # File.replace_content_from 'myfile.txt', where => /HelloWorld/, with => 'GoodBye'
  def self.replace_content_from file_name, options = {}, &block
    replacement_expr = options[:where] || options[:content]
    new_content = options[:with]

    begin
      replacement_expr = replacement_expr.to_regexp
    rescue
      raise ArgumentError, "Content to be replaced must be specified as either a String or Regexp in a :where or :content option"
    end

    file = get_file file_name

    # get existing file content
    content = file.read

    # return nil if no mathing replacement found
    return nil if !(content =~ replacement_expr)

    new_content ||= yield if block

    raise ArgumentError, "Content to be replaced with must be specified as a :with option or as a block" if !new_content

    # remove content that matches expr, by replacing with empty
    mutated_content = content.gsub replacement_expr, new_content

    # write mutated content as new file
    file.overwrite mutated_content

    true # signal success!
  end
end