require 'spec_helper'
require 'sugar-high/kind_of'

describe "SugarHigh" do
  describe "Kind of helpers" do
    describe '#any_kind_of?' do    
      context 'The number 3' do
        before do
          @obj = 3
        end
        
        it "should not be a kind of String or Symbol" do
          @obj.any_kind_of?(String, Symbol).should be_false
        end
      end

      context 'a String and a Symbol' do
        before do
          @obj_str = "Hello"
          @obj_sym = :hello
        end

        it "should return true for a String" do
          @obj_str.any_kind_of?(String, Symbol).should be_true
        end

        it "should return true for a File" do
          @obj_sym.any_kind_of?(String, Symbol).should be_true
        end
      end
    end

    describe '#kind_of_label?' do    
      before do
        @obj_str = "Hello"
        @obj_sym = :hello
      end

      it "should return true for a String" do
        @obj_str.kind_of_label?.should be_true
      end

      it "should return true for a File" do
        @obj_sym.kind_of_label?.should be_true
      end
    end
  end
end
    