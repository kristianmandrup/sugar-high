require 'spec_helper'
require 'sugar-high/array'

describe "SugarHigh" do
  describe "Array ext" do

    describe '#to_symbols' do    
      it "should translate invalid array into empty array" do
        [1, nil].to_symbols.should == []
      end

      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        [1, 'blip', [3, "hello"]].to_symbols.should == [:blip, :hello]
      end

      it "should translate nested array of numbers and strings into symbols only array, including numbers" do
        [[1, 'blip', [3, "hello"]]].to_symbols_num.should == [:_1, :blip, :_3, :hello]        
      end

      it "should translate nested array of numbers and strings into symbols only array, including numbers" do
        [[1, 'blip', [1, "hello"]]].to_symbols_uniq.should include :blip, :hello        
      end
    end        

    describe '#to_symbols!' do    
      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        x = [1, 'hello', 'blip', [3, "hello"]].to_symbols!
        x.should include :hello, :blip
      end
      
      it "should translate invalid array into empty array" do
        x = [1, nil].to_symbols!
        x.should == []
      end      
    end
    
    describe '#to_strings' do    
      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        [1, 'blip', [3, "hello"]].to_strings.should == ['blip', 'hello']
      end      
    end    

    describe '#to_strings' do    
      it "should translate invalid array into empty array" do
        x = [1, nil].to_strings!
        x.should == []
      end      

      it "should translate nested array of numbers and strings into symbols only array, excluding numbers" do
        x = [1, 'blip', [3, "hello"]].to_strings!
        x.should == ['blip', 'hello']
      end      
    end    

    describe '#flat_uniq' do    
      it "should flatten array, remove nils and make unique" do
        [1, 'blip', ['blip', nil, 'c'], nil].flat_uniq.should == [1, 'blip', 'c']
      end      

      it "should return empty list if called on nil" do
        nil.flat_uniq.should == []
      end      
    end    

    describe '#flat_uniq!' do    
      it "should translate invalid array into empty array" do
        x = [1, nil].to_strings!
        x.should == []
      end      

      it "should flatten array, remove nils and make unique" do
        x = [1, 'blip', ['blip', nil, 'c'], nil]
        x.flat_uniq!
        x.should == [1, 'blip', 'c']
      end
    end    

    describe '#sum' do    
      it "should add elements in array" do
        [1, 2, 3].sum.should == 6
      end      
    end

    describe '#mean' do    
      it "should find mean of elements in array" do
        [1, 2, 3].mean.should == 2
      end      
    end

    describe '#extract' do    
      it "should call method on each element in array" do
        ["a", "ab", "abc"].extract(:size).mean.should == 2
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
