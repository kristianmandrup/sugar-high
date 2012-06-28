require 'spec_helper'
require 'sugar-high/numeric'

class Numeric
  include NumberDslExt
end

module Num
  extend NumericCheckExt
end

describe "SugarHigh" do
  describe 'NumericCheckExt' do
    describe '#numeric?' do
      it 'string "x1" is not numeric' do
        Num.numeric?("x0").should be_false
      end

      it '123 is numeric' do
        Num.numeric?(123).should be_true
      end

      it '12.3 is numeric' do
        Num.numeric?(12.3).should be_true
      end
    end

    describe 'check_numeric!' do
      it 'string "x1" is not numeric' do
        lambda {Num.check_numeric!("x0")}.should raise_error
      end

      it '123 is numeric' do
        lambda {Num.check_numeric!(123)}.should_not raise_error
      end
    end
  end

  describe 'NumberDslExt' do
    describe '#hundred' do
      it '2 hundred is 200' do
        2.hundred.should == 200
      end
    end
    describe '#thousand' do
      it '3 thousand is 3000' do
        3.thousand.should == 3000
      end
    end
  end
end
