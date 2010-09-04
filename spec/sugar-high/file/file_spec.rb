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
end
    