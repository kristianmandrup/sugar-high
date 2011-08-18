require 'spec_helper'
require 'rails'
require 'sugar-high/string'

describe "SugarHigh" do
  describe 'String pack' do

    before do
      @s = %q{
      class Abc
        def begin

        end
      end}

      @s = %q{
      class Abc
        def begin

        end
      blip}
    end


    describe 'String class methods' do
      describe 'letters' do
        it "should return lowercase ASCII letters" do
          String.letters.should include('a', 'z')
        end

        it "should return lowercase ASCII letters" do
          String.letters(:upper).should include('A', 'Z')
        end
      end

      describe 'random_letters' do
        it "should return random lowercase ASCII letters" do
          String.random_letters(2).join.should match /[a-z]+/
        end

        it "should return lowercase ASCII letters" do
          String.random_letters(2, :upper).join.should match /[A-Z]+/
        end
      end
    end

    describe 'trim' do
      it "should work and not conflict with rails" do
        " ab ".trim.should == "ab"
      end
    end

    describe 'concats' do
      it "should work and not conflict with rails" do
        "a".concats("x", :y, "z").should == "axyz"
      end
    end

    describe '#insert_before_last' do
      it "should insert '# hello' before last end (default)" do
        @s.insert_before_last('  # hello').should match /# hello\s*end/
      end

      it "should insert '# hello' before last 'blip' (explicit String marker)" do
        @s.insert_before_last('  # hello', 'blip').should match /# hello\s*blip/
      end

      it "should insert '# hello' before last 'blip' (explicit Symbol marker)" do
        @s.insert_before_last('  # hello', :blip).should match /# hello\s*blip/
      end

      it "should insert '# hello' before last 'blip' (explicit Hash-String marker)" do
        @s.insert_before_last('  # hello', :marker => 'blip').should match /# hello\s*blip/
      end

      it "should insert '# hello' before last 'blip' (explicit Hash-Symbol marker)" do
        @s.insert_before_last('  # hello', :marker => :blip).should match /# hello\s*blip/
      end
    end
  end
end
