require 'spec_helper'
require 'sugar-high/arguments'

describe "SugarHigh" do
  describe "Arguments" do
    
    context 'Symbol' do
      it "should return arg list with 'hello'" do
        :hello.args.should == ['hello']
      end
    end
    
    context 'String' do
      it "should return arg list with 'hello'" do
        :hello.args.should == ['hello']
      end
    end

    context 'Array' do
      it "should return arg list with 'hello', 'you'" do
        [:hello, ['you']].args.should == ['hello', 'you']
      end
    end

    describe "Last argument" do
      context 'Last arg with default hello' do
        it "should return the default :hello" do
          last_arg(:hello, 3,4).should == :hello
        end

        it "should return the :hello => 'abe' " do
          last_arg({:hi => :def}, 3,4, :hi => 'abe').should == {:hi => 'abe'}
        end
      end
    end

    describe "Last option" do
      context 'Last arg is Hash' do
        it "should return the last hash" do
          last_option(3,4, :x => 3, :y => 5).should == {:x => 3, :y => 5} 
        end
      end

      context 'Last arg is NOT Hash' do
        it "should return an empty hash" do
          last_option(3,4,3).should == {} 
        end
      end
    end      
  end
end

