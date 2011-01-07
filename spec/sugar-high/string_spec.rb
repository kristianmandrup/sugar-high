require 'spec_helper'
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
