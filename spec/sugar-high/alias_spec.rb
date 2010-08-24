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
    'hi'
  end
  multi_alias :kristian, :hello => :howdy, :options => :after
end  

describe "SugarHigh" do
  describe "Arguments" do
    before do
      @obj = Abc.new
    end
    
    context 'Aliased :hello_kristian with :howdy_kristian ' do
      it "should find alias" do
        @obj.respond_to?(:howdy_kristian).should be_true
      end

      it "should find all methods saying 'hi' to kristian" do
        Abc.new.get_methods(:all).sort.grep(/(.*)_kristian$/).should have(2).items
      end
    end
  end
end
