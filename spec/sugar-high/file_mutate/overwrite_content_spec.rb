require 'spec_helper'
require 'sugar-high/file_mutate'

describe "Overwrite file" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:non_empty_file)  { fixture_file 'non-empty.txt' }
  let(:content_file)    { fixture_file 'content_file.txt' }

  before :each do
    File.overwrite(content_file) do
      'Goodbye'
    end
  end

  describe 'File #overwrite class method' do
    describe '#overwrite with block arg' do
      context 'empty file' do 
        let (:content) { 'Overwritten!!!' }
  
        it 'should overwrite empty file' do      
          File.overwrite content_file do
            content
          end                        
          cf = File.new(content_file)
          cf.has_content?(content).should be_true
          cf.delete!
        end
      end
    
      context 'non-empty file' do     
        let (:content) { 'Overwritten!!!' }
        
        it 'should overwrite file content with new content, erasing the old' do
          File.overwrite content_file do
            content
          end

          new_content = "New content"
          File.overwrite content_file do
            new_content        
          end
          
          cf = File.new(content_file)
          cf.has_content?(content).should be_false
          cf.has_content?(new_content).should be_true      
        end
      end
    end
    
    describe '#overwrite! (instance)' do
      let (:content) { 'Overwritten!!!' }
  
      describe '#overwrite with block argument' do
        it 'should overwrite empty file' do      
          cf = File.new(content_file)
          cf.overwrite do
            content
          end
          cf.has_content?(content).should be_true
          File.delete! content_file
        end
      end

      describe '#overwrite using :with option arg' do
        it 'should overwrite file content with new content, erasing the old' do
          cf = File.new(content_file)
                    
          cf.overwrite :with => content

          new_content = "New content"
          cf.overwrite :with => new_content

          cf.has_content?(content).should be_false
          cf.has_content?(new_content).should be_true
        end
      end
    end
  end  
end