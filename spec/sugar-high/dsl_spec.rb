require 'spec_helper'
require 'sugar-high/dsl'

describe "SugarHigh" do
  describe "DSL pack" do
    describe '#with' do
      it "should allow calls on instance in block" do
        with(Hash.new) do
          merge!(:a => 1)
          merge!(:b => 2)
        end.should == {:a => 1, :b => 2}
      end
    end
  end
end

