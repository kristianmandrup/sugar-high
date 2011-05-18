require 'spec_helper'
require 'sugar-high/file_mutate'

describe "Overwrite file" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:content_file)    { fixture_file 'content_file.txt' }

  describe '#overwrite! (Class method)' do
    let (:content) { 'Overwritten!!!' }
  
    it 'should overwrite empty file' do      
      File.overwrite content_file do
        content
      end
      File.has_content?(content).should be_true
      File.delete! content_file
    end

    it 'should overwrite file content with new content, erasing the old' do
      File.overwrite content_file do
        content
      end

      new_content = "New content"
      File.overwrite content_file do
        new_content        
      end

      content_file.has_content?(content).should be_false
      content_file.has_content?(new_content).should be_true      
    end
  end
    
  describe '#overwrite! (instance)' do
    let (:content) { 'Overwritten!!!' }
  
    it 'should overwrite empty file' do      
      content_file.overwrite do
        content
      end
      content_file.has_content?(content).should be_true
      File.delete! content_file
    end

    it 'should overwrite file content with new content, erasing the old' do
      content_file.overwrite :with => content

      new_content = "New content"
      content_file.overwrite :with => new_content

      content_file.has_content?(content).should be_false
      content_file.has_content?(new_content).should be_true      
    end
  end
  
  describe '#overwrite with :content option' do      
    it 'should overwrite content' do      
      File.overwrite content_file, :with => content

      new_content = "New content"
      File.overwrite content_file, :with => new_content

      content_file.has_content?(content).should be_false
      content_file.has_content?(new_content).should be_true      
    end
  end 
end