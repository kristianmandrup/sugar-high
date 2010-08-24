# Sugar high!

Named in honor of the bailouts after 2008 crisis which led to a temporary 'sugar-high' in the markets. Inspired by the 'zucker' project.

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

### File

* self.blank? and blank? : Is file empty? 

String:
* path : expand String with path operations :up and :down

PathString:
* up lv   : Go up some directory levels, prefixing with a number of '../'
* down lv : Go down some directory levels, stripping off a number of prefixed '../'

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

### String

* blank?

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
