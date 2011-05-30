require 'sugar_high/file_mutate'

class File
  include SugarHigh::FileMutate::Append
  extend SugarHigh::FileMutate::Append::ClassMethods

  include SugarHigh::FileMutate::Delete
  extend  SugarHigh::FileMutate::Delete::ClassMethods

  include SugarHigh::FileMutate::Insert
  extend  SugarHigh::FileMutate::Insert::ClassMethods

  include SugarHigh::FileMutate::Overwrite
  
  include SugarHigh::FileMutate::RemoveContent
  extend  SugarHigh::FileMutate::RemoveContent::ClassMethods

  include SugarHigh::FileMutate::ReplaceContent
  extend  SugarHigh::FileMutate::ReplaceContent::ClassMethods
end
  