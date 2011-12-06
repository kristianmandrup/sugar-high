class Module
  def concerned_with(*concerns)
    concerns.each do |concern|
      require_method "#{name.underscore}/#{concern}"
    end
  end

  def include_concerns(*concerns)
    concerns.each do |concern|
      require_method "#{name.underscore}/#{concern}"
      concern_ns = [name, concern.to_s.camelize].join('::')
      self.send :include, concern_ns.constantize
      begin
        self.extend [concern_ns, 'ClassMethods'].join('::').constantize
      rescue
      end
    end
  end

  def shared_concerns(*concerns)
    concerns.each do |concern|
      require_method "shared/#{concern}"
    end
  end

  def include_shared_concerns(*concerns)
    concerns.each do |concern|
      require_method "shared/#{concern}"
      concern_ns = concern.to_s.camelize
      self.send :include, concern_ns.constantize
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

  def require_method path
    defined?(require_dependency) ? require_dependency(path) : require(path)
  end
end