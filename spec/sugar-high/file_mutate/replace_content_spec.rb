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
end