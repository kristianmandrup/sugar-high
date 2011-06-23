require 'spec_helper'
require 'sugar-high/class_ext'

class Trial
  include ClassExt
end

class Hello
end

module GoodBye
  module Alpha
    module Beta
    end
  end
end

module First 
  module ClassMethods
    def class_method
    end
  end

  module InstanceMethods
    def instance_method
    end
  end
end

class Second
  include_and_extend First
end

def trial
  @trial ||= Trial.new
end

describe Object do
  describe "#autoload_modules" do
    it "should autoload modules using :from => path" do
      require 'fixtures/autoload_modules'
      AutoloadModules::Third.should respond_to(:test)
    end
    it "should autoload modules from __FILE__'s dir if :from is omitted'" do
      require 'fixtures/autoload_modulez'
      AutoloadModulez::Third.should respond_to(:test)
    end
  end
end

describe Class do

  describe "#include_and_extend" do
    it "should include class methods" do
      Second.should respond_to(:class_method)  
    end

    it "should include class methods" do
      Second.new.should respond_to(:instance_method)
    end
  end
end

describe ClassExt do
  describe '#try_module' do
    it "should return false if no module found" do
      trial.try_module('Blip').should be_false
      trial.try_module(:Blip).should be_false
      trial.try_module(nil).should be_false
    end

    it "should return module if found" do
      trial.try_module('GoodBye').should be_a(Module)
      trial.try_module(:GoodBye).should be_a(Module)       
    end

    it "should return namespaced module if found" do
      trial.try_module('GoodBye::Alpha::Beta').should be_a(Module)
    end

    it "should return false if only class of that name is found" do
      trial.try_module('Hello').should be_true
    end
  end

  describe '#try_class' do
    it "should return false if no class found" do
      trial.try_class('Blip').should be_false
      trial.try_class(:Blip).should be_false
      trial.try_class(nil).should be_false
    end

    it "should return class if found" do
      trial.try_class('Hello').should be_a(Class)
      trial.try_class(:Hello).should be_a(Class)
    end

    it "should return false if only class of that name is found" do
      trial.try_class('GoodBye').should be_false
    end
  end
  
  describe '#class_exists?' do
    it "should return false if no class found" do
      trial.class_exists?('Blip').should be_false
    end

    it "should return true if class found" do
      trial.class_exists?('Hello').should be_true
    end

    it "should return false if module found" do
      trial.class_exists?('GoodBye').should be_false
    end
  end  
  
  describe '#module_exists?' do
    it "should return false if no module found" do
      trial.module_exists?('Blip').should be_false
    end

    it "should return true if module found" do
      trial.module_exists?('GoodBye').should be_true
    end
    
    it "should return false if only class found" do
      trial.module_exists?('Hello').should be_false
    end    
  end

  describe '#try_module_only' do
    it 'should find module' do
      trial.try_module_only('Hello').should be_false
      trial.try_module_only('GoodBye').should be_true
    end
  end      

  describe '#find_first_class' do
    it 'should find first class' do
      trial.find_first_class('GoodBye', 'Hello').should == Hello
    end
    
    it 'should not find any module' do
      lambda {trial.find_first_class('Good', 'Bye') }.should raise_error
    end    
  end

  describe '#find_first_module' do
    it 'should find first module' do
      first_module = trial.find_first_module('GoodBye::Alpha::Beta', 'Hello')
      first_module.should == GoodBye::Alpha::Beta
    end

    it 'should not find any module' do
      lambda {trial.find_first_module('Good', 'Bye') }.should raise_error
    end
  end  
end
