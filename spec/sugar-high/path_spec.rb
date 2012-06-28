require 'spec_helper'
require 'sugar-high/path'

describe 'String path ext' do
  describe '#path' do
    it "should return a String extended with PathString" do
      path_str = "a/b/c".path
      path_str.kind_of?(PathString).should be_true
      path_str.respond_to?(:up).should be_true
      path_str.respond_to?(:down).should be_true
    end
  end
end

describe 'PathString' do
  describe '#up' do
    it "should go up two folder levels before path" do
      up_path = "a/b/c".path.up(2)
      up_path.should == "../../a/b/c"
    end
  end

  describe '#post_up' do
    it "should go up two folder levels at end of path" do
      up_path = "a/b/c".path.post_up(2)
      up_path.should == "a/b/c/../.."
    end
  end


  describe '#down' do
    it "should go down two folder levels" do
      dwn_path = "../../a/b/c".path.down(2)
      dwn_path.should == "a/b/c"
    end
  end

  describe '#down' do
    it "should go down two folder levels at end of path" do
      dwn_path = "a/b/c/../..".path.post_down(2)
      dwn_path.should == "a/b/c"
    end
  end

  describe '#exists?' do
    it "should be true that this spec file exist" do
      "#{__FILE__}".path.exists?.should be_true
    end
  end

  describe '#file?' do
    it "should be true that this spec file exist" do
      "#{__FILE__}".path.file?.should be_true
    end
  end

  describe '#dir?' do
    it "should be false that this spec file is a directory" do
      "#{__FILE__}".path.dir?.should be_false
    end
  end

  describe '#symlink?' do
    it "should be false that this spec file is a symlink" do
      "#{__FILE__}".path.symlink?.should be_false
    end
  end
end