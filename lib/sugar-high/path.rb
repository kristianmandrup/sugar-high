class String  
  def path
    self.extend PathString
  end      
end

module PathString
  def exists?  
    File.exist? self
  end

  def file?  
    File.file? self
  end

  def dir?  
    File.directory? self
  end

  def symlink?  
    File.symlink? self
  end
  
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