require 'spec_helper'
require 'sugar-high/file'

describe "SugarHigh" do
  describe "File" do
    let(:empty_file)      { fixture_file 'empty.txt' }
    let(:non_empty_file)  { fixture_file 'non-empty.txt'} 
    let(:replace_file)    { fixture_file 'file.txt' }

    before :each do
      File.delete replace_file if File.file?(replace_file)
    end

    describe '#self.blank' do
      it "should return true for an empty file" do
        File.blank?(empty_file).should be_true 
      end

      it "should return false for a NON-empty file" do
        File.blank?(non_empty_file).should_not be_true
      end
    end

    describe '#blank' do    
      it "should return true for an empty file" do
        File.new(empty_file).blank?.should be_true
      end

      it "should return false for a NON-empty file" do
        File.new(non_empty_file).blank?.should_not be_true
      end
    end
  end

  describe '#file_names' do 
    let(:replace_file)    { fixture_file 'file.txt' }        
    
    before :each do
      File.delete replace_file if File.file?(replace_file)
    end    
       
    it "should return all file names of an array of paths to files" do
      expr = fixtures_dir + '/*.txt'
      Dir.glob(expr).file_names('txt').should == ['empty', 'non-empty']
    end
  end  

  describe '#read_from' do
    let(:non_empty_file)      { fixture_file 'non-empty.txt' }
                
    it "should read all the content into a block" do
      File.read_from non_empty_file do |content|
        content.should match /blip/
        content.should match /blup/        
      end
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
end
    
