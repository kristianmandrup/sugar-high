# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

$:.unshift File.expand_path('lib', File.dirname(__FILE__))
require 'sugar-high/version'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "sugar-high"
  gem.summary = %Q{Ruby convenience sugar packs!}
  gem.description = %Q{More Ruby sugar - inspired by the 'zuker' project}
  gem.email = "kmandrup@gmail.com"
  gem.homepage = "http://github.com/kristianmandrup/sugar-high"
  gem.email = "kmandrup@gmail.com"
  gem.authors = ["Kristian Mandrup"]
  gem.version = SugarHigh::VERSION
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new


require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sugar-high #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end



