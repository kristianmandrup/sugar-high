require 'spec_helper'
require 'sugar-high/file_mutate'

describe "SugarHigh::File" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:non_empty_file)  { fixture_file 'non-empty.txt'} 
  let(:class_file)      { fixture_file 'class_file.rb'} 
  let(:replace_file)    { fixture_file 'file.txt' }
  let(:file_to_delete)  { fixture_file 'file_to_delete.txt' }
  let(:routes_file)     { fixture_file 'routes_file.rb' }  
  let(:app_file)        { fixture_file 'application_file.rb' }  
  
  describe '#remove_content_from with :where option' do
    let(:replace_file)    { fixture_file 'file.txt' }
  
    it "should remove content from existing file - class method" do
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.remove_content_from replace_file, :where => 'You'
      File.read(replace_file).should_not match /You/
    end
  
    it "should remove content from existing file - instance method #remove_content" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.new(replace_file).remove_content :where => 'You'
      File.read(replace_file).should_not match /You/
    end
  
  end
  
  describe '#remove_content_from with :content option' do    
    let(:replace_file)    { fixture_file 'file.txt' }    
  
    it "should remove content from existing file - class method" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.remove_content_from replace_file, :content => 'You'
      File.read(replace_file).should_not match /You/
    end
  
    it "should remove content from existing file - instance method #remove_content" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.new(replace_file).remove_content 'You'
      File.read(replace_file).should_not match /You/
    end
  end
  
  describe '#remove_from with String/Regexp argument that is content to remove' do    
    let(:replace_file)    { fixture_file 'file.txt' }    
  
    it "should remove content from existing file - class method" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.remove_from replace_file, 'You'
      File.read(replace_file).should_not match /You/
    end
                                                
    it "should remove content from existing file - instance method #remove" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.new(replace_file).remove_content 'You'
      File.read(replace_file).should_not match /You/
    end
  end
  
  describe '#remove_from with block argument that is content to remove' do    
    let(:replace_file)    { fixture_file 'file.txt' }    

    it "should work using File object as target" do      
      fr = File.new replace_file
      File.overwrite(fr) do
        'Hello You'
      end
      File.remove_from fr do 
        'You'
      end
      File.read(fr).should_not match /You/
    end
  
    it "should remove content from existing file - class method" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.remove_from replace_file do 
        'You'
      end
      File.read(replace_file).should_not match /You/
    end
  
    it "should remove content from existing file - instance method #remove" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.new(replace_file).remove  do 
        'You'
      end
      File.read(replace_file).should_not match /You/
    end
  end
end