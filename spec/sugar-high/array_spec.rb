require 'spec_helper'
require 'sugar-high/array'

describe "SugarHigh" do
  describe "Array ext" do
    describe '#to_symbols' do    
      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        [1, 'blip', [3, "hello"]].to_symbols.should == [:blip, :hello]
      end

      it "should translate nested array of numbers and strings into symbols only array, including numbers" do
        [[1, 'blip', [3, "hello"]]].to_symbols(:num).should == [:_1, :blip, :_3, :hello]        
      end

      it "should translate nested array of numbers and strings into strings only array" do
        [['blip', [3, :hello]]].to_strings.should == ['blip', 'hello']        
      end
    end        
    
    describe '#to_strings' do    
      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        [1, 'blip', [3, "hello"]].to_strings.should == ['blip', 'hello']
      end      
    end    

    describe '#none?' do    
      it "should be none if no real values in array" do
        [nil, nil].none?.should be_true
        nil.none?.should be_true        
      end      
    end    
  end
end
