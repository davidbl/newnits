require 'spec_helper'

describe 'Newnits' do
  it 'allows construction of a compound unit with per' do
    lambda{Newnits::Base.new(1,:foot).per(:second)}.should_not raise_error
  end

  context 'creating' do
    it 'returns a Base from the per call' do
      n = Newnits::Base.new(1,:foot).per(:second)
      n.should be_a Newnits::Base
    end

    it 'adds a denominator_unit to the Base with per' do
      n = Newnits::Base.new(1,:foot).per(:second)
      n.denominator_unit.should be_a Newnits::Unit
    end

    it 'populates the denominator_unit correctly' do
      n = Newnits::Base.new(1,:foot).per(:second)
      n.denominator_unit.name.should == :second
      n.denominator_unit.dimension.should == :time
      n.denominator_unit.exponent.should == 1
    end

    it 'populates the denominator_unit exponent correctly' do
      n = Newnits::Base.new(1,:foot).per(:second, 2)
      n.denominator_unit.name.should == :second
      n.denominator_unit.dimension.should == :time
      n.denominator_unit.exponent.should == 2
    end
  end # context 'creating'

  context 'converting' do
    it 'accepts additional arguments for conversions' do
      lambda{ Newnits::Base.new(1,:foot).per(:second).to(:inches, :per, :second)}.should_not raise_error
    end

    it 'assigns the additional arguments' do
      n = Newnits::Base.new(1,:foot).per(:second).to(:inches, :per, :second)
      n.denominator_unit.name.should == :second
      n.denominator_unit.dimension.should == :time
      n.denominator_unit.exponent.should == 1
    end

    it 'assigns the additional exponnent arguments' do
      n = Newnits::Base.new(1,:foot).per(:second).to(:inches, :per, :second, 2)
      n.denominator_unit.exponent.should == 2
    end

    it 'assigns a full complement of arguments' do
      n = Newnits::Base.new(1,:foot).squared.per(:second, 2).to(:inches, 2, :per, :second, 2)
      n.unit.name.should == :inch
      n.unit.dimension.should == :length
      n.unit.exponent.should == 2
      n.denominator_unit.name.should == :second
      n.denominator_unit.dimension.should == :time
      n.denominator_unit.exponent.should == 2
    end

    it 'should convert using the denominator units' do
      Newnits::Base.new(60,:foot).per(:minute).to(:feet, :per, :second).to_f.should == 1.0
    end

    it 'should convert both numerator and demoninator' do
      Newnits::Base.new(180,:foot).per(:minute).to(:yard, :per, :second).to_f.should == 1.0
    end


  end

end
