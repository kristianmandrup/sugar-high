require 'rspec/core'
require 'sugar-high'

RSpec.configure do |config|
  # config.mock_with :mocha
end

def fixtures_dir
  File.dirname(__FILE__) + '/fixtures'
end

def fixture_file name
  File.join(fixtures_dir, name)
end