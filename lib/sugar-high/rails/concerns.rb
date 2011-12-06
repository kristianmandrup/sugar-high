class Module
  def concerned_with(*concerns)
    options = concerns.extract_options!
    concerns.flatten.each do |concern|
      next if concern.blank?
      require_concern name, concern
    end
    shared_concerns([options[:shared]].flatten.compact)
  end

  def include_concerns(*concerns)
    options = concerns.extract_options!
    concerns.flatten.each do |concern|
      next if concern.blank?
      require_concern name, concern
      concern_ns = [name, concern.to_s.camelize].join('::')
      self.send :include, concern_ns.constantize
      begin
        self.extend [concern_ns, 'ClassMethods'].join('::').constantize
      rescue
      end
    end
    include_shared_concerns([options[:shared]].flatten.compact)
  end

  def shared_concerns(*concerns)
    concerns.flatten.each do |concern|
      next if concern.blank?
      require_shared concern
    end
  end

  def include_shared_concerns(*concerns)
    concerns.flatten.each do |concern|
      next if concern.blank?
      require_shared concern
      concern_ns = concern.to_s.camelize

      self.send :include, shared_const(concern_ns)

      begin
        self.extend [concern_ns, 'ClassMethods'].join('::').constantize
      rescue
      end
    end
  end

  alias_method :shared_concern, :shared_concerns
  alias_method :include_concern, :include_concerns
  alias_method :include_shared_concern, :include_shared_concerns

  protected

  def require_concern nane, concern
    require_method "#{name.underscore}/#{concern.to_s.underscore}"
  end

  def require_shared concern
    require_method "shared/#{concern.to_s.underscore}"
  end

  def shared_const concern_ns
    concern_ns.constantize
  rescue NameError
    shared_ns_const concern_ns
  end

  def shared_ns_const concern_ns
    const_name = "Shared::#{concern_ns}"
    const_name.constantize
  rescue NameError
    raise "No module could be found for: #{concern_ns} or #{const_name}"
  end

  def require_method path
    defined?(require_dependency) ? require_dependency(path) : require(path)
  end
end