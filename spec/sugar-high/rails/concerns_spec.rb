require 'spec_helper'
require 'rails'
require 'sugar-high/rails/concerns'
require 'active_support/dependencies'

# The same procedure as one that needed for common #require - It should know path.
$:.unshift File.dirname __FILE__

class FixtureUser
  concerned_with :scopes, :validations
  shared_concerns :associations
  include_shared_concerns :caching
end

describe "SugarHigh Rails" do
  describe "Concerns pack" do
    describe "#concerned_with" do
      it 'should require files from #{name.underscore}/#{concern}' do
        [:scopes, :validations].each do |concern|
          FixtureUser.new.should respond_to("method_from_#{concern}_concern")
        end
      end
    end 
    
    describe "#shared_concerns" do
      it 'should require files from shared/#{concern}' do
        pending "How to be with namespaces? Is such raw implementation enough? Or just drop this kind of method?"
      end
    end
   
    describe "#include_shared_concerns" do
      it 'should require and include from shared/#{concern}' do
        FixtureUser.new.should respond_to("method_from_shared_concern")
      end
    end

  end
end


