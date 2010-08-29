require 'rspec'
require 'sugar-high/matchers/have_aliases'

RSpec.configure do |config|
  config.include RSpec::Sugar::Matchers
end