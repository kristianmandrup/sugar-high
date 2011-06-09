# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sugar-high}
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kristian Mandrup}]
  s.date = %q{2011-06-09}
  s.description = %q{More Ruby sugar - inspired by the 'zuker' project}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".rspec",
    "LICENSE",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "lib/sugar-high.rb",
    "lib/sugar-high/alias.rb",
    "lib/sugar-high/arguments.rb",
    "lib/sugar-high/array.rb",
    "lib/sugar-high/blank.rb",
    "lib/sugar-high/class_ext.rb",
    "lib/sugar-high/enumerable.rb",
    "lib/sugar-high/file.rb",
    "lib/sugar-high/file_ext.rb",
    "lib/sugar-high/file_mutate.rb",
    "lib/sugar-high/file_mutate/append_content.rb",
    "lib/sugar-high/file_mutate/delete.rb",
    "lib/sugar-high/file_mutate/insert_content.rb",
    "lib/sugar-high/file_mutate/mutate.rb",
    "lib/sugar-high/file_mutate/overwrite_content.rb",
    "lib/sugar-high/file_mutate/remove_content.rb",
    "lib/sugar-high/file_mutate/replace_content.rb",
    "lib/sugar-high/hash.rb",
    "lib/sugar-high/includes.rb",
    "lib/sugar-high/kind_of.rb",
    "lib/sugar-high/metaclass.rb",
    "lib/sugar-high/methods.rb",
    "lib/sugar-high/module.rb",
    "lib/sugar-high/not.rb",
    "lib/sugar-high/path.rb",
    "lib/sugar-high/properties.rb",
    "lib/sugar-high/regexp.rb",
    "lib/sugar-high/rspec/configure.rb",
    "lib/sugar-high/rspec/matchers/have_aliases.rb",
    "lib/sugar-high/string.rb",
    "sandbox/test_routes_mutate.rb",
    "spec/fixtures/application_file.rb",
    "spec/fixtures/class_file.rb",
    "spec/fixtures/class_file.txt",
    "spec/fixtures/content_file.txt",
    "spec/fixtures/empty.txt",
    "spec/fixtures/file.txt",
    "spec/fixtures/non-empty.txt",
    "spec/fixtures/routes_file.rb",
    "spec/fixtures/search_file.txt",
    "spec/spec_helper.rb",
    "spec/sugar-high/alias_spec.rb",
    "spec/sugar-high/arguments_spec.rb",
    "spec/sugar-high/array_spec.rb",
    "spec/sugar-high/blank_spec.rb",
    "spec/sugar-high/class_ext_spec.rb",
    "spec/sugar-high/file/file_dsl_spec.rb",
    "spec/sugar-high/file_mutate/append_content_spec.rb",
    "spec/sugar-high/file_mutate/delete_spec.rb",
    "spec/sugar-high/file_mutate/insert_before_last_spec.rb",
    "spec/sugar-high/file_mutate/insert_content_spec.rb",
    "spec/sugar-high/file_mutate/overwrite_content_spec.rb",
    "spec/sugar-high/file_mutate/remove_content_spec.rb",
    "spec/sugar-high/file_mutate/replace_content_spec.rb",
    "spec/sugar-high/file_spec.rb",
    "spec/sugar-high/hash_spec.rb",
    "spec/sugar-high/includes_spec.rb",
    "spec/sugar-high/kind_of_spec.rb",
    "spec/sugar-high/methods_spec.rb",
    "spec/sugar-high/module_spec.rb",
    "spec/sugar-high/path_spec.rb",
    "spec/sugar-high/properties_spec.rb",
    "spec/sugar-high/regexp_spec.rb",
    "spec/sugar-high/string_spec.rb",
    "sugar-high.gemspec"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/sugar-high}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Ruby convenience sugar packs!}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.5"])
    else
      s.add_dependency(%q<rspec>, [">= 2.5"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.5"])
  end
end

