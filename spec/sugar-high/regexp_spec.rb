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
  end
end
