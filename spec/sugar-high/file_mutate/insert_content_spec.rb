require 'spec_helper'
require 'sugar-high/file_mutate'

describe "Insert content" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:class_file)      { fixture_file 'class_file.rb'} 
  let(:routes_file)     { fixture_file 'routes_file.rb' }  
  let(:app_file)        { fixture_file 'application_file.rb' }

  describe '#insert_into' do
    let(:insertion_file)    { fixture_file 'insertion.txt' }
      
    before :each do
      File.overwrite(insertion_file) do
        'Goodbye'
      end
    end
      
    after :each do
      File.delete insertion_file if File.file?(insertion_file)
    end

    context 'File object as target' do
      it "should insert Hello before Goodbye" do
        ins_file = File.new(insertion_file)
        ins_file.read_content.should match /Goodbye/

        ins_file.has_content?('Goodbye').should be_true
        
        File.insert_into ins_file, :before => 'Goodbye' do
          'Hello'
        end
        ins_file.read_content.should match /Hello\s+Goodbye/      
      end

      context 'content as block argument' do
        it "should insert Hello before Goodbye" do
          File.insert_into insertion_file, :before => 'Goodbye' do
            'Hello'
          end
          File.read(insertion_file).should match /Hello\s+Goodbye/      
        end
      end
    end

    describe '#insert instance method' do
      context 'content as block argument' do
        it "should insert Hello before Goodbye" do
          File.new(insertion_file).insert :before => 'Goodbye' do
            'Hello'
          end
          File.read(insertion_file).should match /Hello\s+Goodbye/      
        end
      end
  
      context 'content as String argument' do      
        it "should insert Hello before Goodbye using a content string arg" do
          File.insert_into insertion_file, "Hello ", :before => 'Goodbye'
          File.read(insertion_file).should match /Hello\s+Goodbye/
        end
      end
  
      context 'using a :content option' do
        it "should insert Hello before Goodbye" do
          File.insert_into insertion_file, :content => 'Hello', :before => 'Goodbye'
          File.read(insertion_file).should match /Hello\s+Goodbye/
        end
      end
  
      describe 'insert after' do
        context 'Regexp for the :after expression' do
          it "should insert Hello after Goodbye using a :content option" do
            File.insert_into insertion_file, :content => ' Hello', :after => /Goodbye/ 
            File.read(insertion_file).should match /Goodbye\s+Hello/
          end
        
          it "should work with an escaped Regexp matching" do
            pattern = Regexp.escape('::Application.initialize!')      
            File.insert_into app_file, :after => /\w+#{pattern}/ do
              'hello'
            end
            File.read(app_file).should match /hello/
          end
        end
      end
    end
  
    context 'routes file - String path' do
      it "should insert devise routes statement as first route statement" do
        File.insert_into routes_file, :after => 'routes.draw do' do
          'devise :users'
        end
        # puts File.read(routes_file)
        File.read(routes_file).should match /routes.draw\s+do\s+devise :users/
        File.remove_content_from routes_file, :content => 'devise :users'
      end    
    end
  
    context 'routes file - File obj' do
      it "should insert devise routes statement as first route statement" do
        File.insert_into File.new(routes_file), :after => 'routes.draw do' do
          'devise :users'
        end
        # puts File.read(routes_file)
        File.read(routes_file).should match /routes.draw\s+do\s+devise :users/
        File.remove_content_from routes_file, :content => 'devise :users'
      end
    end
  end
end