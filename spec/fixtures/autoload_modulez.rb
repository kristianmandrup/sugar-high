$:.unshift File.dirname(__FILE__)

module AutoloadModulez
  autoload_modules :First, :Second, :Third
end

