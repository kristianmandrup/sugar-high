$:.unshift File.dirname(__FILE__)

module AutoloadModules
  #autoload :First, 'autoload_modules/first'
  #autoload :Second, 'autoload_modules/second'
  #autoload :Third, 'autoload_modules/third'
  autoload_modules :First, :Second, :Third, :from => 'autoload_modules'
end

