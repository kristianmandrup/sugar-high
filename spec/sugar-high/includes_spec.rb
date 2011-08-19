require 'spec_helper'
require 'sugar-high/includes'

module Simple
  module X
    def x
      'x'
    end
  end

  module Y
    def y
      'y'
    end
  end

  includes :x, :y
end

class Xman
  include Simple
end

describe "SugarHigh" do
  describe "Includes ext" do
    describe '#includes' do
      it "should include namespaces X and Y" do
        Xman.new.respond_to?(:x).should be_true
        Xman.new.respond_to?(:y).should be_true
      end
    end
  end
end
