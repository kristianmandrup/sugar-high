require 'spec_helper'
require 'sugar-high/file'
require 'sugar-high/file_mutate'

describe "SugarHigh" do
  describe "File" do
    let(:empty_file)      { fixture_file 'empty.txt' }
    let(:non_empty_file)  { fixture_file 'non-empty.txt'} 
    let(:replace_file)    { fixture_file 'file.txt' }
    let(:search_file)     { fixture_file 'search_file.txt' }

    before :each do
      File.delete replace_file if File.file?(replace_file)
    end

    describe '#self.blank?' do
      it "should return true for an empty file" do
        File.blank?(empty_file).should be_true 
      end

      it "should return false for a NON-empty file" do
        File.blank?(non_empty_file).should_not be_true
      end
    end

    describe '#blank?' do    
      it "should return true for an empty file" do
        File.new(empty_file).blank?.should be_true
      end

      it "should return false for a NON-empty file" do
        File.new(non_empty_file).blank?.should_not be_true
      end
    end

    describe '#has_content?' do
      it "should find content in file using String argument" do
        File.overwrite(search_file) do
          'Find this line right here!'
        end                
        File.has_content?(search_file, 'line right').should be_true
        File.has_content?(search_file, 'line left').should be_false
      end

      it "should find content in file using Regexp argument" do
        File.overwrite(search_file) do
          'Find this line right here!'
        end                
        File.has_content?(search_file, /line right/).should be_true
        File.has_content?(search_file, /line left/).should be_false
      end
    end
    
    describe '#read_from' do

      it "should read all the content into a block" do
        File.read_from non_empty_file do |content|
          content.should match /blip/
          content.should match /blup/        
        end
      end

      it "should read all the content before a given marker" do
        content = File.read_from non_empty_file, :before => 'blap'
        content.should match /blip/
        content.should_not match /blap/
      end

      it "should read all the content after a given marker" do
        content = File.read_from non_empty_file, :after => 'blap'
        content.should match /blup/
        content.should_not match /blap/
      end

      it "should read all the content before a given marker into a block" do
        File.read_from non_empty_file, :before => 'blap' do |content|
          content.should match /blip/
          content.should_not match /blap/        
        end
      end

      it "should read all the content after a given marker into a block" do
        File.read_from non_empty_file, :after => 'blap' do |content|
          content.should match /blup/
          content.should_not match /blap/        
        end
      end
    end  

    describe '#read_content (instance)' do
      let(:non_empty_file)      { fixture_file 'non-empty.txt' }

      it "should read all the content into a block" do
        File.new(non_empty_file).read_content do |content|
          content.should match /blip/
          content.should match /blup/        
        end
      end
    end    
    
    describe '#read_from (class)' do
      let(:non_empty_file)      { fixture_file 'non-empty.txt' }

      it "should read all the content into a block" do
        File.read_from(non_empty_file) do |content|
          content.should match /blip/
          content.should match /blup/        
        end
      end
    end        
  end
  
  describe "Array" do
    describe '#file_names' do 
      let(:replace_file)    { fixture_file 'file.txt' }
    
      before :each do
        File.delete replace_file if File.file?(replace_file)
      end    
       
      it "should return all file names of an array of paths to files" do
        expr = fixtures_dir + '/*.txt'
        Dir.glob(expr).file_names('txt').should include('empty', 'non-empty')
      end
    end
  end 
  
  describe "String" do
    describe '#new_file' do 
      let(:class_file)    { fixture_file 'class_file.txt' }
           
      it "should get the existing file" do
        class_file.new_file.path.should =~ /class_file/
      end
    end
    
    describe '#file' do 
      let(:class_file)    { fixture_file 'class_file.txt' }
           
      it "should get the file" do
        class_file.file.path.should =~ /class_file/
      end
    end

    describe '#dir' do            
      it "should get the dir" do
        fixtures_dir.path.dir.path.should =~ /fixtures/
      end
    end
  end
end
    
