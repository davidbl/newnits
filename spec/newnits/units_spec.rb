require 'spec_helper'

describe 'Units' do
  it 'should read the unit definitions from a file' do
    Newnits.extend_to_numeric
    lambda{ 2.mowgli }.should raise_error
    lambda{ 2.homer }.should raise_error
    file_path ||= File.join(File.dirname(__FILE__), '..','fixtures', 'additional_units.yml') 
    Newnits::Units.add file_path
    lambda{ 2.mowgli }.should_not raise_error
    lambda{ 2.homer }.should_not raise_error
    1.mowgli.to(:meters).to_i.should == 5
    1.homer.to(:seconds).to_i.should == 10
    2.mowglis.to(:meters).to_i.should == 10
    2.homers.to(:seconds).to_i.should == 20
  end

  it 'should let me add a single unit' do
    lambda{ 8.furlongs}.should raise_error
    Newnits::Units.add [:furlong, Rational('201.168'), :length]
    8.furlongs.to(:miles).to_f.should == 1
  end
end
