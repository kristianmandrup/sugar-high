require 'spec_helper'
require 'sugar-high/blank'

describe "SugarHigh" do
  describe "Blank ext" do
    describe '#blank' do    
      it "nil and empty string should be blank" do
        nil.blank?.should be_true
        ''.blank?.should be_true
      end
    end
    
    describe '#wblank' do    
      it "nil and empty string should be blank" do
        nil.wblank?.should be_true
        '  '.wblank?.should be_true
      end
    end

    describe '#empty' do    
      it "nil and empty string should be empty" do
        nil.empty?.should be_true
        ''.empty?.should be_true
      end

      context 'Array' do
        it "nil and empty array should not have any" do
          nil.any?.should be_false
          [].any?.should be_false
        end
      end      
    end
  end
end
