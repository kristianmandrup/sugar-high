class Module
  def delegate
    7
  end
end

require 'sugar-high/delegate'

class Context
end

describe 'delegate already defined' do
  specify { Context.delegate.should == 7 }
end
