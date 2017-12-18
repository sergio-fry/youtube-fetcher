class ProxyObject
  def initialize(real_object)
    @real_object = real_object
  end

  def method_missing(name, *args)
    @real_object.send(name, *args)
  end
end
