# multi_alias name, :create => :new, :insert_into => [:inject_into, :update], :read => :X_content
#                   :options => :after
#
# create_xxx becomes new_xxx
# insert_into_xxx becomes inject_into_xxx and update_xxx
# read_xxx becomes xxx_content (overriding default :after action to insert at the X)

require 'spec_helper'
require 'sugar-high/alias'

class Abc
  def hello_kristian
    'hello'
  end
  multi_alias :_after_ => :kristian, :hello => :howdy
end

class Xyz
  def hello_kristian
    'hi'
  end

  multi_alias :kristian, :hello => :alloha
end

class Ged
  def kristian_hello
    'hejsa'
  end

  multi_alias :_before_ => :kristian, :hejsa => :hello, :_direction_ => :reverse
end

class Plural
  def monster
    'monster'
  end

  alias_for :monster, :pluralize => true
end

class Plural2
  def monster
    'monster'
  end

  alias_for :monster, :beast, :pluralize => true
end


class Singular
  def monsters
    'monsters'
  end

  alias_for :monsters, :singularize => true
end

class Singular2
  def monsters
    'monsters'
  end

  alias_for :monsters, :beasts, :singularize => true
end


class AliasHash
  def monsters
    'monsters'
  end

  def monster
    'monster'
  end


  alias_hash :monsters => :beasts, :singularize => true
end


class Wow
  REGISTRATION_LINKS = {
    :new_registration => :sign_up,
    :edit_registration => :edit_profile
  }

  # new_registration_link, edit_registration_link
  REGISTRATION_LINKS.keys.each do |name|
    puts "name: #{name}"
    class_eval %{
      def #{name}_link
      end
    }
  end
  multi_alias REGISTRATION_LINKS.merge(:_after_ => :link)
end

describe "SugarHigh" do
  describe "Arguments" do
    context 'should alias :hello_kristian with :howdy_kristian ' do
      it "should find alias" do
        Abc.new.respond_to?(:howdy_kristian).should be_true
      end
    end

    it "should find -alloha alias method for kristian" do
      Xyz.new.respond_to?(:alloha_kristian).should be_true
    end

    it "should find -hejsa alias method for kristian" do
      Ged.new.respond_to?(:kristian_hejsa).should be_true
    end

    it "should find singularized alias" do
      Singular.new.respond_to?(:monster).should be_true
    end

    it "should find singularized alias" do
      Singular2.new.respond_to?(:beast).should be_true
    end

    it "should find pluralized alias" do
      Plural.new.respond_to?(:monsters).should be_true
    end

    it "should find pluralized alias" do
      Plural2.new.respond_to?(:beasts).should be_true
    end

    it "should find nice aliases from using alias_hash" do
      ah = AliasHash.new
      ah.beasts.should == 'monsters'
      ah.beast.should == 'monster'
    end


    it "should find alias methods!" do
      w = Wow.new
      w.respond_to?(:new_registration_link).should be_true
      w.respond_to?(:sign_up_link).should be_true
    end
  end
end
