# Sugar high!

Inspired by the 'zucker' project.

## Install

<code>gem install sugar-high</code>

## Usage

See specs for example use

## Update June 22, 2011

file_mutate is now backwards compatible again in order nt to break gems such as cream et. al. that depend on auto inclusion of all File extensions into
File object

## Sugar packs

* alias
* arguments
* array
* blank
* class_ext
* enumerable
* file
* file_mutate (backwards compatible)
* file_mutation
* includes
* kind_of
* math
* metaclass
* methods
* module
* not  
* numeric
* path
* properties
* reg_exp
           
### Alias

* multi_alias name, options_hash : creates multiple aliases using patterns

### Arguments

* args (Used in generator CLI testing)
* last_option *args : Returns last argument if hash or empty hash otherwise
* ...

### Array

* to_symbols
* to_symbols_uniq
* to_strings
* flat_uniq
* file_join
* ...

### Blank

* blank?

### Class Extension

* autoload_modules (by @stanislaw)

Makes it easy to autoload multiple modules by standard folder-to-module mapping convention

* is_class?
* is_module?
* class_exists?
* module_exists?
* try_class
* try_module
* try_module_only
* find_first_class(*class_names)
* find_first_module(*module_names)

### Enumerable

* only_kinds_of?(*modules)
* only_labels?
* select_kinds_of(*modules)
* select_kinds_of!
* select_labels
* select_labels!
* select_symbols
* select_symbols!
* select_uniq_symbols!
* select_strings
* select_strings!
* select_only(type)    
* select_only!(type)

### File

* self.blank? and blank? : Is file empty?
* self.overwrite : overwrite file with new content (mode = 'w')
* self.append : append to existing file with content or create new (mode = 'w+')

### File Mutate
Adds all File mutation modules to the File class

### File Mutation

Various File Mutation modules that can be added to any module or class for some nice benefits. Useful for generators fx.

Mutation modules within SugarHigh::FileMutate

* AppendContent
* Delete
* InsertContent
* OverwriteContent
* RemoveContent
* ReplaceContent

To add all mutate modules to the File class, simply:

<pre>File.mutate_ext :all</pre>

Otherwise, simply specify which ones:

<pre>File.mutate_ext :append_content, overwrite_content</pre>

### Hash

* hash_revert : Reverse keys and values
* try_keys : return value of first key that is in Hash

### Includes

* includes : Includes modules listed as symbols

### Kind of

* any_kind_of? *const_list
* kind_of_label? : Symbol or String ?

### Metaclass

* metaclass : Get the metaclass, can be used to dynamically add class singleton methods!

### Methods

* get_methods *types : Get collection of methods, fx :private and :protected (or :all)

### Module

* modules *names
* nested_modules *names

Create empty namespaces

### Not

* not

Adds the _#not_ method to Object, so you can say fx: <code>if x.not.empty?</code>

### Numeric

module _NumericCheckExt_ 

* is_numeric?(arg) - alias numeric?
* check_numeric!(arg) - raises error if argument is not numeric

module NumberDslExt added to all numeric classes (Float and Numeric)
* thousand
* hundred

<pre>
3.thousand + 2.hundred 
  => 3200  
</pre>

### Path
* String#path - extends String instance with PathString

module PathString
* to_file
* to_dir
* to_symlink

<pre>
"a/b/c".to_dir  
"a/b/c/d.rb".to_file  
</pre>

File type existance
* exists?
* file?
* dir?
* symlink?

Navigate dirs
* up
* down
* post_up
* post_down

<pre>
"a/b/c/d".up(2).should == "a/b"
"a/b/".post_up(2).should == "a/b/../../"  
"a/b/../".post_down(1).should == "a/b/"  
</pre>

### Properties

<pre>
class CruiseShip
  extend Properties

  property :direction
  property :speed, is(0..300)
end  

ship = CruiseShip.new  
ship.add_direction_listener(lambda {|x| puts "Oy... someone changed the direction to #{x}"})    
ship.speed = 200
ship.speed = 301 # outside valid range!
</pre>

### RegExp

String, RegExp
* to_regexp

<pre>"a, b /c".to_regexp # escapes it for reg exp!</pre>

MatchData
* offset_after
* offset_before

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
