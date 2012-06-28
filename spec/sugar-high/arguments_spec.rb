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

      describe '#last_arg' do
        context 'Last arg with default hello' do
          it "should return the default :hello" do
            [3,4].last_arg(:hello).should == :hello
          end

          it "should return the :hello => 'abe' " do
            [{:hi => :def}, 3, 4, {:hi => 'abe'}].last_arg.should == {:hi => 'abe'}
            [{:hi => :def}, [3,4, {:hi => 'abe'}]].last_arg.should == {:hi => 'abe'}
          end
        end
      end

      describe '#last_option' do
        it "should return the last hash" do
          [3,4, {:x => 3, :y => 5}].last_option.should == {:x => 3, :y => 5}
        end
      end

      describe "Last argument value" do
        context 'Last arg with default hello' do
          it "should return the arg value 'abe' " do
            [3,4, {:hi => 'abe'}].last_arg_value(:hi => :def).should == 'abe'
            [[3,4, {:hi => 'abe'}]].last_arg_value(:hi => :def).should == 'abe'
          end

          it "should return the arg value :def " do
            [:hello => 'abe', :good => true].last_arg_value(:hi => :def).should == :def
          end

          it "should return the arg value :def " do
            [3,4].last_arg_value(:hi => :def).should == :def
          end
        end
      end
    end

    describe "Last argument" do
      context 'Last arg with default hello' do
        it "should return the default :hello" do
          last_arg(:hello, 3,4).should == :hello
        end

        it "should return the :hello => 'abe' " do
          last_arg({:hi => :def}, 3,4, :hi => 'abe').should == {:hi => 'abe'}
          last_arg({:hi => :def}, [3,4, {:hi => 'abe'}]).should == {:hi => 'abe'}
        end
      end
    end

    describe "Last argument value" do
      context 'Last arg with default hello' do
        it "should return the arg value 'abe' " do
          last_arg_value({:hi => :def}, 3,4, :hi => 'abe').should == 'abe'
          last_arg_value({:hi => :def}, [3,4, {:hi => 'abe'}]).should == 'abe'
        end

        it "should return the arg value :def " do
          last_arg_value({:hi => :def}, :hello => 'abe', :good => true).should == :def
        end

        it "should return the arg value :def " do
          last_arg_value({:hi => :def}, 3,4 ).should == :def
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

