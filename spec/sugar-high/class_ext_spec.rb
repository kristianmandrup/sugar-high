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


def trial
  @trial ||= Trial.new
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
end