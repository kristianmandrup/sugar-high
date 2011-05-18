require 'spec_helper'
require 'sugar-high/file_mutate'

describe "SugarHigh::File" do
  let(:file_to_delete)  { fixture_file 'file_to_delete.txt' }

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
end