# multi_alias name, :create => :new, :insert_into => [:inject_into, :update], :read => :X_content
#                   :options => :after  
# 
# create_xxx becomes new_xxx
# insert_into_xxx becomes inject_into_xxx and update_xxx
# read_xxx becomes xxx_content (overriding default :after action to insert at the X)

require 'spec_helper'
require 'sugar-high/alias'

class Abc
  def hello_kristian
    'hello'
  end
  multi_alias :_after_ => :kristian, :hello => :howdy
end

class Xyz  
  def hello_kristian
    'hi'
  end

  multi_alias :kristian, :hello => :alloha
end

class Ged  
  def kristian_hello
    'hejsa'
  end
  
  multi_alias :_before_ => :kristian, :hello => :hejsa  
end  

describe "SugarHigh" do
  describe "Arguments" do    
    context 'hould alias :hello_kristian with :howdy_kristian ' do
      it "should find alias" do
        Abc.new.respond_to?(:howdy_kristian).should be_true
      end

      it "should find -alloha alias method for kristian" do
        Xyz.new.respond_to?(:alloha_kristian).should be_true
      end

      it "should find -hejsa alias method for kristian" do
        Ged.new.respond_to?(:kristian_hejsa).should be_true
      end
    end
  end
end
