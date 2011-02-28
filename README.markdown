# Sugar high!

Inspired by the 'zucker' project.

## Install

<code>gem install sugar-high</code>

## Usage

See specs for example use

## Sugar packs

* alias
* arguments
* file
* kind_of
* metaclass
* methods
* module
* string
           
### Alias

* multi_alias name, options_hash : creates multiple aliases using patterns

### Arguments

* args (Used in generator CLI testing)
* last_option *args : Returns last argument if hash or empty hash otherwise

### Hash

* hash_revert : Reverse keys and values

### File

* self.blank? and blank? : Is file empty?
* self.overwrite : overwrite file with new content (mode = 'w')
* self.append : append to existing file with content or create new (mode = 'w+')

String:
* path : expand String with path operations :up and :down

PathString:
* up lv   : Go up some directory levels, prefixing with a number of '../'
* down lv : Go down some directory levels, stripping off a number of prefixed '../'

### Includes

* includes : Includes modules listed as symbols

### Kind of

* any_kind_of? *const_list
* kind_of_label? : Symbol or String ?

### Metaclass

* metaclass : Get the metaclass

### Methods

* get_methods *types : Get collection of methods, fx :private and :protected (or :all)

### Module

* modules *names
* nested_modules *names

Create empty namespaces

### Blank

* blank?  : Empty string? (works on nil)
* wblank? : Blank including whitespace only? (works on nil)
* empty?  : array and nil
* any?    : array and nil

## RSpec 2 Matchers

* have_aliases(method, *alias_methods)  

<pre>
  require 'sugar-high/rspec'
  
  have_aliases :original, :alias_1, :alias2
</pre>

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
