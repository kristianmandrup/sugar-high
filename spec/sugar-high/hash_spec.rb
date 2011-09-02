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
      it "should revert hash" do
        {:a => 'hello', :b => 'hi', :c => 'hi'}.hash_revert.should == {'hello' => [:a], 'hi' => [:b, :c]}
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
