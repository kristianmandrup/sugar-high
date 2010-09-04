require 'spec_helper'
require 'sugar-high/array'

describe "SugarHigh" do
  describe "Array ext" do
    describe '#to_symbols' do    
      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        [1, 'blip', [3, "hello"]].to_symbols.should == [:blip, :hello]
      end

      it "should translate nested array of numbers and strings into symbols only array, including numbers" do
        [1, 'blip', [3, "hello"]].to_symbols(:num).should == [:_1, :blip, :_3, :hello]        
      end
    end    
    
    describe '#strings' do    
      it "should map mixed array to String only array" do
        [1, 'blip', [3, "hello"]].strings.should == ['blip']
      end    
    end
  end
end
