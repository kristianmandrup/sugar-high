class String  
  def path
    self.extend PathString
  end      
end

module PathString
  def to_file option=nil
    raise ArgumentError, "File doesn't exist" if option == :raise && !File.directory?(self)
    File.new(self) if File.file? self
  end
  alias_method :file, :to_file
  alias_method :new_file, :to_file

  def to_dir option=nil
    raise ArgumentError, "Dir doesn't exist" if option == :raise && !File.directory?(self)
    Dir.new(self) if File.directory? self
  end  
  alias_method :new_dir, :to_dir
  alias_method :dir, :to_dir

  def to_symlink new_path #, option=nil  
    # raise ArgumentError, "New link location doesn't exist" if option == :raise && !File.exist?(new_path)
    File.symlink(self, new_path)
  end
  alias_method :new_symlink, :to_symlink
  alias_method :symlink, :to_symlink
  
  def exists?  
    File.exist? self
  end
  alias_method :there?, :exists?

  def file?  
    File.file? self
  end
  alias_method :is_file?, :file?

  def dir?  
    File.directory? self
  end
  alias_method :is_dir?, :dir?
  alias_method :directory?, :dir

  def symlink?  
    File.symlink? self
  end
  alias_method :is_symlink?, :symlink?
  
  def up lv
    ('../' * lv) + self
  end

  def post_up lv
    self + ('/..' * lv)
  end

  def post_down lv
    up_dir = Regexp.escape('/..')
    orig = self.clone
    lv.times do
      self.gsub! /#{up_dir}$/, ''
      return self if self == orig
    end
    self
  end

  def down lv
    up_dir = Regexp.escape('../')
    orig = self.clone
    lv.times do
      self.gsub! /^#{up_dir}/, ''
      return self if self == orig
    end
    self
  end
end