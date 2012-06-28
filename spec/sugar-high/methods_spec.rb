require 'spec_helper'
require 'sugar-high/methods'

class Abc
  def hello_kristian
    'hi'
  end

  protected

  def howdy_kristian
    'hi'
  end

  private

  def humm_kristian
    'hi'
  end
end

describe "SugarHigh" do
  describe "Methods" do
    before do
      @obj = Abc.new
    end

    it "should find all 3 methods saying 'hi' to kristian" do
      @obj.get_methods(:all).sort.grep(/(.*)_kristian$/).should have(3).items
    end

    it "should find public methods saying 'hi' to kristian" do
      @obj.get_methods(:public).sort.grep(/(.*)_kristian$/).should have(1).items
    end


    it "should find public methods saying 'hi' to kristian" do
      @obj.get_methods(:protected).sort.grep(/(.*)_kristian$/).should have(1).items
    end

    it "should find public and protected methods saying 'hi' to kristian" do
      @obj.get_methods(:public, :protected).sort.grep(/(.*)_kristian$/).should have(2).items
    end

    it "should find private and protected methods saying 'hi' to kristian" do
      @obj.get_methods(:private, :protected).sort.grep(/(.*)_kristian$/).should have(2).items
    end

    it "should find private and public methods saying 'hi' to kristian" do
      @obj.get_methods(:private, :public).sort.grep(/(.*)_kristian$/).should have(2).items
    end

    it "should find all 3 methods saying 'hi' to kristian" do
      @obj.get_methods(:private, :public, :protected).sort.grep(/(.*)_kristian$/).should have(3).items
    end
  end
end
