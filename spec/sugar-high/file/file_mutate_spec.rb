require 'spec_helper'
require 'sugar-high/file'

describe "SugarHigh::File" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:non_empty_file)  { fixture_file 'non-empty.txt'} 
  let(:replace_file)    { fixture_file 'file.txt' }

  before :each do
    File.delete replace_file if File.file?(replace_file)
  end

  describe '#replace_content_from' do    
    let(:replace_file)    { fixture_file 'file.txt' }
  
    it "should remove content from existing file" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.replace_content_from replace_file, :where => 'You', :with => 'Me'
      File.read(replace_file).should_not match /You/              
    end
  end

  describe '#remove_content_from with :where option' do    
    let(:replace_file)    { fixture_file 'file.txt' }    
  
    it "should remove content from existing file" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.remove_content_from replace_file, :where => 'You'
      File.read(replace_file).should_not match /You/
    end
  end

  describe '#remove_content_from with :content option' do    
    let(:replace_file)    { fixture_file 'file.txt' }    
  
    it "should remove content from existing file" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.remove_content_from replace_file, :content => 'You'
      File.read(replace_file).should_not match /You/
    end
  end


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

    it "should insert Hello before Goodbye using a block as content" do
      File.insert_into insertion_file, :before => 'Goodbye' do
        'Hello'
      end
    end

    it "should insert Hello before Goodbye using a content string arg" do
      File.insert_into insertion_file, "Hello ", :before => 'Goodbye'
      File.read(insertion_file).should_not match /Hello Goodbye/
    end

    it "should insert Hello before Goodbye using a :content option" do
      File.insert_into insertion_file, :content => 'Hello ', :before => 'Goodbye'
      File.read(insertion_file).should_not match /Hello Goodbye/
    end

    it "should insert Hello before Goodbye using a block as content to insert" do
      File.insert_into insertion_file, :before => 'Goodbye' do
        'Hello '
      end
      File.read(insertion_file).should_not match /Hello Goodbye/
    end

    it "should insert Hello after Goodbye using a :with option and a Regexp for the after expression" do
      File.insert_into insertion_file, :content => ' Hello', :after => /Goodbye/ 
      File.read(insertion_file).should_not match /Goodbye Hello/
    end
  end
end