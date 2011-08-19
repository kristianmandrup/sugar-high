class Object
  def with(instance, &block)
    instance.instance_exec(&block)
    instance
  end
end
