require 'spec_helper'
require 'sugar-high/file_mutate'

describe "SugarHigh::File" do
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

    it "should work using a File object as target" do
      File.insert_into File.new(insertion_file), :before => 'Goodbye' do
        'Hello'
      end
      File.read(insertion_file).should match /Hello\s+Goodbye/      
    end
      
    it "should insert Hello before Goodbye using a block as content" do
      File.insert_into insertion_file, :before => 'Goodbye' do
        'Hello'
      end
      File.read(insertion_file).should match /Hello\s+Goodbye/      
    end
    
    it "should insert Hello before Goodbye using a block as content - instance method #insert" do
      File.new(insertion_file).insert :before => 'Goodbye' do
        'Hello'
      end
      File.read(insertion_file).should match /Hello\s+Goodbye/      
    end
    
      
    it "should insert Hello before Goodbye using a content string arg" do
      File.insert_into insertion_file, "Hello ", :before => 'Goodbye'
      File.read(insertion_file).should match /Hello\s+Goodbye/
    end
      
    it "should insert Hello before Goodbye using a :content option" do
      File.insert_into insertion_file, :content => 'Hello', :before => 'Goodbye'
      File.read(insertion_file).should match /Hello\s+Goodbye/
    end
      
    it "should insert Hello before Goodbye using a block as content to insert" do
      File.insert_into insertion_file, :before => 'Goodbye' do
        'Hello'
      end
      File.read(insertion_file).should match /Hello\s+Goodbye/
    end
      
    it "should insert Hello after Goodbye using a :with option and a Regexp for the after expression" do
      File.insert_into insertion_file, :content => ' Hello', :after => /Goodbye/ 
      File.read(insertion_file).should match /Goodbye\s+Hello/
    end

    it "should insert Hello after Goodbye using a :with option and a Regexp for the after expression" do

      pattern = Regexp.escape('::Application.initialize!')      
      File.insert_into app_file, :after => /\w+#{pattern}/ do
        'hello'
      end
      File.read(app_file).should match /hello/
    end
    
    it "should insert Hello before last end statement" do
      File.insert_into class_file, :content => '  # Hello', :before_last => 'end' 
      puts File.read(class_file)
      File.read(class_file).should match /end\s+# Hello\s+end/
      File.remove_content_from class_file, :content => '  # Hello'
    end    
      
    it "should insert Hello before last end statement but don't repeat" do
      File.insert_into class_file, :content => '  # Hello', :before_last => 'end', :repeat => true 
      puts File.read(class_file)
      File.read(class_file).should match /end\s+# Hello\s+end/
      File.remove_content_from class_file, :content => '  # Hello'
    end    
      
    it "should insert Hello before last end statement - block" do
      File.insert_into class_file, :before_last => 'end' do
        '  # Hello'
      end
      puts File.read(class_file)
      File.read(class_file).should match /end\s+# Hello\s+end/
      File.remove_content_from class_file, :content => '  # Hello'
    end    
    
    it "should insert devise routes statement as first route statement" do
      File.insert_into routes_file, :after => 'routes.draw do' do
        'devise :users'
      end
      puts File.read(routes_file)
      File.read(routes_file).should match /routes.draw\s+do\s+devise :users/
      File.remove_content_from routes_file, :content => 'devise :users'
    end    
  end 
end