require "spec_helper"

describe Coords do
  
  before :each do
    @a = Coords.new(3,0,0)
    @b = Coords.new(0,0,3)
  end
  
  describe '#copyIn' do
    it "should copy b into a" do
      @a.copyIn(@b).z.should == 3
    end
  end
  
  describe '#distanceTo' do
    it "should be between 4 and 5" do
      @a.distanceTo(@b).should <= 4.25
    end
  end
  
  describe '#moveTo' do
    it "should a now be at b and return reached true" do
      @a.moveTo(@b,4.25).should == true
      @a.z.should == 3
    end
    it "should a now be on the way to b" do
      @a.moveTo(@b,1).should == false
      @a.z.should <= 1
    end
  end
end