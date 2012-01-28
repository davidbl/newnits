require 'spec_helper'
class DummyClass
end

describe 'Newnits' do
  before(:each) do
    @dummy = DummyClass.new
    @dummy.extend(Newnits)
  end

  it 'should pass a simple test' do
    true
  end

  it 'should give units methods do the extended object' do
    lambda{ @dummy.meters}.should_not raise_error
    lambda{ @dummy.meter}.should_not raise_error
    lambda{ @dummy.foot}.should_not raise_error
    lambda{ @dummy.feet}.should_not raise_error
    lambda{ 'a'.feet}.should raise_error
  end

  it 'should return a Newnits class' do
    @dummy.meters.should be_a Newnits::Base
    1.meters.should be_a Newnits::Base
    1.2.meters.should be_a Newnits::Base
  end

  it 'should take a symbol argument when converting' do
    1.meters.to(:feet).should be_a Newnits::Base
  end

  it 'should do some conversions' do
    1.kilometer.to(:meters).to_f.should == 1_000
    1.foot.to(:inches).to_f.should == 12
    12.inches.to(:feet).to_f.should == 1
  end


  it 'should not raise an error when units are compatible' do
    lambda{ 1.foot.to(:inches)}.should_not raise_error
  end

  it 'should raise an error when units are NOT compatible' do
    lambda{ 1.hour.to(:inches)}.should raise_error Newnits::IncompatibleUnitsError
  end


  context 'exponents and powers' do
    it 'should raise an error is the exponents are not compatible' do
      lambda{ 1.foot.squared.to(:inches)}.should raise_error 
    end

    it 'should understand an exponent' do
      1.meter.squared.should be_a Newnits::Base
      1.meter.cubed.should be_a Newnits::Base
      1.meter.to_the(5).should be_a Newnits::Base
    end

    it 'should store the exponent' do
      1.meter.squared.exponent.should == 2
      1.meter.cubed.exponent.should == 3
      1.meter.to_the(4).exponent.should == 4
    end

    it 'should be able to convert an exponential unit' do
      1.foot.squared.to(:inches,2).to_f.should == 144.0
    end

    it 'should convert' do
      1.foot.to_the(3).to(:inches,3).to_f.should == 1728.0
    end

    # it 'should convert' do
    #   1.acre.to(:feet_squared).to_f.should == 43560
    # end

    # it 'should convert' do
    #   1.acre.to(:square_feet).to_f.should == 43560
    # end

    it 'should convert' do
      1.acre.to(:feet, 2).to_f.should == 43560
    end

    it 'should convert' do
      1.hectare.to(:meters,2).to_f.should == 10_000
      # 1.hectare.to(:meters_squared).to_f.should == 10_000
    end

    # it 'should convert' do
    #   1.hectare.to(:square_meters).to_f.should == 10_000
    # end

    it 'should convert' do
      1.liter.to(:meters, 3).to_f.should == 0.001
    end

    # it 'should convert' do
    #   1.liter.to(:meters_cubed).to_f.should == 0.001
    # end

    it 'should convert' do
      2.meters.cubed.to(:liters).to_f.should == 2_000
    end

    it 'should be able to convert a unit that has a power' do
      1.gallon.to(:liters).to_f.should == 4.54609
    end
  end # context 'exponents and powers'

  context 'adding units' do
    it 'should let me add a unit' do
      lambda{ 8.furlongs}.should raise_error
      Newnits::Units.add [:furlong, Rational('201.168'), :length]
      8.furlongs.to(:miles).to_f.should == 1
    end
  end # context 'adding units'


end
