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

    describe '#only_kind_of?' do
      context 'labels and Fix numbers' do
        before do
          @valid_list = ["Hello", :hello, 7]
          @bad_list = [ {:a => 4}, 'blip']
        end

        it "should be true for a list of labels and Fix numbers" do
          @valid_list.only_kinds_of?(String, Symbol, Fixnum).should be_true
        end

        it "should be false for a list with a Hash" do
          @bad_list.only_kinds_of?(String, Symbol, Fixnum).should be_false
        end
      end
    end


    describe '#kind_of_label?' do
      before do
        @obj_str = "Hello"
        @obj_sym = :hello
        @label_list = [@obj_str, @obj_sym]
        @mix_list = [@obj_str, @obj_sym, 27]
      end

      it "should return true for a String" do
        @obj_str.kind_of_label?.should be_true
      end

      it "should return true for a Symbol" do
        @obj_sym.kind_of_label?.should be_true
      end

      it "should return true for a list of String and Symbols" do
        @label_list.only_labels?.should be_true
      end

      it "should return false for a list of with non-label types" do
        @mix_list.only_labels?.should be_false
      end
    end

    describe '#select_kinds_of' do
      before do
        @obj_str = "Hello"
        @obj_sym = :hello
        @label_list = [@obj_str, @obj_sym]
        @mix_list = [@obj_str, @obj_sym, 27]
      end

      it "should select all Symbols in list" do
        @label_list.select_kinds_of(Symbol).should == [:hello]
      end
    end

    context 'Symbols object' do
      describe '#select_kinds_of' do
        before do
          @obj_str = "Hello"
          @obj_sym = :hello
          @label_kinds = Kinds.new Symbol, String
          @label_list = [@obj_str, @obj_sym]
          @mix_list = [@obj_str, @obj_sym, 27]
        end

        it "should select all Symbols in list" do
          @mix_list.select_kinds_of(@label_kinds).should == ["Hello", :hello]
        end
      end
    end

    describe '#all_symbols' do
      before do
        @obj_str = "Hello"
        @obj_sym = :hello
        @label_kinds = Kinds.new Symbol, String
        @label_list = [@obj_str, @obj_sym, @label_kinds]
      end

      it "should return true for a String" do
        # puts "label_kinds: #{@label_kinds.kinds}"
        # puts "all kinds: #{@label_list.all_kinds}"
        @label_list.all_kinds.should == [Symbol, String]
      end
    end

    describe '#select_strings' do
      it "should map mixed array to String only array" do
        [1, 'blip', [3, "hello"]].select_strings.should == ['blip']
      end
    end

    describe '#select_labels' do
      it "should map mixed array to String only array" do
        [1, :blap, 'blip', [3, "hello"]].select_labels.should include(:blap, 'blip')
      end
    end

    describe '#select_only' do
      it "should map mixed array to String only array" do
        [1, :blap, 'blip', [3, "hello"]].select_only(:string).should include('blip')
      end
    end
  end
end
