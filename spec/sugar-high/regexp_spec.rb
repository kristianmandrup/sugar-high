require 'spec_helper'
require 'sugar-high/regexp'

describe "SugarHigh" do
  describe 'Regexp pack' do

    describe 'String#to_regexp' do
      it "should convert string to Regexp" do
        'hello'.to_regexp.should be_a_kind_of Regexp
      end
    end

    describe 'Regexp#to_regexp' do
      it "should return itself as a regexp" do
        /hello/.to_regexp.should be_a_kind_of Regexp
      end
    end

    describe 'Array#grep_it' do
      it "should grep using a regexp" do
        ['hello', 'hello you', 'not you'].grep_it(/hello/).size.should == 2
        ['hello', 'hello you', 'not you'].grep_it('hello').size.should == 2        
        ['hello', 'hello you', 'not you'].grep_it(nil).size.should == 3                
      end
    end
  end
end
