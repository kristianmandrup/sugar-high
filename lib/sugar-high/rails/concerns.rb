class << Module
  def concerned_with(*concerns)
    concerns.each do |concern|
      require_dependency "#{name.underscore}/#{concern}"
    end
  end

  def shared_concerns(*concerns)
    concerns.each do |concern|
      require_dependency "shared/#{concern}"
    end
  end

  def include_shared_concerns(*concerns)
    concerns.each do |concern|
      require_dependency "shared/#{concern}"
      self.send :include, concern.to_s.camelize.constantize
    end
  end

  alias_method :shared_concern, :shared_concerns
  alias_method :include_shared_concern, :include_shared_concerns
end
