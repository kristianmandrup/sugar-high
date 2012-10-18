require 'sugar-high/delegate'

class Actor
  def act
    'actor'
  end
end

class Context
  delegate :act, :to => :actor

  def actor
    Actor.new
  end
end

describe 'delegate NOT already defined' do
  specify { Context.new.act.should == 'actor' }
end

class SuperRange < DelegateDecorator
  attr_accessor :range

  def initialize range
    super(range, except: ['to_s', 'to_str'])
    @range = range
  end

  def to_s
    "Super: #{range}"
  end

  def to_str
    to_s
  end
end

describe DelegateDecorator do
  subject { SuperRange.new (0..2) }

  specify {
    subject.to_s.should == "Super: 0..2"
    subject.to_str.should == "Super: 0..2"
  }

  specify { subject.min.should == subject.range.min }
  specify { subject.max.should == subject.range.max }
end
