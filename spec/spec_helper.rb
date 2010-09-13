require 'rspec'
require 'sugar-high'

RSpec.configure do |config|
  
end

def fixtures_dir
  File.dirname(__FILE__) + '/fixtures'
end

def fixture_file name
  File.join(fixtures_dir, name)
end