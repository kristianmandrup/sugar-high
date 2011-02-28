require 'spec_helper'
require 'sugar-high/file_mutate'

describe "SugarHigh::File" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:non_empty_file)  { fixture_file 'non-empty.txt'} 
  let(:class_file)      { fixture_file 'class_file.rb'} 
  let(:replace_file)    { fixture_file 'file.txt' }
  let(:file_to_delete)  { fixture_file 'file_to_delete.txt' }
  let(:routes_file)     { fixture_file 'routes_file.rb' }  

  after do
    File.overwrite class_file do
      %q{class Abc
  def begin
  end
end}
    end   
  end

  before :each do
    File.delete replace_file if File.file?(replace_file)
  end

  describe '#delete! (class)' do      
    it 'should delete file' do      
      File.overwrite(file_to_delete) do
        'Delete this!'
      end
      File.delete! file_to_delete
      File.exist?(file_to_delete).should be_false 
    end
  end

  describe '#delete_file! (class)' do      
    it 'should delete file' do      
      File.overwrite(file_to_delete) do
        'Delete this!'
      end
      File.delete_file! file_to_delete
      File.exist?(file_to_delete).should be_false 
    end
  end

  describe '#delete! (instance)' do      
    it 'should delete file' do      
      File.overwrite(file_to_delete) do
        'Delete this!'
      end
      File.new(file_to_delete).delete!
      File.exist?(file_to_delete).should be_false 
    end
  end

  describe '#delete_file! (instance)' do      
    it 'should delete file' do      
      File.overwrite(file_to_delete) do
        'Delete this!'
      end
      File.new(file_to_delete).delete_file!
      File.exist?(file_to_delete).should be_false 
    end
  end

  describe '#append with :content option' do    
    let(:append_file)    { fixture_file 'file.txt' }
  
    it 'should append content to existing file - class method' do      
      File.overwrite(append_file) do
        'Hello You'
      end
      File.append append_file, :content => 'Appended'
      content = File.read(append_file)
      content.should match /Hello You/
      content.should match /Appended/      
    end

    it 'should append content to existing file - instance method' do      
      File.overwrite(append_file) do
        'Hello You'
      end
      File.new(append_file).append :content => 'Appended'
      content = File.read(append_file)
      content.should match /Hello You/
      content.should match /Appended/      
    end
  end

  describe '#append with block' do    
    let(:append_file)    { fixture_file 'file.txt' }
  
    it "should append content to existing file using block arg - class method" do      
      File.overwrite(append_file) do
        'Hello You'
      end
      File.append append_file do
        'Appended'
      end
      content = File.read(replace_file)
      content.should match /Hello You/
      content.should match /Appended/      
    end

    it "should append content to existing file using block arg - instance method" do      
      File.overwrite(append_file) do
        'Hello You'
      end
      File.new(append_file).append do
        'Appended'
      end
      content = File.read(replace_file)
      content.should match /Hello You/
      content.should match /Appended/      
    end
  end
  
  
  describe '#replace_content_from' do    
    let(:replace_file)    { fixture_file 'file.txt' }
  
    it "should replace content from existing file - class method" do      
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.replace_content_from replace_file, :where => 'You', :with => 'Me'
      File.read(replace_file).should_not match /You/              
    end

    it 'should remove content from existing file - instance method #replace_content' do
      File.overwrite(replace_file) do
        'Hello You'
      end
      File.new(replace_file).replace_content :where => 'You', :with => 'Me'
      File.read(replace_file).should_not match /You/
    end
  end
  
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