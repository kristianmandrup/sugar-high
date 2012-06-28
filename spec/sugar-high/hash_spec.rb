require 'spec_helper'
require 'sugar-high/hash'

describe "SugarHigh" do
  describe "Hash packet" do
    describe '#rewrite' do
      it 'should rewrite keys of the hash' do
        mapping = {:a => :new_a, :b => :new_b}
        {:a => 'hello', :b => 'hi', :c => 'hi'}.rewrite(mapping).should == {:new_a => 'hello', :new_b => 'hi', :c => 'hi'}
      end
    end

    describe '#hash_revert' do
      # The way 1.8.7 orders Hashes is really strange. It is hard to write straight expectation here
      it "should revert hash" do
        reverted_hash = {:a => 'hello', :b => 'hi', :c => 'hi'}.hash_revert
        reverted_hash['hello'].should == [:a]

        reverted_hash['hi'].should include :b, :c
        reverted_hash['hi'].size.should == 2
      end

      it "should try keys in hash until triggered" do
        {:a => 'hello', :b => 'hi'}.try_keys([:x, :a, :b]).should == 'hello'
      end

      it "should return nil if no key triggered" do
        {:a => 'hello', :b => 'hi'}.try_keys([:x, :y, :z]).should == nil
      end

      it "should return nil if no key triggered" do
        {:a => 'hello', :b => 'hi'}.try_keys([:x, :y, :z], :default => 'none').should == 'none'
      end
    end
  end
end
