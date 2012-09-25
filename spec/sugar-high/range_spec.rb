require 'spec_helper'
require 'sugar-high/range'

describe Range do 
  describe '#intersection' do
    context 'inclusive range' do
      
      # Test an inclusive range
      subject { 5..10 } 

      let(:tests) do 
        {
        1..4   => nil,     # before
        11..15 => nil,     # after
        1..6   => 5..6,    # overlap_begin
        9..15  => 9..10,   # overlap_end
        1..5   => 5..5,    # overlap_begin_edge
        10..15 => 10..10,  # overlap_end_edge
        5..10  => 5..10,   # overlap_all
        6..9   => 6..9,    # overlap_inner

        1...5  => nil,     # before             (exclusive range)
        1...7  => 5..6,    # overlap_begin      (exclusive range)
        1...6  => 5..5,    # overlap_begin_edge (exclusive range)
        5...11 => 5..10,   # overlap_all        (exclusive range)
        6...10 => 6..9,    # overlap_inner      (exclusive range)
        }
      end

      it 'should intersect correctly' do
        tests.each do |other, expected|
          subject.intersect(other).should == expected
        end
      end
    end 

    context 'exclusive range' do 
      # Test an exclusive range
      # This covers a bug found by Montgomery Kosma in the original code
      subject { 1...10 } 
  
      let(:tests)  do 
        #overlap_end
        { 5..15 => 5..9}
      end
  
      it 'should intersect correctly' do
        tests.each do |other, expected|
          subject.intersect(other).should == expected
        end
      end
    end
  end
end