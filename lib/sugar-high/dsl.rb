class Object
  def with(instance, *args, &block)
    instance.instance_exec(*args, &block)
    instance
  end
end
