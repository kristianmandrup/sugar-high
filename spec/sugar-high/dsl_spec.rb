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

      it "should allow calls on instance in block + pass *args to block" do
        with(Hash.new, 1, 2, 3) do |*args|
          merge!(:first => args.first)
          merge!(:a => 1)
          merge!(:b => 2)
        end.should == {:a => 1, :b => 2, :first => 1}
      end

      it "should allow calls on instance in block + pass options hash to block" do
        with(Hash.new, :session => 1, :request => 2, :params => 3) do |options|
          merge! options
        end.should == {:session => 1, :request => 2, :params => 3}
      end
    end
  end
end

