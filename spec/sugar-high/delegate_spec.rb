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
