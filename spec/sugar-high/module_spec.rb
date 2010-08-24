require 'spec_helper'
require 'sugar-high/module'

module Simple
  modules :x, :y    
end

module Nested
  modules :x, :y do
    nested_modules :a, :b
  end    
end

module AuthAssistant
  NAMESPACES = [:view, :controller, :model, :link, :helper]

  modules NAMESPACES
end

describe "SugarHigh" do
  describe "Module ext" do
    describe '#modules' do    
      it "should create namespaces under Simple for modules X and Y" do
        Simple::X.should_not be_nil
        Simple::Y.should_not be_nil        
      end

      it "should create namespaces under AuthAssistant for various modules" do
        AuthAssistant::View.should_not be_nil
        AuthAssistant::Helper.should_not be_nil        
      end

      it "should create namespaces under Nested for modules X and Y, and modules A and B under each of those X and Y modules" do
        Nested::X.should_not be_nil
        Nested::Y.should_not be_nil        

        Nested::X::A.should_not be_nil
        Nested::Y::A.should_not be_nil        

        Nested::X::B.should_not be_nil
        Nested::Y::B.should_not be_nil        
      end
    end
  end
end
