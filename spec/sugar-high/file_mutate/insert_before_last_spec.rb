require 'spec_helper'
require 'sugar-high/file_mutate'

describe "Insert content" do
  let(:empty_file)      { fixture_file 'empty.txt' }
  let(:class_file)      { fixture_file 'class_file.rb'} 
  let(:routes_file)     { fixture_file 'routes_file.rb' }  
  let(:app_file)        { fixture_file 'application_file.rb' }

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


    describe '#insert before last' do
      context ':content option and :before_last option' do
        it "should insert Hello before last end statement" do
          File.insert_into class_file, :content => '  # Hello', :before_last => 'end' 
          puts File.read(class_file)
          File.read(class_file).should match /end\s+# Hello\s+end/
          File.remove_content_from class_file, :content => '  # Hello'
        end    
      end
  
      context ':content option and :before_last option and repeat=true' do      
        it "should insert Hello before last end statement but don't repeat" do
          File.insert_into class_file, :content => '  # Hello', :before_last => 'end', :no_repeat => true
          puts File.read(class_file)
          File.read(class_file).should match /end\s+# Hello\s+end/
          File.remove_content_from class_file, :content => '  # Hello'
        end    
      end

      context 'block content and :before_last' do            
        it "should insert Hello before last end statement" do
          File.insert_into class_file, :before_last => 'end' do
            '  # Hello'
          end
          puts File.read(class_file)
          File.read(class_file).should match /end\s+# Hello\s+end/
          File.remove_content_from class_file, :content => '  # Hello'
        end    
      end
    end
  end
end