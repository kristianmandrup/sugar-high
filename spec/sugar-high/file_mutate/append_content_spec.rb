require 'spec_helper'
require 'sugar-high/file_mutate'

describe "SugarHigh::File" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:replace_file)    { fixture_file 'file.txt' }

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
end